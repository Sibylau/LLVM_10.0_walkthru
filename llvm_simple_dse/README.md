# CS6120 - A Naive LLVM dead code elimination pass

This pass is doing really naive dead code elimination. It only checks whether the instruction is used or not. If not used, the instruction will be eliminated. Also it checks whether the operands (or instructions in SSA philosophy) are only being used by those "dead" instructions, and if so they'll be eliminated. A worklist vector is used to keep record of instructions that will be eliminated, in order to avoid destroying basic block iterator when deleting dead instructions.

### Run a test
Under build/, run `cmake ..` and `make`  
Under root folder, run:
 - `clang -S -emit-llvm -O0 -Xclang -disable-O0-optnone dce_test.c` will generate a .ll LLVM IR file
 - `opt -S -O0 -load build/simple_dse/libMyPass.so -mem2reg -simpledce dce_test.ll -o opt_dce.ll` will show optimized LLVM IR in `opt_dce.ll`

The code in test file `a.c` is:
```C
int foo (int x, int y) {
    int a = x + y;
    a = 1;
    return a;
}
```

The original LLVM IR of the given test `a.c` is:
```
; Function Attrs: noinline nounwind uwtable
define dso_local i32 @foo(i32 %x, i32 %y) #0 {
entry:
  %add = add nsw i32 %x, %y
  ret i32 1
}
```

After this simple dead code elimination the IR becomes:
```
; Function Attrs: noinline nounwind uwtable
define dso_local i32 @foo(i32 %x, i32 %y) #0 {
entry:
  ret i32 1
}
```
Hooray!!

### References: 
1. Code skeleton: https://github.com/sampsyo/llvm-pass-skeleton
2. DSE API reference: https://llvm.org/doxygen/DCE_8cpp_source.html
