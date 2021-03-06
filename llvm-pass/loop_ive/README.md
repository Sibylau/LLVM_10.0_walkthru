# Loop Induction Variable Elimination

An LLVM pass doing loop induction variable elimination. Currently under debugging...

## Loop Induction Variable Elimination
Loop induction variable elimination removes basic induciton variable whose only uses are in loop test conditions.  
Based on strength reduction, a loop induction variable elimination optimization can be performed. For a basic induction variable i whose only uses are 1) the test condition i < u; 2) the definition of i += c. Rewrite loop conditions using the derived loop variable. Eliminate the base loop variable if not used after the loop. In this implementationn, we only eliminates explicit affine functions of the base induction variable. 

## Methodology
The pass implements strengh reduction and loop variable elimination. Strength reduction replaces multiplications in the loop with add operations. Loop variable elimination removes the basic loop induction varibale if it is only used in the loop condition.

## Limitations
1. Only handles the case when induction variables are integer values
2.  

## LLVM Optimzation Pipeline 
1. `clang -emit-llvm -S -O0 -Xclang -disable-O0-optnone c.c -o c.ll` (-S and -c works similar to gcc arguments, producing a native .s and .o file respectively when used alone; when combined with -emit-llvm -S and -c options will emit a .ll and .bc file respectively), `lli` is LLVM JIT which can run .bc file.
2. `opt -S -O0 -mem2reg c.ll -o reg_c.ll` eliminates memory accesses and restore phi nodes.
3. ` opt -S -O0 -load build/loop_ive/libMyPass.so -loop-simplify -indvars -loopive -dce reg_c.ll -o opt_c.ll`, in which `loop-simplify` simplifies loops, `-indvars` canonicalizes induction variables, `loopive` runs our optimization, and finally `dce` eliminates dead code.

<!-- ## Convert LLVM IR to C
`clang -emit-llvm -S `
`llc -march=c -o code.c code.ll`  
`llc -march=cpp -o code.cpp code.ll -cppgen=<>` -->


## Issue triggering
1. If llvm ir file contains `attributes #0 = { noinline nounwind optnone sspstrong uwtable ...}`, the attribute `optnone` should be removed to so that `opt` can work. `clang` argument `-Xclang -disable-O0-optnone` helps to get rid of `optnone` in .ll file.  
2. `Instruction` typically cannot get cast to `ConstantInt`. Use `Value` instead.  
3. An instruction cannot be deleted before all of its uses are removed. 

## References:
1. https://www.cs.cornell.edu/courses/cs6120/2020fa/lesson/7//#tasks  
2. https://llvm.org/devmtg/2009-10/ScalarEvolutionAndLoopOptimization.pdf  
3. http://llvm.org/devmtg/2018-04/slides/Absar-ScalarEvolution.pdf  
4. https://www.cs.cornell.edu/courses/cs6120/2019fa/blog/strength-reduction-pass-in-llvm/
5. https://www.cs.utexas.edu/~pingali/CS380C/2019/lectures/strengthReduction.pdf

## Code API references:
1. https://llvm.org/doxygen/LoopUnrollPass_8cpp_source.html  

