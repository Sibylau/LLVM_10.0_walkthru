# Loop Tracing and Analysis

An LLVM pass doing loop instruction tracing and analysis. 

## Loop Induction Variable Elimination
Loop induction variable elimination removes basic induciton variable whose only uses are in loop test conditions.  
Based on strength reduction, a loop induction variable elimination optimization can be performed. For a basic induction variable i whose only uses are 1) the test condition i < u; 2) the definition of i += c. Rewrite loop conditions using the derived loop variable. Eliminate the base loop variable if not used after the loop. In this implementationn, we only eliminates explicit affine functions of the base induction variable. 
 

## LLVM Optimzation Pipeline 
1. `clang -emit-llvm -S -O0 -Xclang -disable-O0-optnone benchmark.c -o bm.ll` 
2. `opt -S -O0 -gvn -mem2reg -indvars bm.ll -o bm-reg.ll` applies global value numbering first to combine redundant array index computations, and then eliminates unnecessary memory accesses.
3. ` opt -S -O0 -load build/loop_tracing/libMyPass.so -looptrace bm-reg.ll -o bm-tc.ll`, in which `looptrace` runs our analysis.


## Code API references:
1. https://llvm.org/doxygen/LoopUnrollPass_8cpp_source.html  

