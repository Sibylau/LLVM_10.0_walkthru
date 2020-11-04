//=======================================================================
// 
// Reference: https://llvm.org/doxygen/DCE_8cpp_source.html
//=======================================================================

#include "llvm/Pass.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"
#include "llvm/Transforms/Utils/LoopUtils.h"
#include "llvm/Transforms/Utils/FunctionComparator.h"
#include "llvm/Analysis/LoopPass.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/ScalarEvolution.h"
#include "llvm/Analysis/AssumptionCache.h"
#include "llvm/Analysis/TargetTransformInfo.h"
#include <tuple>
#include <map> 

using namespace llvm;

#define DEBUG_TYPE "loopive"

namespace {
  class MyPass : public LoopPass {
  public:
    static char ID;
    MyPass() : LoopPass(ID) {}

  private:
    // LCSSA form makes instruction rnaming easier
    void getAnalysisUsage(AnalysisUsage &AU) const override {
      AU.addRequired<LoopInfoWrapperPass>();
      AU.addPreserved<LoopInfoWrapperPass>();
      AU.addRequired<TargetTransformInfoWrapperPass>();
      AU.addRequired<AssumptionCacheTracker>();
      AU.addRequired<DominatorTreeWrapperPass>();
      AU.addPreserved<DominatorTreeWrapperPass>();
      AU.addRequired<ScalarEvolutionWrapperPass>();
      AU.addPreserved<ScalarEvolutionWrapperPass>();
      getLoopAnalysisUsage(AU);
    }
  
