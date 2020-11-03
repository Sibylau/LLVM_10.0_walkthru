.PHONY: opt clean

opt: *.c
	for src in *.c
	do
		clang -S -emit-llvm -O0 -Xclang -disable-O0-optnone $(src);
	done

	for ll in *.ll
	do
		opt -S -O0 -load build/loop_ive/libMyPass.so -mem2reg -loopive $(ll) -o opt_$(ll).ll
	done

clean:
	rm *.ll
