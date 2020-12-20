; ModuleID = 'heat-2d.c'
source_filename = "heat-2d.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %t = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %A = alloca [20 x [20 x [20 x i32]]], align 16
  %B = alloca [20 x [20 x [20 x i32]]], align 16
  %i1 = alloca i32, align 4
  %j2 = alloca i32, align 4
  %k = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  store i32 1, i32* %i1, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc94, %entry
  %0 = load i32, i32* %i1, align 4
  %cmp = icmp ult i32 %0, 19
  br i1 %cmp, label %for.body, label %for.end96

for.body:                                         ; preds = %for.cond
  store i32 1, i32* %j2, align 4
  br label %for.cond3

for.cond3:                                        ; preds = %for.inc91, %for.body
  %1 = load i32, i32* %j2, align 4
  %cmp4 = icmp ult i32 %1, 19
  br i1 %cmp4, label %for.body5, label %for.end93

for.body5:                                        ; preds = %for.cond3
  store i32 1, i32* %k, align 4
  br label %for.cond6

for.cond6:                                        ; preds = %for.inc, %for.body5
  %2 = load i32, i32* %k, align 4
  %cmp7 = icmp ult i32 %2, 19
  br i1 %cmp7, label %for.body8, label %for.end

for.body8:                                        ; preds = %for.cond6
  %3 = load i32, i32* %i1, align 4
  %add = add i32 %3, 1
  %idxprom = zext i32 %add to i64
  %arrayidx = getelementptr inbounds [20 x [20 x [20 x i32]]], [20 x [20 x [20 x i32]]]* %A, i64 0, i64 %idxprom
  %4 = load i32, i32* %j2, align 4
  %idxprom9 = zext i32 %4 to i64
  %arrayidx10 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* %arrayidx, i64 0, i64 %idxprom9
  %5 = load i32, i32* %k, align 4
  %idxprom11 = zext i32 %5 to i64
  %arrayidx12 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx10, i64 0, i64 %idxprom11
  %6 = load i32, i32* %arrayidx12, align 4
  %7 = load i32, i32* %i1, align 4
  %idxprom13 = zext i32 %7 to i64
  %arrayidx14 = getelementptr inbounds [20 x [20 x [20 x i32]]], [20 x [20 x [20 x i32]]]* %A, i64 0, i64 %idxprom13
  %8 = load i32, i32* %j2, align 4
  %idxprom15 = zext i32 %8 to i64
  %arrayidx16 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* %arrayidx14, i64 0, i64 %idxprom15
  %9 = load i32, i32* %k, align 4
  %idxprom17 = zext i32 %9 to i64
  %arrayidx18 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx16, i64 0, i64 %idxprom17
  %10 = load i32, i32* %arrayidx18, align 4
  %mul = mul nsw i32 2, %10
  %sub = sub nsw i32 %6, %mul
  %11 = load i32, i32* %i1, align 4
  %sub19 = sub i32 %11, 1
  %idxprom20 = zext i32 %sub19 to i64
  %arrayidx21 = getelementptr inbounds [20 x [20 x [20 x i32]]], [20 x [20 x [20 x i32]]]* %A, i64 0, i64 %idxprom20
  %12 = load i32, i32* %j2, align 4
  %idxprom22 = zext i32 %12 to i64
  %arrayidx23 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* %arrayidx21, i64 0, i64 %idxprom22
  %13 = load i32, i32* %k, align 4
  %idxprom24 = zext i32 %13 to i64
  %arrayidx25 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx23, i64 0, i64 %idxprom24
  %14 = load i32, i32* %arrayidx25, align 4
  %add26 = add nsw i32 %sub, %14
  %mul27 = mul nsw i32 12, %add26
  %15 = load i32, i32* %i1, align 4
  %idxprom28 = zext i32 %15 to i64
  %arrayidx29 = getelementptr inbounds [20 x [20 x [20 x i32]]], [20 x [20 x [20 x i32]]]* %A, i64 0, i64 %idxprom28
  %16 = load i32, i32* %j2, align 4
  %add30 = add i32 %16, 1
  %idxprom31 = zext i32 %add30 to i64
  %arrayidx32 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* %arrayidx29, i64 0, i64 %idxprom31
  %17 = load i32, i32* %k, align 4
  %idxprom33 = zext i32 %17 to i64
  %arrayidx34 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx32, i64 0, i64 %idxprom33
  %18 = load i32, i32* %arrayidx34, align 4
  %19 = load i32, i32* %i1, align 4
  %idxprom35 = zext i32 %19 to i64
  %arrayidx36 = getelementptr inbounds [20 x [20 x [20 x i32]]], [20 x [20 x [20 x i32]]]* %A, i64 0, i64 %idxprom35
  %20 = load i32, i32* %j2, align 4
  %idxprom37 = zext i32 %20 to i64
  %arrayidx38 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* %arrayidx36, i64 0, i64 %idxprom37
  %21 = load i32, i32* %k, align 4
  %idxprom39 = zext i32 %21 to i64
  %arrayidx40 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx38, i64 0, i64 %idxprom39
  %22 = load i32, i32* %arrayidx40, align 4
  %mul41 = mul nsw i32 2, %22
  %sub42 = sub nsw i32 %18, %mul41
  %23 = load i32, i32* %i1, align 4
  %idxprom43 = zext i32 %23 to i64
  %arrayidx44 = getelementptr inbounds [20 x [20 x [20 x i32]]], [20 x [20 x [20 x i32]]]* %A, i64 0, i64 %idxprom43
  %24 = load i32, i32* %j2, align 4
  %sub45 = sub i32 %24, 1
  %idxprom46 = zext i32 %sub45 to i64
  %arrayidx47 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* %arrayidx44, i64 0, i64 %idxprom46
  %25 = load i32, i32* %k, align 4
  %idxprom48 = zext i32 %25 to i64
  %arrayidx49 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx47, i64 0, i64 %idxprom48
  %26 = load i32, i32* %arrayidx49, align 4
  %add50 = add nsw i32 %sub42, %26
  %mul51 = mul nsw i32 2, %add50
  %add52 = add nsw i32 %mul27, %mul51
  %27 = load i32, i32* %i1, align 4
  %idxprom53 = zext i32 %27 to i64
  %arrayidx54 = getelementptr inbounds [20 x [20 x [20 x i32]]], [20 x [20 x [20 x i32]]]* %A, i64 0, i64 %idxprom53
  %28 = load i32, i32* %j2, align 4
  %idxprom55 = zext i32 %28 to i64
  %arrayidx56 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* %arrayidx54, i64 0, i64 %idxprom55
  %29 = load i32, i32* %k, align 4
  %add57 = add i32 %29, 1
  %idxprom58 = zext i32 %add57 to i64
  %arrayidx59 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx56, i64 0, i64 %idxprom58
  %30 = load i32, i32* %arrayidx59, align 4
  %31 = load i32, i32* %i1, align 4
  %idxprom60 = zext i32 %31 to i64
  %arrayidx61 = getelementptr inbounds [20 x [20 x [20 x i32]]], [20 x [20 x [20 x i32]]]* %A, i64 0, i64 %idxprom60
  %32 = load i32, i32* %j2, align 4
  %idxprom62 = zext i32 %32 to i64
  %arrayidx63 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* %arrayidx61, i64 0, i64 %idxprom62
  %33 = load i32, i32* %k, align 4
  %idxprom64 = zext i32 %33 to i64
  %arrayidx65 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx63, i64 0, i64 %idxprom64
  %34 = load i32, i32* %arrayidx65, align 4
  %mul66 = mul nsw i32 2, %34
  %sub67 = sub nsw i32 %30, %mul66
  %35 = load i32, i32* %i1, align 4
  %idxprom68 = zext i32 %35 to i64
  %arrayidx69 = getelementptr inbounds [20 x [20 x [20 x i32]]], [20 x [20 x [20 x i32]]]* %A, i64 0, i64 %idxprom68
  %36 = load i32, i32* %j2, align 4
  %idxprom70 = zext i32 %36 to i64
  %arrayidx71 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* %arrayidx69, i64 0, i64 %idxprom70
  %37 = load i32, i32* %k, align 4
  %sub72 = sub i32 %37, 1
  %idxprom73 = zext i32 %sub72 to i64
  %arrayidx74 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx71, i64 0, i64 %idxprom73
  %38 = load i32, i32* %arrayidx74, align 4
  %add75 = add nsw i32 %sub67, %38
  %mul76 = mul nsw i32 2, %add75
  %add77 = add nsw i32 %add52, %mul76
  %39 = load i32, i32* %i1, align 4
  %idxprom78 = zext i32 %39 to i64
  %arrayidx79 = getelementptr inbounds [20 x [20 x [20 x i32]]], [20 x [20 x [20 x i32]]]* %A, i64 0, i64 %idxprom78
  %40 = load i32, i32* %j2, align 4
  %idxprom80 = zext i32 %40 to i64
  %arrayidx81 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* %arrayidx79, i64 0, i64 %idxprom80
  %41 = load i32, i32* %k, align 4
  %idxprom82 = zext i32 %41 to i64
  %arrayidx83 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx81, i64 0, i64 %idxprom82
  %42 = load i32, i32* %arrayidx83, align 4
  %add84 = add nsw i32 %add77, %42
  %43 = load i32, i32* %i1, align 4
  %idxprom85 = zext i32 %43 to i64
  %arrayidx86 = getelementptr inbounds [20 x [20 x [20 x i32]]], [20 x [20 x [20 x i32]]]* %B, i64 0, i64 %idxprom85
  %44 = load i32, i32* %j2, align 4
  %idxprom87 = zext i32 %44 to i64
  %arrayidx88 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* %arrayidx86, i64 0, i64 %idxprom87
  %45 = load i32, i32* %k, align 4
  %idxprom89 = zext i32 %45 to i64
  %arrayidx90 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx88, i64 0, i64 %idxprom89
  store i32 %add84, i32* %arrayidx90, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body8
  %46 = load i32, i32* %k, align 4
  %inc = add i32 %46, 1
  store i32 %inc, i32* %k, align 4
  br label %for.cond6

for.end:                                          ; preds = %for.cond6
  br label %for.inc91

for.inc91:                                        ; preds = %for.end
  %47 = load i32, i32* %j2, align 4
  %inc92 = add i32 %47, 1
  store i32 %inc92, i32* %j2, align 4
  br label %for.cond3

for.end93:                                        ; preds = %for.cond3
  br label %for.inc94

for.inc94:                                        ; preds = %for.end93
  %48 = load i32, i32* %i1, align 4
  %inc95 = add i32 %48, 1
  store i32 %inc95, i32* %i1, align 4
  br label %for.cond

for.end96:                                        ; preds = %for.cond
  ret i32 0
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 724bf4ee23a3993689d55afb2845949e05c83b1c)"}
