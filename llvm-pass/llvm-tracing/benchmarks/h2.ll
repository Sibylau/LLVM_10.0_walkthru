; ModuleID = 'h1.ll'
source_filename = "heat-2d.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
entry:
  %A = alloca [20 x [20 x [20 x i32]]], align 16
  %B = alloca [20 x [20 x [20 x i32]]], align 16
  br label %for.cond

for.cond:                                         ; preds = %for.end93, %entry
  %0 = phi i32 [ %inc95, %for.end93 ], [ 1, %entry ]
  %cmp = icmp ult i32 %0, 19
  br i1 %cmp, label %for.body, label %for.end96

for.body:                                         ; preds = %for.cond
  br label %for.cond3

for.cond3:                                        ; preds = %for.end, %for.body
  %1 = phi i32 [ %.lcssa, %for.end ], [ %0, %for.body ]
  %2 = phi i32 [ %inc92, %for.end ], [ 1, %for.body ]
  %cmp4 = icmp ult i32 %2, 19
  br i1 %cmp4, label %for.body5, label %for.end93

for.body5:                                        ; preds = %for.cond3
  br label %for.cond6

for.cond6:                                        ; preds = %for.body8, %for.body5
  %3 = phi i32 [ %add57, %for.body8 ], [ 1, %for.body5 ]
  %4 = phi i32 [ %0, %for.body8 ], [ %1, %for.body5 ]
  %cmp7 = icmp ult i32 %3, 19
  br i1 %cmp7, label %for.body8, label %for.end

for.body8:                                        ; preds = %for.cond6
  %add = add i32 %4, 1
  %idxprom = zext i32 %add to i64
  %arrayidx = getelementptr inbounds [20 x [20 x [20 x i32]]], [20 x [20 x [20 x i32]]]* %A, i64 0, i64 %idxprom
  %idxprom9 = zext i32 %2 to i64
  %arrayidx10 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* %arrayidx, i64 0, i64 %idxprom9
  %idxprom11 = zext i32 %3 to i64
  %arrayidx12 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx10, i64 0, i64 %idxprom11
  %5 = load i32, i32* %arrayidx12, align 4
  %idxprom13 = zext i32 %4 to i64
  %arrayidx14 = getelementptr inbounds [20 x [20 x [20 x i32]]], [20 x [20 x [20 x i32]]]* %A, i64 0, i64 %idxprom13
  %arrayidx16 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* %arrayidx14, i64 0, i64 %idxprom9
  %arrayidx18 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx16, i64 0, i64 %idxprom11
  %6 = load i32, i32* %arrayidx18, align 4
  %mul = mul nsw i32 2, %6
  %sub = sub nsw i32 %5, %mul
  %sub19 = sub i32 %4, 1
  %idxprom20 = zext i32 %sub19 to i64
  %arrayidx21 = getelementptr inbounds [20 x [20 x [20 x i32]]], [20 x [20 x [20 x i32]]]* %A, i64 0, i64 %idxprom20
  %arrayidx23 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* %arrayidx21, i64 0, i64 %idxprom9
  %arrayidx25 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx23, i64 0, i64 %idxprom11
  %7 = load i32, i32* %arrayidx25, align 4
  %add26 = add nsw i32 %sub, %7
  %mul27 = mul nsw i32 12, %add26
  %add30 = add i32 %2, 1
  %idxprom31 = zext i32 %add30 to i64
  %arrayidx32 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* %arrayidx14, i64 0, i64 %idxprom31
  %arrayidx34 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx32, i64 0, i64 %idxprom11
  %8 = load i32, i32* %arrayidx34, align 4
  %sub42 = sub nsw i32 %8, %mul
  %sub45 = sub i32 %2, 1
  %idxprom46 = zext i32 %sub45 to i64
  %arrayidx47 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* %arrayidx14, i64 0, i64 %idxprom46
  %arrayidx49 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx47, i64 0, i64 %idxprom11
  %9 = load i32, i32* %arrayidx49, align 4
  %add50 = add nsw i32 %sub42, %9
  %mul51 = mul nsw i32 2, %add50
  %add52 = add nsw i32 %mul27, %mul51
  %add57 = add i32 %3, 1
  %idxprom58 = zext i32 %add57 to i64
  %arrayidx59 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx16, i64 0, i64 %idxprom58
  %10 = load i32, i32* %arrayidx59, align 4
  %sub67 = sub nsw i32 %10, %mul
  %sub72 = sub i32 %3, 1
  %idxprom73 = zext i32 %sub72 to i64
  %arrayidx74 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx16, i64 0, i64 %idxprom73
  %11 = load i32, i32* %arrayidx74, align 4
  %add75 = add nsw i32 %sub67, %11
  %mul76 = mul nsw i32 2, %add75
  %add77 = add nsw i32 %add52, %mul76
  %add84 = add nsw i32 %add77, %6
  %idxprom85 = zext i32 %0 to i64
  %arrayidx86 = getelementptr inbounds [20 x [20 x [20 x i32]]], [20 x [20 x [20 x i32]]]* %B, i64 0, i64 %idxprom85
  %arrayidx88 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* %arrayidx86, i64 0, i64 %idxprom9
  %arrayidx90 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx88, i64 0, i64 %idxprom11
  store i32 %add84, i32* %arrayidx90, align 4
  br label %for.cond6

for.end:                                          ; preds = %for.cond6
  %.lcssa = phi i32 [ %4, %for.cond6 ]
  %inc92 = add i32 %2, 1
  br label %for.cond3

for.end93:                                        ; preds = %for.cond3
  %.lcssa1 = phi i32 [ %1, %for.cond3 ]
  %inc95 = add i32 %.lcssa1, 1
  br label %for.cond

for.end96:                                        ; preds = %for.cond
  ret i32 0
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 724bf4ee23a3993689d55afb2845949e05c83b1c)"}
