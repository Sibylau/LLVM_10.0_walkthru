//=======================================================================
// 
// Reference: https://llvm.org/doxygen/DCE_8cpp_source.html
//=======================================================================

#include "llvm/Pass.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"
#include "llvm/Analysis/LoopInfo.h"
using namespace llvm;

namespace {
  struct MyPass : public FunctionPass {
    static char ID;
    MyPass() : FunctionPass(ID) {}

    virtual bool runOnFunction(Function &F) {
      SmallVector<Instruction*, 128> worklist;
      bool change = true;

      while (change) {
        for (auto &B: F) {
          for (auto &I: B) {
            if (I.use_empty() && !I.isTerminator() && 
                !isa<DbgInfoIntrinsic>(I) && !isa<LandingPadInst>(I) &&
                !I.mayHaveSideEffects()) {
              I.print(llvm::errs());
              worklist.push_back(&I);
              for (unsigned i = 0; i < I.getNumOperands(); i++) {
                Value *opV = I.getOperand(i);
                I.setOperand(i, nullptr);

                // If this dead instruction is the only one that uses 
                // this op/instr
                Instruction *opI = dyn_cast<Instruction>(opV);
                if (&I == opV || !opV->use_empty()) continue;
                if (opI->use_empty() && !opI->isTerminator() && 
                !isa<DbgInfoIntrinsic>(*opI) && !isa<LandingPadInst>(*opI)
                && !opI->mayHaveSideEffects()) {
                  opI->print(llvm::errs());
                  worklist.push_back(opI);
                }
              }
            }
          }
        }
        change = false;
        while (!worklist.empty()) {
          Instruction *Instr = worklist.pop_back_val();
          Instr->eraseFromParent();
          change = true;
        }
      }
      
      return change;
    }
  };
}

char MyPass::ID = 0;

// Automatically enable the pass.
// http://adriansampson.net/blog/clangpass.html
static void registerMyPass(const PassManagerBuilder &,
                         legacy::PassManagerBase &PM) {
  PM.add(new MyPass());
}
static RegisterStandardPasses
  RegisterMyPass(PassManagerBuilder::EP_EarlyAsPossible,
                 registerMyPass);
