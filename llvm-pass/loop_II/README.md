# Loop ResMII and RecMII Estimation

An LLVM pass doing loop resource minimum II (ResMII) and recurrence minimum II (RecMII) estimation. 

## Build and Run
### Build
`mkdir build`  
`cd build`  
`cmake ..`  
`make`  
### LLVM Optimzation Pipeline 
1. `cd benchmarks`
2. `clang -emit-llvm -S -O0 -Xclang -disable-O0-optnone test.c -o test.ll` 
3. `opt -S -O0 -gvn -mem2reg -indvars test.ll -o test-reg.ll` applies global value numbering first to combine redundant array index computations, and then eliminates unnecessary memory accesses.
4. ` opt -S -O0 -load ../build/loop_II/libMyPass.so -loopII test-reg.ll -o test-o.ll`, in which `loopII` runs our analysis.


## Code API references:
1. https://llvm.org/doxygen/DependenceAnalysis_8cpp_source.html#l00591

