
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
      

      // tuple<Instruction/derived_iv, mul_const, shift_const>
      // std::map<Value*, std::tuple<Instruction*, int, int>> workmap;
      // std::map<Value*, std::tuple<Instruction*, int, int>> phimap;

      // std::vector<Type*> paramTypes = {};
      // Type *retType = ;
      // FunctionType *logFuncType = FunctionType::get(retType, paramTypes, false);
      // FunctionCallee logFunc = F.getParent()->getOrInsertFunction(
      //   "logout", Type::getVoidTy(Ctx), Type::getInt32Ty(Ctx));
      
      // Only runs on the innermost loop
      bool contains_subloop = false;
      for (auto sub_loop: L->getSubLoops()) {
        contains_subloop = true;
      }
      if (contains_subloop) {
        errs() << "Not the innermost loop\n";
        return false;
      }

      // Count the number of load and store instructions
      unsigned numLoad = 0;
      unsigned numStore = 0;
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
      errs() << "numLoad = " << numLoad <<" , numStore = " << numStore << "\n";

      // 
      
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
