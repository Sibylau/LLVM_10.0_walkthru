# Loop ResMII and RecMII Estimation

An LLVM pass doing loop resource minimum II (ResMII) and recurrence minimum II (RecMII) estimation. 

## Build
`mkdir build`  
`cd build`  
`cmake ..`  
`make`  

## LLVM Optimzation Pipeline 
1. `clang -emit-llvm -S -O0 -Xclang -disable-O0-optnone benchmark.c -o bm.ll` 
2. `opt -S -O0 -gvn -mem2reg -indvars bm.ll -o bm-reg.ll` applies global value numbering first to combine redundant array index computations, and then eliminates unnecessary memory accesses.
3. ` opt -S -O0 -load build/loop_tracing/libMyPass.so -looptrace bm-reg.ll -o bm-tc.ll`, in which `looptrace` runs our analysis.


## Code API references:
1. https://llvm.org/doxygen/LoopUnrollPass_8cpp_source.html  

