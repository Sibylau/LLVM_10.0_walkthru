; ModuleID = 'j1d.ll'
source_filename = "jacobi-1d.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
entry:
  %A = alloca [50 x i32], align 16
  %B = alloca [50 x i32], align 16
  br label %for.cond

for.cond:                                         ; preds = %for.end31, %entry
  %0 = phi i32 [ %inc33, %for.end31 ], [ 0, %entry ]
  %exitcond6 = icmp ne i32 %0, 50
  br i1 %exitcond6, label %for.body, label %for.end34

for.body:                                         ; preds = %for.cond
  br label %for.cond1

for.cond1:                                        ; preds = %for.body3, %for.body
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body3 ], [ 1, %for.body ]
  %exitcond = icmp ne i64 %indvars.iv, 49
  br i1 %exitcond, label %for.body3, label %for.end

for.body3:                                        ; preds = %for.cond1
  %1 = sub nuw nsw i64 %indvars.iv, 1
  %arrayidx = getelementptr inbounds [50 x i32], [50 x i32]* %A, i64 0, i64 %1
  %2 = load i32, i32* %arrayidx, align 4
  %arrayidx5 = getelementptr inbounds [50 x i32], [50 x i32]* %A, i64 0, i64 %indvars.iv
  %3 = load i32, i32* %arrayidx5, align 4
  %add = add nsw i32 %2, %3
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %arrayidx8 = getelementptr inbounds [50 x i32], [50 x i32]* %A, i64 0, i64 %indvars.iv.next
  %4 = load i32, i32* %arrayidx8, align 4
  %add9 = add nsw i32 %add, %4
  %mul = mul nsw i32 3, %add9
  %arrayidx11 = getelementptr inbounds [50 x i32], [50 x i32]* %B, i64 0, i64 %indvars.iv
  store i32 %mul, i32* %arrayidx11, align 4
  br label %for.cond1

for.end:                                          ; preds = %for.cond1
  br label %for.cond13

for.cond13:                                       ; preds = %for.body15, %for.end
  %indvars.iv2 = phi i64 [ %indvars.iv.next3, %for.body15 ], [ 1, %for.end ]
  %exitcond5 = icmp ne i64 %indvars.iv2, 49
  br i1 %exitcond5, label %for.body15, label %for.end31

for.body15:                                       ; preds = %for.cond13
  %5 = sub nuw nsw i64 %indvars.iv2, 1
  %arrayidx18 = getelementptr inbounds [50 x i32], [50 x i32]* %B, i64 0, i64 %5
  %6 = load i32, i32* %arrayidx18, align 4
  %arrayidx20 = getelementptr inbounds [50 x i32], [50 x i32]* %B, i64 0, i64 %indvars.iv2
  %7 = load i32, i32* %arrayidx20, align 4
  %add21 = add nsw i32 %6, %7
  %indvars.iv.next3 = add nuw nsw i64 %indvars.iv2, 1
  %arrayidx24 = getelementptr inbounds [50 x i32], [50 x i32]* %B, i64 0, i64 %indvars.iv.next3
  %8 = load i32, i32* %arrayidx24, align 4
  %add25 = add nsw i32 %add21, %8
  %mul26 = mul nsw i32 3, %add25
  %arrayidx28 = getelementptr inbounds [50 x i32], [50 x i32]* %A, i64 0, i64 %indvars.iv2
  store i32 %mul26, i32* %arrayidx28, align 4
  br label %for.cond13

for.end31:                                        ; preds = %for.cond13
  %inc33 = add nuw nsw i32 %0, 1
  br label %for.cond

for.end34:                                        ; preds = %for.cond
  ret i32 0
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 724bf4ee23a3993689d55afb2845949e05c83b1c)"}
