; ModuleID = 'j2d-reg.ll'
source_filename = "jacobi-2d.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@main.A = internal global [20 x [20 x i32]] zeroinitializer, align 16
@main.B = internal global [20 x [20 x i32]] zeroinitializer, align 16

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.end87, %entry
  %0 = phi i32 [ %inc89, %for.end87 ], [ 0, %entry ]
  %exitcond16 = icmp ne i32 %0, 100
  br i1 %exitcond16, label %for.body, label %for.end90

for.body:                                         ; preds = %for.cond
  br label %for.cond1

for.cond1:                                        ; preds = %for.end, %for.body
  %indvars.iv2 = phi i64 [ %indvars.iv.next3, %for.end ], [ 1, %for.body ]
  %exitcond6 = icmp ne i64 %indvars.iv2, 19
  br i1 %exitcond6, label %for.body3, label %for.end38

for.body3:                                        ; preds = %for.cond1
  br label %for.cond4

for.cond4:                                        ; preds = %for.body6, %for.body3
  %indvars.iv = phi i64 [ %indvars.iv.next, %for.body6 ], [ 1, %for.body3 ]
  %exitcond = icmp ne i64 %indvars.iv, 19
  br i1 %exitcond, label %for.body6, label %for.end

for.body6:                                        ; preds = %for.cond4
  %arrayidx = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* @main.A, i64 0, i64 %indvars.iv2
  %arrayidx8 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx, i64 0, i64 %indvars.iv
  %1 = load i32, i32* %arrayidx8, align 4
  %2 = sub nuw nsw i64 %indvars.iv, 1
  %arrayidx12 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx, i64 0, i64 %2
  %3 = load i32, i32* %arrayidx12, align 4
  %add = add nsw i32 %1, %3
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %arrayidx17 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx, i64 0, i64 %indvars.iv.next
  %4 = load i32, i32* %arrayidx17, align 4
  %add18 = add nsw i32 %add, %4
  %5 = add nuw nsw i64 1, %indvars.iv2
  %arrayidx21 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* @main.A, i64 0, i64 %5
  %arrayidx23 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx21, i64 0, i64 %indvars.iv
  %6 = load i32, i32* %arrayidx23, align 4
  %add24 = add nsw i32 %add18, %6
  %7 = sub nuw nsw i64 %indvars.iv2, 1
  %arrayidx27 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* @main.A, i64 0, i64 %7
  %arrayidx29 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx27, i64 0, i64 %indvars.iv
  %8 = load i32, i32* %arrayidx29, align 4
  %add30 = add nsw i32 %add24, %8
  %conv = sitofp i32 %add30 to double
  %mul = fmul double 2.000000e-01, %conv
  %conv31 = fptosi double %mul to i32
  %arrayidx33 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* @main.B, i64 0, i64 %indvars.iv2
  %arrayidx35 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx33, i64 0, i64 %indvars.iv
  store i32 %conv31, i32* %arrayidx35, align 4
  br label %for.cond4

for.end:                                          ; preds = %for.cond4
  %indvars.iv.next3 = add nuw nsw i64 %indvars.iv2, 1
  br label %for.cond1

for.end38:                                        ; preds = %for.cond1
  br label %for.cond39

for.cond39:                                       ; preds = %for.end84, %for.end38
  %indvars.iv11 = phi i64 [ %indvars.iv.next12, %for.end84 ], [ 1, %for.end38 ]
  %exitcond15 = icmp ne i64 %indvars.iv11, 19
  br i1 %exitcond15, label %for.body42, label %for.end87

for.body42:                                       ; preds = %for.cond39
  br label %for.cond43

for.cond43:                                       ; preds = %for.body46, %for.body42
  %indvars.iv7 = phi i64 [ %indvars.iv.next8, %for.body46 ], [ 1, %for.body42 ]
  %exitcond10 = icmp ne i64 %indvars.iv7, 19
  br i1 %exitcond10, label %for.body46, label %for.end84

for.body46:                                       ; preds = %for.cond43
  %arrayidx48 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* @main.B, i64 0, i64 %indvars.iv11
  %arrayidx50 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx48, i64 0, i64 %indvars.iv7
  %9 = load i32, i32* %arrayidx50, align 4
  %10 = sub nuw nsw i64 %indvars.iv7, 1
  %arrayidx55 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx48, i64 0, i64 %10
  %11 = load i32, i32* %arrayidx55, align 4
  %add56 = add nsw i32 %9, %11
  %indvars.iv.next8 = add nuw nsw i64 %indvars.iv7, 1
  %arrayidx61 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx48, i64 0, i64 %indvars.iv.next8
  %12 = load i32, i32* %arrayidx61, align 4
  %add62 = add nsw i32 %add56, %12
  %13 = add nuw nsw i64 1, %indvars.iv11
  %arrayidx65 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* @main.B, i64 0, i64 %13
  %arrayidx67 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx65, i64 0, i64 %indvars.iv7
  %14 = load i32, i32* %arrayidx67, align 4
  %add68 = add nsw i32 %add62, %14
  %15 = sub nuw nsw i64 %indvars.iv11, 1
  %arrayidx71 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* @main.B, i64 0, i64 %15
  %arrayidx73 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx71, i64 0, i64 %indvars.iv7
  %16 = load i32, i32* %arrayidx73, align 4
  %add74 = add nsw i32 %add68, %16
  %conv75 = sitofp i32 %add74 to double
  %mul76 = fmul double 2.000000e-01, %conv75
  %conv77 = fptosi double %mul76 to i32
  %arrayidx79 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* @main.A, i64 0, i64 %indvars.iv11
  %arrayidx81 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx79, i64 0, i64 %indvars.iv7
  store i32 %conv77, i32* %arrayidx81, align 4
  br label %for.cond43

for.end84:                                        ; preds = %for.cond43
  %indvars.iv.next12 = add nuw nsw i64 %indvars.iv11, 1
  br label %for.cond39

for.end87:                                        ; preds = %for.cond39
  %inc89 = add nuw nsw i32 %0, 1
  br label %for.cond

for.end90:                                        ; preds = %for.cond
  ret i32 0
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 724bf4ee23a3993689d55afb2845949e05c83b1c)"}
