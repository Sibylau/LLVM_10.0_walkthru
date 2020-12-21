; ModuleID = 's.ll'
source_filename = "seidel-2d.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@main.A = internal global [20 x [20 x i32]] zeroinitializer, align 16

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.end65, %entry
  %0 = phi i32 [ %inc67, %for.end65 ], [ 0, %entry ]
  %exitcond7 = icmp ne i32 %0, 20
  br i1 %exitcond7, label %for.body, label %for.end68

for.body:                                         ; preds = %for.cond
  br label %for.cond1

for.cond1:                                        ; preds = %for.end, %for.body
  %indvars.iv2 = phi i64 [ %indvars.iv.next3, %for.end ], [ 1, %for.body ]
  %exitcond6 = icmp ne i64 %indvars.iv2, 19
  br i1 %exitcond6, label %for.body3, label %for.end65

for.body3:                                        ; preds = %for.cond1
  br label %for.cond4

for.cond4:                                        ; preds = %for.body6, %for.body3
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body6 ], [ 1, %for.body3 ]
  %exitcond = icmp ne i64 %indvars.iv, 19
  br i1 %exitcond, label %for.body6, label %for.end

for.body6:                                        ; preds = %for.cond4
  %1 = sub nuw nsw i64 %indvars.iv2, 1
  %arrayidx = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* @main.A, i64 0, i64 %1
  %2 = sub nuw nsw i64 %indvars.iv, 1
  %arrayidx9 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx, i64 0, i64 %2
  %3 = load i32, i32* %arrayidx9, align 4
  %arrayidx14 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx, i64 0, i64 %indvars.iv
  %4 = load i32, i32* %arrayidx14, align 4
  %add = add nsw i32 %3, %4
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %arrayidx20 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx, i64 0, i64 %indvars.iv.next
  %5 = load i32, i32* %arrayidx20, align 4
  %add21 = add nsw i32 %add, %5
  %arrayidx23 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* @main.A, i64 0, i64 %indvars.iv2
  %arrayidx26 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx23, i64 0, i64 %2
  %6 = load i32, i32* %arrayidx26, align 4
  %add27 = add nsw i32 %add21, %6
  %arrayidx31 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx23, i64 0, i64 %indvars.iv
  %7 = load i32, i32* %arrayidx31, align 4
  %add32 = add nsw i32 %add27, %7
  %arrayidx37 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx23, i64 0, i64 %indvars.iv.next
  %8 = load i32, i32* %arrayidx37, align 4
  %add38 = add nsw i32 %add32, %8
  %9 = add nuw nsw i64 %indvars.iv2, 1
  %arrayidx41 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* @main.A, i64 0, i64 %9
  %arrayidx44 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx41, i64 0, i64 %2
  %10 = load i32, i32* %arrayidx44, align 4
  %add45 = add nsw i32 %add38, %10
  %arrayidx50 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx41, i64 0, i64 %indvars.iv
  %11 = load i32, i32* %arrayidx50, align 4
  %add51 = add nsw i32 %add45, %11
  %arrayidx57 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx41, i64 0, i64 %indvars.iv.next
  %12 = load i32, i32* %arrayidx57, align 4
  %add58 = add nsw i32 %add51, %12
  %div = sdiv i32 %add58, 9
  store i32 %div, i32* %arrayidx31, align 4
  br label %for.cond4

for.end:                                          ; preds = %for.cond4
  %indvars.iv.next3 = add nuw nsw i64 %indvars.iv2, 1
  br label %for.cond1

for.end65:                                        ; preds = %for.cond1
  %inc67 = add nuw nsw i32 %0, 1
  br label %for.cond

for.end68:                                        ; preds = %for.cond
  ret i32 0
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 724bf4ee23a3993689d55afb2845949e05c83b1c)"}
