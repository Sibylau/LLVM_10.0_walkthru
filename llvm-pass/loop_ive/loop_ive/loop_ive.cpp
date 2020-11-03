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
      
      Function &F = *L->getHeader()->getParent();
      
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
      std::map<Instruction*, std::tuple<Instruction*, int, int>> workmap;

      // in canonical form, ind var is guaranteed to be the first phi node
      BasicBlock *L_header = L->getHeader();
      Instruction *indvar;
      std::tuple<Instruction*, int, int> indvar_tuple;
      for (PHINode &pn : L_header->phis()) {
        indvar = dyn_cast<Instruction>(&pn);
        break;
      }
      std::get<0>(indvar_tuple) = indvar;
      std::get<1>(indvar_tuple) = 1; // assume the base ind var has the form i += e
      std::get<2>(indvar_tuple) = 0;
      workmap.insert({indvar, indvar_tuple});

      int base_shift;
      Instruction *base_shift_inst;
      Value *base_init_inst;
      for(unsigned i = 0; i < dyn_cast<PHINode>(indvar)->getNumIncomingValues(); i++) {
        BasicBlock *income_b = dyn_cast<PHINode>(indvar)->getIncomingBlock(i);
        if (L->contains(income_b)) {
          Value *income_v = dyn_cast<PHINode>(indvar)->getIncomingValue(i);
          if (auto *op = dyn_cast<BinaryOperator>(income_v)) {
            base_shift_inst = dyn_cast<Instruction>(income_v);
            Value *lhs = op->getOperand(0);
            Value *rhs = op->getOperand(1);
            if (dyn_cast<Instruction>(lhs) == indvar) {
              int base_shift = dyn_cast<ConstantInt>(rhs)->getSExtValue();
              // std::get<2>(indvar_tuple) = base_shift;
            }
            else if (dyn_cast<Instruction>(rhs) == indvar) {
              int base_shift = dyn_cast<ConstantInt>(lhs)->getSExtValue();
              // std::get<2>(indvar_tuple) = base_shift;
            }
          }
        }
        else {
          base_init_inst = dyn_cast<PHINode>(indvar)->getIncomingValue(i);
        }
      }
      
      
      // for (auto &I: *L_header) {
      //   if (auto *op = dyn_cast<BinaryOperator>(&I)) {
      //     Value *lhs = I.getOperand(0);
      //     Value *rhs = I.getOperand(1);
      //     if (I.getOpcode() == Instruction::Mul) {
      //       if (dyn_cast<Instruction>(lhs) == indvar) {
      //         int mul_const = dyn_cast<ConstantInt>(rhs)->getSExtValue();
      //         std::get<1>(base_indvar) = mul_const;
      //       }
      //       else if (dyn_cast<Instruction>(rhs) == indvar) {
      //         int mul_const = dyn_cast<ConstantInt>(lhs)->getSExtValue();
      //         std::get<1>(base_indvar) = mul_const;
      //       }
      //       else
      //         continue;
      //     }
      //     else if (I.getOpcode() == Instruction::Add) {

      //     }
      //     else if (I.getOpcode() == Instruction::Sub) {

      //     }
      //   }
      // }
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
          // I.print(llvm::errs());
          // llvm::errs() << "\n";
          if (auto *op = dyn_cast<BinaryOperator>(&I)) {
            Instruction *lhs = dyn_cast<Instruction>(op->getOperand(0));
            Instruction *rhs = dyn_cast<Instruction>(op->getOperand(1));
            if (op->getOpcode() == Instruction::Mul) {
              if (workmap.count(lhs) && dyn_cast<ConstantInt>(rhs)) {
                int mul_const = dyn_cast<ConstantInt>(rhs)->getSExtValue();
                int new_mul_const_0 = mul_const * std::get<1>(workmap[lhs]);
                int new_mul_const_1 = mul_const * std::get<2>(workmap[lhs]);
                workmap[&I] = std::make_tuple(indvar, new_mul_const_0, new_mul_const_1);
              }
              else if(workmap.count(rhs) && dyn_cast<ConstantInt>(lhs)) {
                int mul_const = dyn_cast<ConstantInt>(lhs)->getSExtValue();
                int new_mul_const_0 = mul_const * std::get<1>(workmap[rhs]);
                int new_mul_const_1 = mul_const * std::get<2>(workmap[rhs]);
                workmap[&I] = std::make_tuple(indvar, new_mul_const_0, new_mul_const_1);
              }
            }
            else if (op->getOpcode() == Instruction::Add) {
              if (workmap.count(lhs) && dyn_cast<ConstantInt>(rhs)) {
                int add_const = dyn_cast<ConstantInt>(rhs)->getSExtValue();
                int new_add_const = add_const + std::get<1>(workmap[lhs]);
                workmap[&I] = std::make_tuple(indvar, std::get<1>(workmap[lhs]), new_add_const);
              }
              else if (workmap.count(rhs) && dyn_cast<ConstantInt>(lhs)) {
                int add_const = dyn_cast<ConstantInt>(lhs)->getSExtValue();
                int new_add_const = add_const + std::get<1>(workmap[rhs]);
                workmap[&I] = std::make_tuple(indvar, std::get<1>(workmap[lhs]), new_add_const);
              }
            }
            else if (op->getOpcode() == Instruction::Sub) {
              if (workmap.count(lhs) && dyn_cast<ConstantInt>(rhs)) {
                int sub_const = dyn_cast<ConstantInt>(rhs)->getSExtValue();
                int new_sub_const = std::get<1>(workmap[lhs]) - sub_const;
                workmap[&I] = std::make_tuple(indvar, std::get<1>(workmap[lhs]), new_sub_const);
              }
              else if (workmap.count(rhs) && dyn_cast<ConstantInt>(lhs)) {
                int sub_const = dyn_cast<ConstantInt>(lhs)->getSExtValue();
                int new_sub_const = std::get<1>(workmap[rhs]) - sub_const;
                workmap[&I] = std::make_tuple(indvar, std::get<1>(workmap[lhs]), new_sub_const);
              }
            }
          }
          // if (I.getOpcode() != Instruction::Mul ||
          //     I.getOpcode() != Instruction::Add ||
          //     I.getOpcode() != Instruction::Sub )
          //   continue;

          // if (I.getOpcode() != Instruction::Add ||
          //     I.getOpcode() != Instruction::Sub ) {

          // }

          // bool ContainIV = false;
          // Value* MulConst;
          // for (unsigned i = 0; i < I.getNumOperands(); i++) {
          //   if (dyn_cast<Instruction> (I.getOperand(i)) == IV) {
          //     ContainIV = true;
          //   }
          // }
          // if (ContainIV)
          //   MulList.push_back(std::tuple(&I, ));
        }
      }

      // modify instructions
      bool change = false;
      for (auto itr = workmap.begin(); itr != workmap.end(); itr++) {
        Instruction *dr_instr = itr->first;
        auto dr_tuple = itr->second;

        if (dr_instr->getParent() != L->getHeader()) { // not the base induction variable
          // add init value in loop pre-header
          BasicBlock *L_preheader = L->getLoopPreheader();
          IRBuilder<> builder(L_preheader->getTerminator());
          Value *new_mul = builder.CreateMul(base_init_inst, 
            ConstantInt::getSigned(base_init_inst->getType(), std::get<1>(dr_tuple)));
          Value *new_add = builder.CreateAdd(new_mul, 
            ConstantInt::getSigned(new_mul->getType(), std::get<2>(dr_tuple)));
          
          // add phi node in loop header
          builder.SetInsertPoint(indvar->getNextNode());
          PHINode *new_phi = builder.CreatePHI(base_init_inst->getType(), 2);
          new_phi->addIncoming(new_add, L_preheader);

          // add increment in loop body after i += e
          builder.SetInsertPoint(base_shift_inst->getNextNode());
          int incr = std::get<1>(dr_tuple) * std::get<2>(indvar_tuple);
          Value *new_incr = builder.CreateAdd(new_phi, 
            ConstantInt::getSigned(new_phi->getType(), incr));
          new_phi->addIncoming(new_incr, base_shift_inst->getParent());

          // change previous j=a*i+b to j=new_phi
          for (auto &U: dr_instr->uses()) {
            User *user = U.getUser();
            user->setOperand(U.getOperandNo(), new_phi);
          }

          change = true;
        }
      }

      // find the induction variable in this compare instruction

      // for (PHINode &PN : L_cond->phis()) {
        
      //   llvm::errs() << "phi_node: " << PN.getValueName() << "\n";
      // }
      // PHINode *iv = L->getInductionVariable(SE);
      // // llvm::errs() << "phi node: \n";
      // llvm::errs() << "phi_node: " << iv->getValueName() << "\n";
      // // for (unsigned i = 0, e = iv->get)

      return change;
    }
  };
}

char MyPass::ID = 0;

// // Automatically enable the pass.
// // http://adriansampson.net/blog/clangpass.html
// static void registerMyPass(const PassManagerBuilder &,
//                          legacy::PassManagerBase &PM) {
//   PM.add(new MyPass());
// }
// static RegisterStandardPasses
//   RegisterMyPass(PassManagerBuilder::EP_EarlyAsPossible,
//                  registerMyPass);

static RegisterPass<MyPass> X("loopive", "Loop Induction Var Elimination Pass",
                             false /* Only looks at CFG */,
                             true /* Analysis Pass */);

static RegisterStandardPasses Y(
    PassManagerBuilder::EP_EarlyAsPossible,
    [](const PassManagerBuilder &Builder,
       legacy::PassManagerBase &PM) { PM.add(new MyPass()); });
