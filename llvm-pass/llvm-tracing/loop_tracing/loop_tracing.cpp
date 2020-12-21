
#include "llvm/Pass.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Dominators.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"
#include "llvm/Transforms/Utils/LoopUtils.h"
#include "llvm/Transforms/Utils/FunctionComparator.h"
#include "llvm/Analysis/LoopPass.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/ScalarEvolution.h"
#include "llvm/Analysis/AssumptionCache.h"
#include "llvm/Analysis/TargetTransformInfo.h"
#include "llvm/Analysis/DependenceAnalysis.h"
#include "llvm/Analysis/ScalarEvolutionExpressions.h"
#include <tuple>
#include <map> 

#define MEM_R_PORT 1
#define MEM_W_PORT 1

using namespace llvm;

#define DEBUG_TYPE "looptrace"

namespace {
  class MyPass : public LoopPass {
  public:
    static char ID;
    MyPass() : LoopPass(ID) {}

  private:
    // glide some necessary information
    void getAnalysisUsage(AnalysisUsage &AU) const override {
      AU.addRequired<LoopInfoWrapperPass>();
      AU.addPreserved<LoopInfoWrapperPass>();
      AU.addRequired<TargetTransformInfoWrapperPass>();
      AU.addRequired<AssumptionCacheTracker>();
      AU.addRequired<DominatorTreeWrapperPass>();
      AU.addPreserved<DominatorTreeWrapperPass>();
      AU.addRequired<ScalarEvolutionWrapperPass>();
      AU.addPreserved<ScalarEvolutionWrapperPass>();
      AU.addRequired<DependenceAnalysisWrapperPass>();
      AU.addPreserved<DependenceAnalysisWrapperPass>();
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
      DependenceInfo *depInfo = &getAnalysis<DependenceAnalysisWrapperPass>().getDI();
      

      // tuple<Instruction/derived_iv, mul_const, shift_const>
      // std::map<Value*, std::tuple<Instruction*, int, int>> workmap;
      // std::map<Value*, std::tuple<Instruction*, int, int>> phimap;

      // std::vector<Type*> paramTypes = {};
      // Type *retType = ;
      // FunctionType *logFuncType = FunctionType::get(retType, paramTypes, false);
      // FunctionCallee logFunc = F.getParent()->getOrInsertFunction(
      //   "logout", Type::getVoidTy(Ctx), Type::getInt32Ty(Ctx));
      
      // Only runs on the innermost loop
      if (L->getSubLoops().size() != 0) {
        return false;
      }

      // Estimate the ResMII
      // Count the number of load and store instructions
      int numLoad = 0;
      int numStore = 0;
      for (auto &L_bb: L->getBlocks()) {
        if (L_bb == L->getHeader() || L_bb == L->getExitBlock())
          continue;
        for (auto &I: *L_bb) {
          if (I.getOpcode() == Instruction::Load)
            numLoad ++;
          else if (I.getOpcode() == Instruction::Store)
            numStore ++;
        }
      }
      // errs() << "numLoad = " << numLoad <<" , numStore = " << numStore << "\n";
      errs() << "Load = " << numLoad/MEM_R_PORT <<" , Store = " << numStore/MEM_W_PORT << "\n";
      int resMII = std::max(numStore/MEM_W_PORT, numLoad/MEM_R_PORT);
      errs() << "resMII = " << resMII << "\n";
      
      // Estimate the RecMII
      int recMII = 1;
      for (auto &L_bb: L->getBlocks()) {
        if (L_bb == L->getHeader() || L_bb == L->getExitBlock())
          continue;
        for (auto &src_I: *L_bb) {
          if (src_I.getOpcode() == Instruction::Store) {
            for (auto &des_I: *L_bb) {

              // only detects memory RAW dependency
              if (des_I.getOpcode() == Instruction::Load) {
                unsigned SrcLevel = LI->getLoopDepth(L_bb);

                std::unique_ptr<Dependence> infoPtr;
                infoPtr = depInfo->depends(&src_I, &des_I, true);
                Dependence *dep = infoPtr.get();

                if (dep != NULL && !dep->isInput()) {
                  
                  // check if it is loop-carried dependence
                  if (!dep->isLoopIndependent()) {

                    // check out the distance?
                    errs() <<"[L]";
                    const SCEV *distance = dep->getDistance(SrcLevel);
                    if (distance) {
                      errs() << "distance = " << *distance << "\n";
                      if(auto constDist = dyn_cast<SCEVConstant>(distance)) {
                        int tempRecMII = constDist->getValue()->getSExtValue();
                        if (recMII < tempRecMII)
                          recMII = tempRecMII;
                        errs() << "recMII = " << recMII << "\n";
                      }
                    }
                    else {
                      // errs() << "distance = null\n";
                      int LdIndex, StIndex;
                      if (LoadInst *LdInst = dyn_cast<LoadInst>(&des_I)) {
                        LdIndex = LdInst->getPointerOperandIndex();
                        // Value *LdIndex = LdInst->getPointerOperand();
                        // errs() << "load\n";
                        // if (auto constLdIndex = dyn_cast<ConstantInt>(LdIndex)) {
                        //   int intLdIndex = constLdIndex->getSExtValue();
                        //   errs() << "ldIndex = " << intLdIndex << "\n";
                        // }
                        // errs() << "ldIndex = " << LdIndex << "\t";
                      }
                      else
                        errs() << "Trying to cast a non-load instr to a load.\n";

                      if (StoreInst *StInst = dyn_cast<StoreInst>(&src_I)) {
                        StIndex = StInst->getPointerOperandIndex();
                        // Value *StIndex = StInst->getPointerOperand();
                        // errs() << "store\n";
                        // if (auto constStIndex = dyn_cast<ConstantInt>(StIndex)) {
                        //   int intStIndex = constStIndex->getSExtValue();
                        //   errs() << "StIndex = " << intStIndex << "\n";
                        // }
                        // errs() << "StIndex = " << StIndex << "\n";
                      }
                      else
                        errs() << "Trying to cast a non-store instr to a store.\n";

                      // if the index difference is 1, the achievable II is 2
                      int tempRecMII = std::abs(LdIndex - StIndex) + 1;
                      if (recMII < tempRecMII) 
                        recMII = tempRecMII;
                      errs() << "recMII = " << recMII << "\n";
                    }
                    
                    // check out the direction?
                    unsigned direct = dep->getDirection(SrcLevel);
                    if (direct == Dependence::DVEntry::ALL)
                    errs() << "*";
                    else {
                      if (direct & Dependence::DVEntry::LT)
                        errs() << "<";
                      if (direct & Dependence::DVEntry::EQ)
                        errs() << "=";
                      if (direct & Dependence::DVEntry::GT)
                        errs() << ">";
                    }

                    // if (auto dist_const = dyn_cast<SCEVConstant>(distance)) {
                    //   ConstantInt *dist_val = dist_const->getValue();
                    // }
                    // dep->getDistance(SrcLevel)->print(errs());
                    // distance->print(errs());
                    // distance->dump();
                  }
                  if (dep->isConfused()) errs() << "[C]";
                  dep->getDst()->print(errs(), false);
                  errs() << " ---> ";
                  dep->getSrc()->print(errs(), false);
                  errs() << "\n";
                }
              }
              
            }
          }
        }
      }
      
      // II = max(ResMII, RecMII)
      unsigned II = std::max(resMII, recMII);
      if (resMII > recMII)
        errs() << "Loop II bounded by resource contention. \
        Please consider merging array accesses.\n";
      else
        errs() << "Loop II bounded by loop-carried dependences. \
        Please consider revise design architeture, reduce clock frequency, \
        quantize data bitwidth, etc.\n";
      return false;
    }
  };
}

char MyPass::ID = 0;

static RegisterPass<MyPass> X("looptrace", "Loop Tracing Pass",
                             false /* Only looks at CFG */,
                             false /* Analysis Pass */);

static RegisterStandardPasses Y(
    PassManagerBuilder::EP_EarlyAsPossible,
    [](const PassManagerBuilder &Builder,
       legacy::PassManagerBase &PM) { PM.add(new MyPass()); });
