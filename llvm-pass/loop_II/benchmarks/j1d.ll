; ModuleID = 'jacobi-1d.c'
source_filename = "jacobi-1d.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %A = alloca [50 x i32], align 16
  %B = alloca [50 x i32], align 16
  %t = alloca i32, align 4
  %i = alloca i32, align 4
  %i12 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  store i32 0, i32* %t, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc32, %entry
  %0 = load i32, i32* %t, align 4
  %cmp = icmp ult i32 %0, 50
  br i1 %cmp, label %for.body, label %for.end34

for.body:                                         ; preds = %for.cond
  store i32 1, i32* %i, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc, %for.body
  %1 = load i32, i32* %i, align 4
  %cmp2 = icmp ult i32 %1, 49
  br i1 %cmp2, label %for.body3, label %for.end

for.body3:                                        ; preds = %for.cond1
  %2 = load i32, i32* %i, align 4
  %sub = sub i32 %2, 1
  %idxprom = zext i32 %sub to i64
  %arrayidx = getelementptr inbounds [50 x i32], [50 x i32]* %A, i64 0, i64 %idxprom
  %3 = load i32, i32* %arrayidx, align 4
  %4 = load i32, i32* %i, align 4
  %idxprom4 = zext i32 %4 to i64
  %arrayidx5 = getelementptr inbounds [50 x i32], [50 x i32]* %A, i64 0, i64 %idxprom4
  %5 = load i32, i32* %arrayidx5, align 4
  %add = add nsw i32 %3, %5
  %6 = load i32, i32* %i, align 4
  %add6 = add i32 %6, 1
  %idxprom7 = zext i32 %add6 to i64
  %arrayidx8 = getelementptr inbounds [50 x i32], [50 x i32]* %A, i64 0, i64 %idxprom7
  %7 = load i32, i32* %arrayidx8, align 4
  %add9 = add nsw i32 %add, %7
  %mul = mul nsw i32 3, %add9
  %8 = load i32, i32* %i, align 4
  %idxprom10 = zext i32 %8 to i64
  %arrayidx11 = getelementptr inbounds [50 x i32], [50 x i32]* %B, i64 0, i64 %idxprom10
  store i32 %mul, i32* %arrayidx11, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body3
  %9 = load i32, i32* %i, align 4
  %inc = add i32 %9, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond1

for.end:                                          ; preds = %for.cond1
  store i32 1, i32* %i12, align 4
  br label %for.cond13

for.cond13:                                       ; preds = %for.inc29, %for.end
  %10 = load i32, i32* %i12, align 4
  %cmp14 = icmp ult i32 %10, 49
  br i1 %cmp14, label %for.body15, label %for.end31

for.body15:                                       ; preds = %for.cond13
  %11 = load i32, i32* %i12, align 4
  %sub16 = sub i32 %11, 1
  %idxprom17 = zext i32 %sub16 to i64
  %arrayidx18 = getelementptr inbounds [50 x i32], [50 x i32]* %B, i64 0, i64 %idxprom17
  %12 = load i32, i32* %arrayidx18, align 4
  %13 = load i32, i32* %i12, align 4
  %idxprom19 = zext i32 %13 to i64
  %arrayidx20 = getelementptr inbounds [50 x i32], [50 x i32]* %B, i64 0, i64 %idxprom19
  %14 = load i32, i32* %arrayidx20, align 4
  %add21 = add nsw i32 %12, %14
  %15 = load i32, i32* %i12, align 4
  %add22 = add i32 %15, 1
  %idxprom23 = zext i32 %add22 to i64
  %arrayidx24 = getelementptr inbounds [50 x i32], [50 x i32]* %B, i64 0, i64 %idxprom23
  %16 = load i32, i32* %arrayidx24, align 4
  %add25 = add nsw i32 %add21, %16
  %mul26 = mul nsw i32 3, %add25
  %17 = load i32, i32* %i12, align 4
  %idxprom27 = zext i32 %17 to i64
  %arrayidx28 = getelementptr inbounds [50 x i32], [50 x i32]* %A, i64 0, i64 %idxprom27
  store i32 %mul26, i32* %arrayidx28, align 4
  br label %for.inc29

for.inc29:                                        ; preds = %for.body15
  %18 = load i32, i32* %i12, align 4
  %inc30 = add i32 %18, 1
  store i32 %inc30, i32* %i12, align 4
  br label %for.cond13

for.end31:                                        ; preds = %for.cond13
  br label %for.inc32

for.inc32:                                        ; preds = %for.end31
  %19 = load i32, i32* %t, align 4
  %inc33 = add i32 %19, 1
  store i32 %inc33, i32* %t, align 4
  br label %for.cond

for.end34:                                        ; preds = %for.cond
  ret i32 0
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 724bf4ee23a3993689d55afb2845949e05c83b1c)"}
