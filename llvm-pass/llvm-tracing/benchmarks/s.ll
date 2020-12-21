; ModuleID = 'seidel-2d.c'
source_filename = "seidel-2d.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@main.A = internal global [20 x [20 x i32]] zeroinitializer, align 16

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %t = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  store i32 0, i32* %t, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc66, %entry
  %0 = load i32, i32* %t, align 4
  %cmp = icmp ule i32 %0, 19
  br i1 %cmp, label %for.body, label %for.end68

for.body:                                         ; preds = %for.cond
  store i32 1, i32* %i, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc63, %for.body
  %1 = load i32, i32* %i, align 4
  %cmp2 = icmp ule i32 %1, 18
  br i1 %cmp2, label %for.body3, label %for.end65

for.body3:                                        ; preds = %for.cond1
  store i32 1, i32* %j, align 4
  br label %for.cond4

for.cond4:                                        ; preds = %for.inc, %for.body3
  %2 = load i32, i32* %j, align 4
  %cmp5 = icmp ule i32 %2, 18
  br i1 %cmp5, label %for.body6, label %for.end

for.body6:                                        ; preds = %for.cond4
  %3 = load i32, i32* %i, align 4
  %sub = sub i32 %3, 1
  %idxprom = zext i32 %sub to i64
  %arrayidx = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* @main.A, i64 0, i64 %idxprom
  %4 = load i32, i32* %j, align 4
  %sub7 = sub i32 %4, 1
  %idxprom8 = zext i32 %sub7 to i64
  %arrayidx9 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx, i64 0, i64 %idxprom8
  %5 = load i32, i32* %arrayidx9, align 4
  %6 = load i32, i32* %i, align 4
  %sub10 = sub i32 %6, 1
  %idxprom11 = zext i32 %sub10 to i64
  %arrayidx12 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* @main.A, i64 0, i64 %idxprom11
  %7 = load i32, i32* %j, align 4
  %idxprom13 = zext i32 %7 to i64
  %arrayidx14 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx12, i64 0, i64 %idxprom13
  %8 = load i32, i32* %arrayidx14, align 4
  %add = add nsw i32 %5, %8
  %9 = load i32, i32* %i, align 4
  %sub15 = sub i32 %9, 1
  %idxprom16 = zext i32 %sub15 to i64
  %arrayidx17 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* @main.A, i64 0, i64 %idxprom16
  %10 = load i32, i32* %j, align 4
  %add18 = add i32 %10, 1
  %idxprom19 = zext i32 %add18 to i64
  %arrayidx20 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx17, i64 0, i64 %idxprom19
  %11 = load i32, i32* %arrayidx20, align 4
  %add21 = add nsw i32 %add, %11
  %12 = load i32, i32* %i, align 4
  %idxprom22 = zext i32 %12 to i64
  %arrayidx23 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* @main.A, i64 0, i64 %idxprom22
  %13 = load i32, i32* %j, align 4
  %sub24 = sub i32 %13, 1
  %idxprom25 = zext i32 %sub24 to i64
  %arrayidx26 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx23, i64 0, i64 %idxprom25
  %14 = load i32, i32* %arrayidx26, align 4
  %add27 = add nsw i32 %add21, %14
  %15 = load i32, i32* %i, align 4
  %idxprom28 = zext i32 %15 to i64
  %arrayidx29 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* @main.A, i64 0, i64 %idxprom28
  %16 = load i32, i32* %j, align 4
  %idxprom30 = zext i32 %16 to i64
  %arrayidx31 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx29, i64 0, i64 %idxprom30
  %17 = load i32, i32* %arrayidx31, align 4
  %add32 = add nsw i32 %add27, %17
  %18 = load i32, i32* %i, align 4
  %idxprom33 = zext i32 %18 to i64
  %arrayidx34 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* @main.A, i64 0, i64 %idxprom33
  %19 = load i32, i32* %j, align 4
  %add35 = add i32 %19, 1
  %idxprom36 = zext i32 %add35 to i64
  %arrayidx37 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx34, i64 0, i64 %idxprom36
  %20 = load i32, i32* %arrayidx37, align 4
  %add38 = add nsw i32 %add32, %20
  %21 = load i32, i32* %i, align 4
  %add39 = add i32 %21, 1
  %idxprom40 = zext i32 %add39 to i64
  %arrayidx41 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* @main.A, i64 0, i64 %idxprom40
  %22 = load i32, i32* %j, align 4
  %sub42 = sub i32 %22, 1
  %idxprom43 = zext i32 %sub42 to i64
  %arrayidx44 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx41, i64 0, i64 %idxprom43
  %23 = load i32, i32* %arrayidx44, align 4
  %add45 = add nsw i32 %add38, %23
  %24 = load i32, i32* %i, align 4
  %add46 = add i32 %24, 1
  %idxprom47 = zext i32 %add46 to i64
  %arrayidx48 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* @main.A, i64 0, i64 %idxprom47
  %25 = load i32, i32* %j, align 4
  %idxprom49 = zext i32 %25 to i64
  %arrayidx50 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx48, i64 0, i64 %idxprom49
  %26 = load i32, i32* %arrayidx50, align 4
  %add51 = add nsw i32 %add45, %26
  %27 = load i32, i32* %i, align 4
  %add52 = add i32 %27, 1
  %idxprom53 = zext i32 %add52 to i64
  %arrayidx54 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* @main.A, i64 0, i64 %idxprom53
  %28 = load i32, i32* %j, align 4
  %add55 = add i32 %28, 1
  %idxprom56 = zext i32 %add55 to i64
  %arrayidx57 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx54, i64 0, i64 %idxprom56
  %29 = load i32, i32* %arrayidx57, align 4
  %add58 = add nsw i32 %add51, %29
  %div = sdiv i32 %add58, 9
  %30 = load i32, i32* %i, align 4
  %idxprom59 = zext i32 %30 to i64
  %arrayidx60 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* @main.A, i64 0, i64 %idxprom59
  %31 = load i32, i32* %j, align 4
  %idxprom61 = zext i32 %31 to i64
  %arrayidx62 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx60, i64 0, i64 %idxprom61
  store i32 %div, i32* %arrayidx62, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body6
  %32 = load i32, i32* %j, align 4
  %inc = add i32 %32, 1
  store i32 %inc, i32* %j, align 4
  br label %for.cond4

for.end:                                          ; preds = %for.cond4
  br label %for.inc63

for.inc63:                                        ; preds = %for.end
  %33 = load i32, i32* %i, align 4
  %inc64 = add i32 %33, 1
  store i32 %inc64, i32* %i, align 4
  br label %for.cond1

for.end65:                                        ; preds = %for.cond1
  br label %for.inc66

for.inc66:                                        ; preds = %for.end65
  %34 = load i32, i32* %t, align 4
  %inc67 = add i32 %34, 1
  store i32 %inc67, i32* %t, align 4
  br label %for.cond

for.end68:                                        ; preds = %for.cond
  ret i32 0
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 724bf4ee23a3993689d55afb2845949e05c83b1c)"}
