# CS6120 - A Naive LLVM dead code elimination pass

This pass is doing really naive dead code elimination. It only checks whether the instruction is used or not. If not used, the instruction will be eliminated. Also it checks whether the operands (or instructions in SSA philosophy) are only being used by those "dead" instructions, and if so they'll be eliminated. A worklist vector is used to keep record of instructions that will be eliminated, in order to avoid destroying basic block iterator when deleting dead instructions.

### Run a test
Under build/, run `cmake ..` and `make`  
Under root folder, run `clang -Xclang -load -Xclang simple_dse/lib.so dse_test.c`  

Reference: 
1. Code skeleton: https://github.com/sampsyo/llvm-pass-skeleton
2. DSE API reference: https://llvm.org/doxygen/DCE_8cpp_source.html
