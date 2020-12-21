; ModuleID = 'test.c'
source_filename = "test.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@main.A = internal global [20 x i32] zeroinitializer, align 16

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %t = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  store i32 2, i32* %t, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %t, align 4
  %cmp = icmp ule i32 %0, 19
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32, i32* %t, align 4
  %sub = sub i32 %1, 2
  %idxprom = zext i32 %sub to i64
  %arrayidx = getelementptr inbounds [20 x i32], [20 x i32]* @main.A, i64 0, i64 %idxprom
  %2 = load i32, i32* %arrayidx, align 4
  %3 = load i32, i32* %t, align 4
  %sub1 = sub i32 %3, 1
  %idxprom2 = zext i32 %sub1 to i64
  %arrayidx3 = getelementptr inbounds [20 x i32], [20 x i32]* @main.A, i64 0, i64 %idxprom2
  %4 = load i32, i32* %arrayidx3, align 4
  %add = add nsw i32 %2, %4
  %5 = load i32, i32* %t, align 4
  %idxprom4 = zext i32 %5 to i64
  %arrayidx5 = getelementptr inbounds [20 x i32], [20 x i32]* @main.A, i64 0, i64 %idxprom4
  store i32 %add, i32* %arrayidx5, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %6 = load i32, i32* %t, align 4
  %inc = add i32 %6, 1
  store i32 %inc, i32* %t, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  ret i32 0
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 724bf4ee23a3993689d55afb2845949e05c83b1c)"}
