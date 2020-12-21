#include "llvm/IR/Module.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/PassManager.h"
#include "llvm/IR/Verifier.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/Support/Casting.h"
#include "llvm/IR/IRPrintingPasses.h"
#include "llvm/IR/LegacyPassManager.h"

using namespace llvm;

Module* createModule(LLVMContext &ctx);

int main(int argc, char** argv)
{
    static LLVMContext ctx;
    Module* mod = createModule(ctx);

    verifyModule(*mod);

    legacy::PassManager PM;
    PM.add(createPrintModulePass(outs()));
    PM.run(*mod);

    delete mod;
    return 0;
}

Module* createModule(LLVMContext &ctx)
{
    Module* mod = new Module("ArithmeticTest", ctx);

    Type* retType = Type::getInt32Ty(ctx);
    ArrayRef<Type*> params = {Type::getInt32Ty(ctx), Type::getInt32Ty(ctx), Type::getInt32Ty(ctx)};
    FunctionType* funcType = FunctionType::get(retType, params, false);
    FunctionCallee insertFunc = mod -> getOrInsertFunction("mul_add", funcType);
    
    Function* mul_add = cast<Function>(insertFunc.getCallee());
    mul_add->setCallingConv(CallingConv::C);
    Function::arg_iterator args = mul_add->arg_begin();
    Value* x = args++;
    x->setName("x");
    Value* y = args++;
    y->setName("y");
    Value* z = args;
    z->setName("z");

    BasicBlock* block = BasicBlock::Create(ctx, "entry", mul_add);

    IRBuilder<> builder(block);
    Value* tmp = builder.CreateMul(x, y, "tmp");
    Value* tmp2 = builder.CreateAdd(tmp, z, "tmp2");
    builder.CreateRet(tmp2);

    return mod;
}
