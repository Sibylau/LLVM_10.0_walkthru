; ModuleID = 'heat-2d.c'
source_filename = "heat-2d.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %A = alloca [20 x [20 x [20 x i32]]], align 16
  %B = alloca [20 x [20 x [20 x i32]]], align 16
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  store i32 1, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc92, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp ult i32 %0, 19
  br i1 %cmp, label %for.body, label %for.end94

for.body:                                         ; preds = %for.cond
  store i32 1, i32* %j, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc89, %for.body
  %1 = load i32, i32* %j, align 4
  %cmp2 = icmp ult i32 %1, 19
  br i1 %cmp2, label %for.body3, label %for.end91

for.body3:                                        ; preds = %for.cond1
  store i32 1, i32* %k, align 4
  br label %for.cond4

for.cond4:                                        ; preds = %for.inc, %for.body3
  %2 = load i32, i32* %k, align 4
  %cmp5 = icmp ult i32 %2, 19
  br i1 %cmp5, label %for.body6, label %for.end

for.body6:                                        ; preds = %for.cond4
  %3 = load i32, i32* %i, align 4
  %add = add i32 %3, 1
  %idxprom = zext i32 %add to i64
  %arrayidx = getelementptr inbounds [20 x [20 x [20 x i32]]], [20 x [20 x [20 x i32]]]* %A, i64 0, i64 %idxprom
  %4 = load i32, i32* %j, align 4
  %idxprom7 = zext i32 %4 to i64
  %arrayidx8 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* %arrayidx, i64 0, i64 %idxprom7
  %5 = load i32, i32* %k, align 4
  %idxprom9 = zext i32 %5 to i64
  %arrayidx10 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx8, i64 0, i64 %idxprom9
  %6 = load i32, i32* %arrayidx10, align 4
  %7 = load i32, i32* %i, align 4
  %idxprom11 = zext i32 %7 to i64
  %arrayidx12 = getelementptr inbounds [20 x [20 x [20 x i32]]], [20 x [20 x [20 x i32]]]* %A, i64 0, i64 %idxprom11
  %8 = load i32, i32* %j, align 4
  %idxprom13 = zext i32 %8 to i64
  %arrayidx14 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* %arrayidx12, i64 0, i64 %idxprom13
  %9 = load i32, i32* %k, align 4
  %idxprom15 = zext i32 %9 to i64
  %arrayidx16 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx14, i64 0, i64 %idxprom15
  %10 = load i32, i32* %arrayidx16, align 4
  %mul = mul nsw i32 2, %10
  %sub = sub nsw i32 %6, %mul
  %11 = load i32, i32* %i, align 4
  %sub17 = sub i32 %11, 1
  %idxprom18 = zext i32 %sub17 to i64
  %arrayidx19 = getelementptr inbounds [20 x [20 x [20 x i32]]], [20 x [20 x [20 x i32]]]* %A, i64 0, i64 %idxprom18
  %12 = load i32, i32* %j, align 4
  %idxprom20 = zext i32 %12 to i64
  %arrayidx21 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* %arrayidx19, i64 0, i64 %idxprom20
  %13 = load i32, i32* %k, align 4
  %idxprom22 = zext i32 %13 to i64
  %arrayidx23 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx21, i64 0, i64 %idxprom22
  %14 = load i32, i32* %arrayidx23, align 4
  %add24 = add nsw i32 %sub, %14
  %mul25 = mul nsw i32 12, %add24
  %15 = load i32, i32* %i, align 4
  %idxprom26 = zext i32 %15 to i64
  %arrayidx27 = getelementptr inbounds [20 x [20 x [20 x i32]]], [20 x [20 x [20 x i32]]]* %A, i64 0, i64 %idxprom26
  %16 = load i32, i32* %j, align 4
  %add28 = add i32 %16, 1
  %idxprom29 = zext i32 %add28 to i64
  %arrayidx30 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* %arrayidx27, i64 0, i64 %idxprom29
  %17 = load i32, i32* %k, align 4
  %idxprom31 = zext i32 %17 to i64
  %arrayidx32 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx30, i64 0, i64 %idxprom31
  %18 = load i32, i32* %arrayidx32, align 4
  %19 = load i32, i32* %i, align 4
  %idxprom33 = zext i32 %19 to i64
  %arrayidx34 = getelementptr inbounds [20 x [20 x [20 x i32]]], [20 x [20 x [20 x i32]]]* %A, i64 0, i64 %idxprom33
  %20 = load i32, i32* %j, align 4
  %idxprom35 = zext i32 %20 to i64
  %arrayidx36 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* %arrayidx34, i64 0, i64 %idxprom35
  %21 = load i32, i32* %k, align 4
  %idxprom37 = zext i32 %21 to i64
  %arrayidx38 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx36, i64 0, i64 %idxprom37
  %22 = load i32, i32* %arrayidx38, align 4
  %mul39 = mul nsw i32 2, %22
  %sub40 = sub nsw i32 %18, %mul39
  %23 = load i32, i32* %i, align 4
  %idxprom41 = zext i32 %23 to i64
  %arrayidx42 = getelementptr inbounds [20 x [20 x [20 x i32]]], [20 x [20 x [20 x i32]]]* %A, i64 0, i64 %idxprom41
  %24 = load i32, i32* %j, align 4
  %sub43 = sub i32 %24, 1
  %idxprom44 = zext i32 %sub43 to i64
  %arrayidx45 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* %arrayidx42, i64 0, i64 %idxprom44
  %25 = load i32, i32* %k, align 4
  %idxprom46 = zext i32 %25 to i64
  %arrayidx47 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx45, i64 0, i64 %idxprom46
  %26 = load i32, i32* %arrayidx47, align 4
  %add48 = add nsw i32 %sub40, %26
  %mul49 = mul nsw i32 2, %add48
  %add50 = add nsw i32 %mul25, %mul49
  %27 = load i32, i32* %i, align 4
  %idxprom51 = zext i32 %27 to i64
  %arrayidx52 = getelementptr inbounds [20 x [20 x [20 x i32]]], [20 x [20 x [20 x i32]]]* %A, i64 0, i64 %idxprom51
  %28 = load i32, i32* %j, align 4
  %idxprom53 = zext i32 %28 to i64
  %arrayidx54 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* %arrayidx52, i64 0, i64 %idxprom53
  %29 = load i32, i32* %k, align 4
  %add55 = add i32 %29, 1
  %idxprom56 = zext i32 %add55 to i64
  %arrayidx57 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx54, i64 0, i64 %idxprom56
  %30 = load i32, i32* %arrayidx57, align 4
  %31 = load i32, i32* %i, align 4
  %idxprom58 = zext i32 %31 to i64
  %arrayidx59 = getelementptr inbounds [20 x [20 x [20 x i32]]], [20 x [20 x [20 x i32]]]* %A, i64 0, i64 %idxprom58
  %32 = load i32, i32* %j, align 4
  %idxprom60 = zext i32 %32 to i64
  %arrayidx61 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* %arrayidx59, i64 0, i64 %idxprom60
  %33 = load i32, i32* %k, align 4
  %idxprom62 = zext i32 %33 to i64
  %arrayidx63 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx61, i64 0, i64 %idxprom62
  %34 = load i32, i32* %arrayidx63, align 4
  %mul64 = mul nsw i32 2, %34
  %sub65 = sub nsw i32 %30, %mul64
  %35 = load i32, i32* %i, align 4
  %idxprom66 = zext i32 %35 to i64
  %arrayidx67 = getelementptr inbounds [20 x [20 x [20 x i32]]], [20 x [20 x [20 x i32]]]* %A, i64 0, i64 %idxprom66
  %36 = load i32, i32* %j, align 4
  %idxprom68 = zext i32 %36 to i64
  %arrayidx69 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* %arrayidx67, i64 0, i64 %idxprom68
  %37 = load i32, i32* %k, align 4
  %sub70 = sub i32 %37, 1
  %idxprom71 = zext i32 %sub70 to i64
  %arrayidx72 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx69, i64 0, i64 %idxprom71
  %38 = load i32, i32* %arrayidx72, align 4
  %add73 = add nsw i32 %sub65, %38
  %mul74 = mul nsw i32 2, %add73
  %add75 = add nsw i32 %add50, %mul74
  %39 = load i32, i32* %i, align 4
  %idxprom76 = zext i32 %39 to i64
  %arrayidx77 = getelementptr inbounds [20 x [20 x [20 x i32]]], [20 x [20 x [20 x i32]]]* %A, i64 0, i64 %idxprom76
  %40 = load i32, i32* %j, align 4
  %idxprom78 = zext i32 %40 to i64
  %arrayidx79 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* %arrayidx77, i64 0, i64 %idxprom78
  %41 = load i32, i32* %k, align 4
  %idxprom80 = zext i32 %41 to i64
  %arrayidx81 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx79, i64 0, i64 %idxprom80
  %42 = load i32, i32* %arrayidx81, align 4
  %add82 = add nsw i32 %add75, %42
  %43 = load i32, i32* %i, align 4
  %idxprom83 = zext i32 %43 to i64
  %arrayidx84 = getelementptr inbounds [20 x [20 x [20 x i32]]], [20 x [20 x [20 x i32]]]* %B, i64 0, i64 %idxprom83
  %44 = load i32, i32* %j, align 4
  %idxprom85 = zext i32 %44 to i64
  %arrayidx86 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* %arrayidx84, i64 0, i64 %idxprom85
  %45 = load i32, i32* %k, align 4
  %idxprom87 = zext i32 %45 to i64
  %arrayidx88 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx86, i64 0, i64 %idxprom87
  store i32 %add82, i32* %arrayidx88, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body6
  %46 = load i32, i32* %k, align 4
  %inc = add i32 %46, 1
  store i32 %inc, i32* %k, align 4
  br label %for.cond4

for.end:                                          ; preds = %for.cond4
  br label %for.inc89

for.inc89:                                        ; preds = %for.end
  %47 = load i32, i32* %j, align 4
  %inc90 = add i32 %47, 1
  store i32 %inc90, i32* %j, align 4
  br label %for.cond1

for.end91:                                        ; preds = %for.cond1
  br label %for.inc92

for.inc92:                                        ; preds = %for.end91
  %48 = load i32, i32* %i, align 4
  %inc93 = add i32 %48, 1
  store i32 %inc93, i32* %i, align 4
  br label %for.cond

for.end94:                                        ; preds = %for.cond
  ret i32 0
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 724bf4ee23a3993689d55afb2845949e05c83b1c)"}
