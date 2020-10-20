//=======================================================================
// Analysis Pass Linked with a Runtime Lib: Count Instruction Types
// Reference: 
//  1. https://ucsd-pl.github.io/cse231/wi17/part1.html (Section 2)
//  2. https://www.cs.cornell.edu/~asampson/blog/llvm.html
// Jie Liu, 8/16/2020
//=======================================================================
#include "llvm/IR/Module.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Instruction.h"
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
    struct CountDynamicInstPass : public FunctionPass 
    {
        static char ID;
        CountDynamicInstPass() : FunctionPass(ID) {}

        virtual bool runOnFunction(Function &F) 
        {
            LLVMContext &ctx = F.getContext();
            Type* retType = Type::getVoidTy(ctx);
            std::vector<Type*> paramType_0 = 
                {Type::getInt8PtrTy(ctx)};
            FunctionType* FuncType_0 = 
                FunctionType::get(retType, paramType_0, false);
            FunctionCallee trackInst = F.getParent() -> 
                getOrInsertFunction("trackInst", FuncType_0);

            std::vector<Type*> paramType_1 = 
                {Type::getVoidTy(ctx)};
            FunctionType* FuncType_1 = 
                FunctionType::get(retType, paramType_1, false);
            FunctionCallee printout = F.getParent() -> 
                getOrInsertFunction("printout", FuncType_1);

            std::map<const char*, int> count_list;

            for(auto &B : F) {
                for(auto &I : B) {
                    const char* opcode_name = I.getOpcodeName();
                    IRBuilder<> builder(&I);
                    builder.SetInsertPoint(&I);
                    std::vector<Value*> args;
                    args.push_back(builder.CreateGlobalString(opcode_name));

                    builder.CreateCall(trackInst, args);
                }
                IRBuilder<> tail_builder(&B);
                tail_builder.SetInsertPoint(&B);
                tail_builder.CreateCall(printout);
            }

            return true;
        }
    };
}

char CountDynamicInstPass::ID = 0;

static void registerCountDynamicInstPass(const PassManagerBuilder &,
                    legacy::PassManagerBase &PM) {
                        PM.add(new CountDynamicInstPass());
                    }
    
static RegisterStandardPasses RegisterMyPass(
    PassManagerBuilder::EP_EarlyAsPossible,
    registerCountDynamicInstPass
);
