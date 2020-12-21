; ModuleID = 'h.ll'
source_filename = "heat-2d.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
entry:
  %A = alloca [20 x [20 x [20 x i32]]], align 16
  %B = alloca [20 x [20 x [20 x i32]]], align 16
  br label %for.cond

for.cond:                                         ; preds = %for.end91, %entry
  %indvars.iv8 = phi i64 [ %indvars.iv.next9, %for.end91 ], [ 1, %entry ]
  %exitcond12 = icmp ne i64 %indvars.iv8, 19
  br i1 %exitcond12, label %for.body, label %for.end94

for.body:                                         ; preds = %for.cond
  br label %for.cond1

for.cond1:                                        ; preds = %for.end, %for.body
  %indvars.iv3 = phi i64 [ %indvars.iv.next4, %for.end ], [ 1, %for.body ]
  %exitcond7 = icmp ne i64 %indvars.iv3, 19
  br i1 %exitcond7, label %for.body3, label %for.end91

for.body3:                                        ; preds = %for.cond1
  br label %for.cond4

for.cond4:                                        ; preds = %for.body6, %for.body3
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body6 ], [ 1, %for.body3 ]
  %exitcond = icmp ne i64 %indvars.iv, 19
  br i1 %exitcond, label %for.body6, label %for.end

for.body6:                                        ; preds = %for.cond4
  %0 = add nuw nsw i64 %indvars.iv8, 1
  %arrayidx = getelementptr inbounds [20 x [20 x [20 x i32]]], [20 x [20 x [20 x i32]]]* %A, i64 0, i64 %0
  %arrayidx8 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* %arrayidx, i64 0, i64 %indvars.iv3
  %arrayidx10 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx8, i64 0, i64 %indvars.iv
  %1 = load i32, i32* %arrayidx10, align 4
  %arrayidx12 = getelementptr inbounds [20 x [20 x [20 x i32]]], [20 x [20 x [20 x i32]]]* %A, i64 0, i64 %indvars.iv8
  %arrayidx14 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* %arrayidx12, i64 0, i64 %indvars.iv3
  %arrayidx16 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx14, i64 0, i64 %indvars.iv
  %2 = load i32, i32* %arrayidx16, align 4
  %mul = mul nsw i32 2, %2
  %sub = sub nsw i32 %1, %mul
  %3 = sub nuw nsw i64 %indvars.iv8, 1
  %arrayidx19 = getelementptr inbounds [20 x [20 x [20 x i32]]], [20 x [20 x [20 x i32]]]* %A, i64 0, i64 %3
  %arrayidx21 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* %arrayidx19, i64 0, i64 %indvars.iv3
  %arrayidx23 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx21, i64 0, i64 %indvars.iv
  %4 = load i32, i32* %arrayidx23, align 4
  %add24 = add nsw i32 %sub, %4
  %mul25 = mul nsw i32 12, %add24
  %5 = add nuw nsw i64 %indvars.iv3, 1
  %arrayidx30 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* %arrayidx12, i64 0, i64 %5
  %arrayidx32 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx30, i64 0, i64 %indvars.iv
  %6 = load i32, i32* %arrayidx32, align 4
  %sub40 = sub nsw i32 %6, %mul
  %7 = sub nuw nsw i64 %indvars.iv3, 1
  %arrayidx45 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* %arrayidx12, i64 0, i64 %7
  %arrayidx47 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx45, i64 0, i64 %indvars.iv
  %8 = load i32, i32* %arrayidx47, align 4
  %add48 = add nsw i32 %sub40, %8
  %mul49 = mul nsw i32 2, %add48
  %add50 = add nsw i32 %mul25, %mul49
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %arrayidx57 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx14, i64 0, i64 %indvars.iv.next
  %9 = load i32, i32* %arrayidx57, align 4
  %sub65 = sub nsw i32 %9, %mul
  %10 = sub nuw nsw i64 %indvars.iv, 1
  %arrayidx72 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx14, i64 0, i64 %10
  %11 = load i32, i32* %arrayidx72, align 4
  %add73 = add nsw i32 %sub65, %11
  %mul74 = mul nsw i32 2, %add73
  %add75 = add nsw i32 %add50, %mul74
  %add82 = add nsw i32 %add75, %2
  %arrayidx84 = getelementptr inbounds [20 x [20 x [20 x i32]]], [20 x [20 x [20 x i32]]]* %B, i64 0, i64 %indvars.iv8
  %arrayidx86 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* %arrayidx84, i64 0, i64 %indvars.iv3
  %arrayidx88 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx86, i64 0, i64 %indvars.iv
  store i32 %add82, i32* %arrayidx88, align 4
  br label %for.cond4

for.end:                                          ; preds = %for.cond4
  %indvars.iv.next4 = add nuw nsw i64 %indvars.iv3, 1
  br label %for.cond1

for.end91:                                        ; preds = %for.cond1
  %indvars.iv.next9 = add nuw nsw i64 %indvars.iv8, 1
  br label %for.cond

for.end94:                                        ; preds = %for.cond
  ret i32 0
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 724bf4ee23a3993689d55afb2845949e05c83b1c)"}
