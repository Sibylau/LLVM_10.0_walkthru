//=======================================================================
// Analysis Pass Linked with a Runtime Lib: Count Instruction Types
// Reference: 
//  1. https://ucsd-pl.github.io/cse231/wi17/part1.html (Section 2)
//  2. https://www.cs.cornell.edu/~asampson/blog/llvm.html
// Jie Liu, 8/16/2020
//=======================================================================
#include "llvm/IR/Module.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"
#include "llvm/IR/GlobalValue.h"

using namespace llvm;

namespace 
{
    struct BranchStatPass : public FunctionPass 
    {
        static char ID;
        BranchStatPass() : FunctionPass(ID) {}

        virtual bool runOnFunction(Function &F) 
        {
            LLVMContext &ctx = F.getContext();
            Type* retType = Type::getVoidTy(ctx);
            std::vector<Type*> paramType_0 = 
                {Type::getInt8PtrTy(ctx)};
            FunctionType* trackInstFuncType = 
                FunctionType::get(retType, paramType_0, false);
            FunctionCallee trackInstFunc = F.getParent() -> 
                getOrInsertFunction("trackInst", trackInstFuncType);


            for(auto &B : F) {
                for(auto &I : B) {
                    if(auto *branch_I = cast<BranchInst> (&I)) {
                        
                    }
                    const char* opcode_name = I.getOpcodeName();
                    IRBuilder<> builder(&I);
                    builder.SetInsertPoint(&B, ++builder.GetInsertPoint());
                    Value* strptr = builder.CreateGlobalStringPtr(opcode_name);

                    builder.CreateCall(trackInstFunc, strptr);
                    return true;
                }
            }

            return false;
        }
    };
}

char BranchStatPass::ID = 0;

static void registerBranchStatPass(const PassManagerBuilder &,
                    legacy::PassManagerBase &PM) {
                        PM.add(new BranchStatPass());
                    }
    
static RegisterStandardPasses RegisterMyPass(
    PassManagerBuilder::EP_EarlyAsPossible,
    registerBranchStatPass
);
