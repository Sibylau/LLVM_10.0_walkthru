
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

#define DEBUG_TYPE "looptrace"

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
