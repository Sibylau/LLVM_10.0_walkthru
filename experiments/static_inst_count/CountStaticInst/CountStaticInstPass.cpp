//=======================================================================
// Static Analysis Pass: Count Static Instruction Types
// Reference: 
//  1. https://ucsd-pl.github.io/cse231/wi17/part1.html (Section 1)
//  2. https://www.cs.cornell.edu/~asampson/blog/llvm.html
// Jie Liu, 8/15/2020
//=======================================================================

#include "llvm/IR/Function.h"
#include "llvm/IR/Instruction.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"
#include <iterator>
#include <map>

using namespace llvm;

namespace 
{
    struct CountStaticInstPass : public FunctionPass 
    {
        static char ID;
        CountStaticInstPass() : FunctionPass(ID) {}

        virtual bool runOnFunction(Function &F) 
        {
            std::map<const char*, int> count_list;
            for(auto &B : F)
                for(auto &I : B) {
                    const char* opcode_name = I.getOpcodeName();
                    std::map<const char*, int>::iterator it = 
                                        count_list.find(opcode_name);
                    if(it != count_list.end()) {
                        count_list[opcode_name] ++;
                    } else {
                        count_list.insert(std::pair<const char*, int>
                                        (opcode_name, 1));
                    }
                }
            
            for(auto i : count_list)
                errs()<<i.first<<"\t"<<i.second<<"\n";

            return false;
        }
    };
}

char CountStaticInstPass::ID = 0;

static void RegCountStaticInstPass(const PassManagerBuilder &,
                                    legacy::PassManagerBase &PM) {
    PM.add(new CountStaticInstPass());
}

static RegisterStandardPasses 
        RegisterMyPass(PassManagerBuilder::EP_EarlyAsPossible,
                        RegCountStaticInstPass);