    bool runOnLoop(Loop *L, LPPassManager &LPM) override {
      if (skipLoop(L))
        return false;

      static LLVMContext TheContext;
      Function &F = *L->getHeader()->getParent();
      LLVMContext &Ctx = F.getContext();
      
      LoopInfo *LI = &getAnalysis<LoopInfoWrapperPass>().getLoopInfo();
      const auto *TTI = &getAnalysis<TargetTransformInfoWrapperPass>().getTTI(F);
      auto *AC = &getAnalysis<AssumptionCacheTracker>().getAssumptionCache(F);
      auto &DT = getAnalysis<DominatorTreeWrapperPass>().getDomTree();
      auto &SE = getAnalysis<ScalarEvolutionWrapperPass>().getSE();
      if (!L->isLoopSimplifyForm())
      //translate to simplify form first
        LLVM_DEBUG(dbgs() << "Warning: operating on a non-simplified loop. Please \
        consider simplify first.\n");

      // tuple<Instruction/derived_iv, mul_const, shift_const>
      std::map<Value*, std::tuple<Instruction*, int, int>> workmap;
      std::map<Value*, std::tuple<Instruction*, int, int>> phimap;

      // in canonical form, ind var is guaranteed to be the first phi node
      BasicBlock *L_header = L->getHeader();
      PHINode *indvar;
      std::tuple<Instruction*, int, int> indvar_tuple;
      for (PHINode &pn : L_header->phis()) {
        indvar = &pn;
        // indvar->print(llvm::errs());
        break;
      }
      assert(indvar);
      Instruction *indvar_instr = dyn_cast<Instruction>(indvar);
      std::get<0>(indvar_tuple) = indvar_instr;
      std::get<1>(indvar_tuple) = 1; // assume the base ind var has the form i += e
      std::get<2>(indvar_tuple) = 0;
      workmap[indvar_instr] = indvar_tuple;
      // llvm::errs() << "\n tuple (" << std::get<0>(indvar_tuple) << ", " << std::get<1>(indvar_tuple)
      //   << ", " << std::get<2>(indvar_tuple) << ") \n";

      // get the basic ind var, the increment instruction and shifting amount
      int base_shift;
      Instruction *base_shift_inst;
      Value *base_init_val;
      // assert(indvar->getNumIncomingValues() == 2);
      if (indvar->getNumIncomingValues() == 2) {
        for(unsigned i = 0, e = indvar->getNumIncomingValues(); i != e; ++i) {
          BasicBlock *income_b = indvar->getIncomingBlock(i);
          Value *income_v = indvar->getIncomingValue(i);
          if (income_b != L->getLoopPreheader()) {
            if (auto *op = dyn_cast<BinaryOperator>(income_v)) {
              base_shift_inst = dyn_cast<Instruction>(income_v);
              // base_shift_inst->print(llvm::errs());
              Value *lhs = op->getOperand(0);
              Value *rhs = op->getOperand(1);
              if (dyn_cast<Instruction>(lhs) == indvar_instr) {
                base_shift = dyn_cast<ConstantInt>(rhs)->getSExtValue();
              }
              else if (dyn_cast<Instruction>(rhs) == indvar_instr) {
                base_shift = dyn_cast<ConstantInt>(lhs)->getSExtValue();
              }
            }
          }
          else {
            base_init_val = indvar->getIncomingValue(i);
          }
        }
      }
      else
        LLVM_DEBUG(dbgs() << "The Basic Induction Variable has abnormal PHINode.\n");
     
      // llvm::errs() << "\nshift = " << base_shift <<"\n";
      // Instruction *BrInst = L_header->getTerminator();
      // // get the loop exit condition instruction
      // Instruction *Cmp, *IV;
      // if (Cmp = dyn_cast<Instruction> (BrInst->getOperand(0)))
      //   IV = dyn_cast<Instruction> (Cmp->getOperand(0));
      // // if (Cmp = dyn_cast<Instruction> (BrInst->getOperand(0))) {
      // //   Cmp->print(llvm::errs());
      // //   if (IV = dyn_cast<Instruction> (Cmp->getOperand(0)))
      // //     IV->print(llvm::errs());
      // // }
      // if (!Cmp || !IV)
      //   LLVM_DEBUG(dbgs() << "Not able to find the base loop induction variable \
      //   in function" << L->getHeader()->getParent()->getName() << ", loop " 
      //   << L->getName() << ".\n");

      // get the tuples of all derived ind vars 
      for (auto &B: L->getBlocks()) {
        if (B == L->getHeader() || B == L->getExitBlock())
          continue;

        for (auto &I: *B) {
          if (&I == base_shift_inst)
            continue;
          if (auto *op = dyn_cast<BinaryOperator>(&I)) {
            Value *lhs = op->getOperand(0);
            Value *rhs = op->getOperand(1);
            
            if (op->getOpcode() == Instruction::Mul) {
              if (workmap.count(lhs)) {
                if (auto *CR = dyn_cast<ConstantInt>(rhs)) {
                  int mul_const = CR->getSExtValue();
                  int new_mul_const_0 = mul_const * std::get<1>(workmap[lhs]);
                  int new_mul_const_1 = mul_const * std::get<2>(workmap[lhs]);
                  workmap[&I] = std::make_tuple(indvar_instr, new_mul_const_0, new_mul_const_1);
                }
              }
              else if(workmap.count(rhs)) {
                if (auto *CL = dyn_cast<ConstantInt>(lhs)) {
                  int mul_const = CL->getSExtValue();
                  int new_mul_const_0 = mul_const * std::get<1>(workmap[rhs]);
                  int new_mul_const_1 = mul_const * std::get<2>(workmap[rhs]);
                  workmap[&I] = std::make_tuple(indvar_instr, new_mul_const_0, new_mul_const_1);
                }
              }
            }
            else if (op->getOpcode() == Instruction::Add) {
              if (workmap.count(lhs)) {
                if (auto *CR = dyn_cast<ConstantInt>(rhs)) {
                  int add_const = CR->getSExtValue();
                  int new_add_const = add_const + std::get<2>(workmap[lhs]);
                  workmap[&I] = std::make_tuple(indvar_instr, std::get<1>(workmap[lhs]), new_add_const);
                }
              }
              else if (workmap.count(rhs)) {
                if (auto *CL = dyn_cast<ConstantInt>(lhs)) {
                  int add_const = CL->getSExtValue();
                  int new_add_const = add_const + std::get<2>(workmap[rhs]);
                  workmap[&I] = std::make_tuple(indvar_instr, std::get<1>(workmap[lhs]), new_add_const);
                }
              }
            }
            else if (op->getOpcode() == Instruction::Sub) {
              if (workmap.count(lhs)) {
                if (auto *CR = dyn_cast<ConstantInt>(rhs)) {
                  int sub_const = CR->getSExtValue();
                  int new_sub_const = std::get<2>(workmap[lhs]) - sub_const;
                  workmap[&I] = std::make_tuple(indvar_instr, std::get<1>(workmap[lhs]), new_sub_const);
                }
              }
              else if (workmap.count(rhs)) {
                if (auto *CL = dyn_cast<ConstantInt>(lhs)) {
                  int sub_const = CL->getSExtValue();
                  int new_sub_const = std::get<2>(workmap[rhs]) - sub_const;
                  workmap[&I] = std::make_tuple(indvar_instr, std::get<1>(workmap[lhs]), new_sub_const);
                }
              }
            }
          }
        }
      }
      // llvm::errs() << "\n";
      // for (auto it = workmap.begin(); it != workmap.end(); ++it) {
      //   llvm::errs() << "BB: " << dyn_cast<Instruction>(it->first)->getParent()->getName() << 
      //    "\n\tkey [" << it->first << "]\n\tval [" << std::get<0>(it->second)
      //   << ", " << std::get<1>(it->second) << ", " << std::get<2>(it->second) <<"]\n";
      // }

      // modify instructions
      bool change = false;
      for (auto itr = workmap.begin(); itr != workmap.end(); ++itr) {
        Instruction *dr_instr = dyn_cast<Instruction>(itr->first);
        auto dr_tuple = itr->second;
        
        if(dr_instr == indvar_instr) 
          continue;

        BasicBlock *L_preheader = L->getLoopPreheader();
        IRBuilder<> builder(TheContext);
        Value *dr_init_val;
        if (auto *base_const = dyn_cast<ConstantInt>(base_init_val)) {
          // add init value in loop header
          int base_init = base_const->getSExtValue();
          int dr_init = base_init * std::get<1>(dr_tuple) + std::get<2>(dr_tuple);
          dr_init_val = ConstantInt::getSigned(base_init_val->getType(), dr_init);
        } else {
          // add init value in loop pre-header          
          builder.SetInsertPoint(L_preheader->getTerminator());
          dr_init_val = builder.CreateMul(base_init_val, 
            ConstantInt::getSigned(base_init_val->getType(), std::get<1>(dr_tuple)));
          dr_init_val = builder.CreateAdd(dr_init_val, 
            ConstantInt::getSigned(base_init_val->getType(), std::get<2>(dr_tuple)));
        }

        // add phi node in loop header
        builder.SetInsertPoint(indvar_instr->getNextNode());
        PHINode *new_phi = builder.CreatePHI(indvar->getType(), 2);
        new_phi->addIncoming(dr_init_val, L_preheader);

        // add increment in loop body after i += e
        builder.SetInsertPoint(base_shift_inst->getNextNode());
        int incr = std::get<1>(dr_tuple) * base_shift;
        Value *new_incr = builder.CreateAdd(new_phi, 
          ConstantInt::getSigned(new_phi->getType(), incr));
        new_phi->addIncoming(new_incr, base_shift_inst->getParent());        

        // eliminates multiplications 
        dr_instr->replaceAllUsesWith(new_phi);
        dr_instr->eraseFromParent();
        // Instruction *new_phi_inst = dyn_cast<Instruction>(new_phi);
        llvm::errs() << "new_phi: ";
        new_phi->print(llvm::errs());
        llvm::errs() << "\n";
        phimap[new_phi] = dr_tuple;

        change = true;
      }
      
      // remove the basic induction variable
      bool deletable = true;
      for (auto it: indvar->users()) {
        if (auto *I =  dyn_cast<Instruction>(it)) {
          // if have uses other than in the loop header and increment
          if(I->getParent() == L->getHeader())
            continue;
          else if(I == base_shift_inst)
            continue;
          else {
            I->print(llvm::errs());
            llvm::errs() << "\n";
            deletable = false;
          }
        }
      }
      llvm::errs() << "deletale = " <<deletable << " | phimpa_empty = " <<phimap.empty()<<"\n";
      if (deletable && !phimap.empty()) {
        Instruction *BrInst = L->getHeader()->getTerminator(); // assume the terminator is a br
        Value *lhs = BrInst->getOperand(0);
        Value *rhs = BrInst->getOperand(1);
        ICmpInst *Cmp;
        if (Cmp = dyn_cast<ICmpInst>(lhs)) ;
        else if (Cmp = dyn_cast<ICmpInst>(rhs)) ;
        else
          LLVM_DEBUG(dbgs() << "Not a regular ICmp loop condition.");
        
        llvm::errs() << Cmp-> getPredicate() << ", " << Cmp->getOperand(0) 
        << ", " << Cmp->getOperand(1) << "\n";
        auto new_indvar = phimap.begin();
        
        // dyn_cast<Instruction>(new_indvar->first)->print(llvm::errs());
        // llvm::errs() <<"\n\t["<<std::get<0>(new_indvar->second)
        //   << "," << std::get<1>(new_indvar->second) << "," << std::get<2>(new_indvar->second) <<"]\n";
        int base_bound, new_bound;
        Instruction *new_icmp;
        if (auto *base_b_const = dyn_cast<ConstantInt>(Cmp->getOperand(0))) {
          base_bound = base_b_const->getSExtValue();
          llvm::errs() << "base_bound: " << base_bound << "\n";
          new_bound = base_bound * std::get<1>(new_indvar->second) + 
            std::get<2>(new_indvar->second);
          Cmp->setOperand(0, ConstantInt::getSigned(new_indvar->first->getType(), new_bound));
          Cmp->setOperand(1, new_indvar->first);
        }
        else if (auto *base_b_const = dyn_cast<ConstantInt>(Cmp->getOperand(1))) {
          base_bound = base_b_const->getSExtValue();
          llvm::errs() << "base_bound: " << base_bound << "\n";
          new_bound = base_bound * std::get<1>(new_indvar->second) + 
            std::get<2>(new_indvar->second);
          llvm::errs() << "new_bound: " << new_bound << "\n";
          Cmp->setOperand(1, ConstantInt::getSigned(new_indvar->first->getType(), new_bound));
          Cmp->setOperand(0, new_indvar->first);
          Cmp->print(llvm::errs());
          llvm::errs() << "\n";
        }
        // indvar->removeFromParent();
        // base_shift_inst->removeFromParent();
      }

      // if (deletable) {
      //   indvar->removeFromParent();
      //   base_shift_inst->removeFromParent();
      // }

      // delete all redundant induction variables 
      if (!phimap.empty()) {
        phimap[indvar] = indvar_tuple;
        for (auto it = phimap.begin(); it != phimap.end(); ++it) {
          dyn_cast<Instruction>(it->first)->print(llvm::errs());
          llvm::errs() <<"\n\t["<<std::get<0>(it->second) << "," << 
          std::get<1>(it->second) << "," << std::get<2>(it->second) <<"]\n";
        }

        for (auto it = phimap.begin(); it != phimap.end(); ++it) {
          if (auto *I =  dyn_cast<Instruction>(it->first)) {
            bool remove_indvar = false;
            I->print(llvm::errs());
            llvm::errs() << "\n"; 
            // removable if the only use is an in/decrement
            if (I->getNumUses() == 1) {
              for (auto u: I->users()) {
                if (auto *use_inst = dyn_cast<Instruction>(u)) {
                  if (use_inst->getOpcode() == Instruction::Add ||
                      use_inst->getOpcode() == Instruction::Sub)
                    remove_indvar = true;
                }
                break;
              }
            }
            // for (auto u: I->users()) {
            //   if (auto *use_inst = dyn_cast<Instruction>(u)) {
            //     if(use_inst->getParent() == L->getHeader())
            //       continue;
            //     else if(use_inst == base_shift_inst)
            //       continue;
            //     else {
            //       I->print(llvm::errs());
            //       llvm::errs() << "\n";
            //       remove_indvar = false;
            //     }
            //   }
            // }
            llvm::errs() <<"remove_indvar = "<<remove_indvar<<"\n";
            if (remove_indvar && I->getNumUses() == 1) {
              // if have uses other than in the loop header and increment
              for (auto u: I->users()) {
                if (auto *use_inst = dyn_cast<Instruction>(u)) {
                  use_inst->removeFromParent();
                }
              }
              I->removeFromParent();
            }
            else
              continue;
          }
        }
      }

      llvm::errs() << "for_end!!\n";
      workmap.clear();
      phimap.clear();
      return change;
    }
  };
}

char MyPass::ID = 0;

static RegisterPass<MyPass> X("loopive", "Loop Induction Var Elimination Pass",
                             false /* Only looks at CFG */,
                             true /* Transform Pass */);

static RegisterStandardPasses Y(
    PassManagerBuilder::EP_EarlyAsPossible,
    [](const PassManagerBuilder &Builder,
       legacy::PassManagerBase &PM) { PM.add(new MyPass()); });
