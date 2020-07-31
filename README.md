# LLVM 10.0 Walkthrough Tutorial

## Why LLVM?
1. LLVM's IR is human-readable
2. modular architecture
3. High quality and hackable code structure
4. LLVM uses uniform IR for all passes

## Start Writing a Pass
### I. Decide a class you should subclass for
#### Immutable Class

#### FunctionPass Class
Having a predicatable, local behaviour.  
Operated on a function at a time.
### II. Code structure

LLVM needs a static pass identifier to identify pass.   
`err()` is an LLVM C++ output stream to print out the console.  
Returning false means that the pass does not modify the program.
### Register a Pass
What you really want to do is to slip in your pass before the rest of optimizations a normal compiler will do. Ideally, you just want to give a one-line command like `$clang -mypass code.c` to do everything at once.
You can use LLVM pass registry to do this.
```
static void registerPass(const PassManagerBuilder &,
                         legacy::PassManagerBase &PM) {
  PM.add(new MyPass());
}
static RegisterStandardPasses
  RegisterMyPass(PassManagerBuilder::EP_EarlyAsPossible,
                 registerPass);
```
## Compile an LLVM pass with Clang
### One-line solution after registering your pass
`$clang -Xclang -load -Xclang mypass.so code.c`
### The official rigmarole
1. Compile using clang `$clang -c -emit-llvm code.c`
2. Run my pass with `$opt -load mypass.so -mypass < code.bc > code_inst.bc`
3. run the rest of the standard optimization with `$opt -O3 < code_inst.bc > code_opt.bc`
4. Compile the optimized bitcode into assmebly with llc and then use your favorite assembler and linker to get the rest of the way to an executable.
### Hello world with Clang
1. `$cd experiments/helloworld`
2. `$clang -O3 -emit-llvm hello.c -c -o hello.bc`  
The -emit-llvm can be used with `-S` to emit an LLVM `.ll`, or with `-c` to emit an LLVM `.bc` file. This allows you to use standard LLVM tools on the bitcode file.
3. `$.hello` or `$lli hello.bc` in which `lli` is LLVM JIT.
4. Use `llvm-dis` utility to look at the LLVM assembly code.  
5.1. Compile the program to native assembly using te LLC code generator:  
`$llc hello.bc -o hello.s`  
6.1. Assmeble the native assembly language file into a program:
`$gcc hello.s -o hello.native`  
7.1. Execute: `$./hello.native`  
5.2 `$clang -O3 hello.c -o hello.native` Generate .native file directly with clang.


## LLVM IR
Module(a file/translation unit) -> Function(functions and methods) -> BasicBlocks(a contiguous chunk of instructions) -> Instruction(single operation)  
All above in LLVM are inherited from a base class Value.  
Since LLVM IR is in SSA(Static Single Assignment) form, registers and instructions are the same.  
- SSA is a property of an IR, which requires that each variable be assigned exactly once, and every variable be defined before it is used.  

To see llvm IR, type `$clang -emit-llvm -S -o - code.c`.  
`dump()` will orint out human-readable representation of an object in the IR.   

`IRBuilder` contains a million methods to construct any kind of instructions.  

## Error Solutions
Most common compilation errors come from the mismatch of gcc/++ versions, or C/C++ standards. To specify the path for the gcc/++ compiler, try `$cmake -DCMAKE_C_COMPILER=/path/to/gcc/bin/gcc -DCMAKE_CXX_COMPILER=/path/to/g++/bin/g++`. Or `$export CC=/path/to/gcc/bin/gcc` and `$export CXX=/path/to/g++/bin/g++`. To specify the C/CXX standard, e.g. `$cmake -DCMAKE_CXX_STANDARD=14`.

## References
1. https://www.cs.cornell.edu/~asampson/blog/llvm.html
2. https://www.cs.cornell.edu/~asampson/blog/clangpass.html
