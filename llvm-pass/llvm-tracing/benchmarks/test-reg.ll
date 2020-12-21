; ModuleID = 'test.ll'
source_filename = "test.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@main.A = internal global [20 x i32] zeroinitializer, align 16

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body ], [ 2, %entry ]
  %exitcond = icmp ne i64 %indvars.iv, 20
  br i1 %exitcond, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %0 = sub nuw nsw i64 %indvars.iv, 2
  %arrayidx = getelementptr inbounds [20 x i32], [20 x i32]* @main.A, i64 0, i64 %0
  %1 = load i32, i32* %arrayidx, align 4
  %2 = sub nuw nsw i64 %indvars.iv, 1
  %arrayidx3 = getelementptr inbounds [20 x i32], [20 x i32]* @main.A, i64 0, i64 %2
  %3 = load i32, i32* %arrayidx3, align 4
  %add = add nsw i32 %1, %3
  %arrayidx5 = getelementptr inbounds [20 x i32], [20 x i32]* @main.A, i64 0, i64 %indvars.iv
  store i32 %add, i32* %arrayidx5, align 4
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  ret i32 0
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 724bf4ee23a3993689d55afb2845949e05c83b1c)"}
