; ModuleID = 'jacobi-2d.c'
source_filename = "jacobi-2d.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@main.A = internal global [20 x [20 x i32]] zeroinitializer, align 16
@main.B = internal global [20 x [20 x i32]] zeroinitializer, align 16

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

for.cond:                                         ; preds = %for.inc88, %entry
  %0 = load i32, i32* %t, align 4
  %cmp = icmp ult i32 %0, 100
  br i1 %cmp, label %for.body, label %for.end90

for.body:                                         ; preds = %for.cond
  store i32 1, i32* %i, align 4
  br label %for.cond1

for.cond1:                                        ; preds = %for.inc36, %for.body
  %1 = load i32, i32* %i, align 4
  %cmp2 = icmp ult i32 %1, 19
  br i1 %cmp2, label %for.body3, label %for.end38

for.body3:                                        ; preds = %for.cond1
  store i32 1, i32* %j, align 4
  br label %for.cond4

for.cond4:                                        ; preds = %for.inc, %for.body3
  %2 = load i32, i32* %j, align 4
  %cmp5 = icmp ult i32 %2, 19
  br i1 %cmp5, label %for.body6, label %for.end

for.body6:                                        ; preds = %for.cond4
  %3 = load i32, i32* %i, align 4
  %idxprom = zext i32 %3 to i64
  %arrayidx = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* @main.A, i64 0, i64 %idxprom
  %4 = load i32, i32* %j, align 4
  %idxprom7 = zext i32 %4 to i64
  %arrayidx8 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx, i64 0, i64 %idxprom7
  %5 = load i32, i32* %arrayidx8, align 4
  %6 = load i32, i32* %i, align 4
  %idxprom9 = zext i32 %6 to i64
  %arrayidx10 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* @main.A, i64 0, i64 %idxprom9
  %7 = load i32, i32* %j, align 4
  %sub = sub i32 %7, 1
  %idxprom11 = zext i32 %sub to i64
  %arrayidx12 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx10, i64 0, i64 %idxprom11
  %8 = load i32, i32* %arrayidx12, align 4
  %add = add nsw i32 %5, %8
  %9 = load i32, i32* %i, align 4
  %idxprom13 = zext i32 %9 to i64
  %arrayidx14 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* @main.A, i64 0, i64 %idxprom13
  %10 = load i32, i32* %j, align 4
  %add15 = add i32 1, %10
  %idxprom16 = zext i32 %add15 to i64
  %arrayidx17 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx14, i64 0, i64 %idxprom16
  %11 = load i32, i32* %arrayidx17, align 4
  %add18 = add nsw i32 %add, %11
  %12 = load i32, i32* %i, align 4
  %add19 = add i32 1, %12
  %idxprom20 = zext i32 %add19 to i64
  %arrayidx21 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* @main.A, i64 0, i64 %idxprom20
  %13 = load i32, i32* %j, align 4
  %idxprom22 = zext i32 %13 to i64
  %arrayidx23 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx21, i64 0, i64 %idxprom22
  %14 = load i32, i32* %arrayidx23, align 4
  %add24 = add nsw i32 %add18, %14
  %15 = load i32, i32* %i, align 4
  %sub25 = sub i32 %15, 1
  %idxprom26 = zext i32 %sub25 to i64
  %arrayidx27 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* @main.A, i64 0, i64 %idxprom26
  %16 = load i32, i32* %j, align 4
  %idxprom28 = zext i32 %16 to i64
  %arrayidx29 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx27, i64 0, i64 %idxprom28
  %17 = load i32, i32* %arrayidx29, align 4
  %add30 = add nsw i32 %add24, %17
  %conv = sitofp i32 %add30 to double
  %mul = fmul double 2.000000e-01, %conv
  %conv31 = fptosi double %mul to i32
  %18 = load i32, i32* %i, align 4
  %idxprom32 = zext i32 %18 to i64
  %arrayidx33 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* @main.B, i64 0, i64 %idxprom32
  %19 = load i32, i32* %j, align 4
  %idxprom34 = zext i32 %19 to i64
  %arrayidx35 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx33, i64 0, i64 %idxprom34
  store i32 %conv31, i32* %arrayidx35, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body6
  %20 = load i32, i32* %j, align 4
  %inc = add i32 %20, 1
  store i32 %inc, i32* %j, align 4
  br label %for.cond4

for.end:                                          ; preds = %for.cond4
  br label %for.inc36

for.inc36:                                        ; preds = %for.end
  %21 = load i32, i32* %i, align 4
  %inc37 = add i32 %21, 1
  store i32 %inc37, i32* %i, align 4
  br label %for.cond1

for.end38:                                        ; preds = %for.cond1
  store i32 1, i32* %i, align 4
  br label %for.cond39

for.cond39:                                       ; preds = %for.inc85, %for.end38
  %22 = load i32, i32* %i, align 4
  %cmp40 = icmp ult i32 %22, 19
  br i1 %cmp40, label %for.body42, label %for.end87

for.body42:                                       ; preds = %for.cond39
  store i32 1, i32* %j, align 4
  br label %for.cond43

for.cond43:                                       ; preds = %for.inc82, %for.body42
  %23 = load i32, i32* %j, align 4
  %cmp44 = icmp ult i32 %23, 19
  br i1 %cmp44, label %for.body46, label %for.end84

for.body46:                                       ; preds = %for.cond43
  %24 = load i32, i32* %i, align 4
  %idxprom47 = zext i32 %24 to i64
  %arrayidx48 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* @main.B, i64 0, i64 %idxprom47
  %25 = load i32, i32* %j, align 4
  %idxprom49 = zext i32 %25 to i64
  %arrayidx50 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx48, i64 0, i64 %idxprom49
  %26 = load i32, i32* %arrayidx50, align 4
  %27 = load i32, i32* %i, align 4
  %idxprom51 = zext i32 %27 to i64
  %arrayidx52 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* @main.B, i64 0, i64 %idxprom51
  %28 = load i32, i32* %j, align 4
  %sub53 = sub i32 %28, 1
  %idxprom54 = zext i32 %sub53 to i64
  %arrayidx55 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx52, i64 0, i64 %idxprom54
  %29 = load i32, i32* %arrayidx55, align 4
  %add56 = add nsw i32 %26, %29
  %30 = load i32, i32* %i, align 4
  %idxprom57 = zext i32 %30 to i64
  %arrayidx58 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* @main.B, i64 0, i64 %idxprom57
  %31 = load i32, i32* %j, align 4
  %add59 = add i32 1, %31
  %idxprom60 = zext i32 %add59 to i64
  %arrayidx61 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx58, i64 0, i64 %idxprom60
  %32 = load i32, i32* %arrayidx61, align 4
  %add62 = add nsw i32 %add56, %32
  %33 = load i32, i32* %i, align 4
  %add63 = add i32 1, %33
  %idxprom64 = zext i32 %add63 to i64
  %arrayidx65 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* @main.B, i64 0, i64 %idxprom64
  %34 = load i32, i32* %j, align 4
  %idxprom66 = zext i32 %34 to i64
  %arrayidx67 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx65, i64 0, i64 %idxprom66
  %35 = load i32, i32* %arrayidx67, align 4
  %add68 = add nsw i32 %add62, %35
  %36 = load i32, i32* %i, align 4
  %sub69 = sub i32 %36, 1
  %idxprom70 = zext i32 %sub69 to i64
  %arrayidx71 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* @main.B, i64 0, i64 %idxprom70
  %37 = load i32, i32* %j, align 4
  %idxprom72 = zext i32 %37 to i64
  %arrayidx73 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx71, i64 0, i64 %idxprom72
  %38 = load i32, i32* %arrayidx73, align 4
  %add74 = add nsw i32 %add68, %38
  %conv75 = sitofp i32 %add74 to double
  %mul76 = fmul double 2.000000e-01, %conv75
  %conv77 = fptosi double %mul76 to i32
  %39 = load i32, i32* %i, align 4
  %idxprom78 = zext i32 %39 to i64
  %arrayidx79 = getelementptr inbounds [20 x [20 x i32]], [20 x [20 x i32]]* @main.A, i64 0, i64 %idxprom78
  %40 = load i32, i32* %j, align 4
  %idxprom80 = zext i32 %40 to i64
  %arrayidx81 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx79, i64 0, i64 %idxprom80
  store i32 %conv77, i32* %arrayidx81, align 4
  br label %for.inc82

for.inc82:                                        ; preds = %for.body46
  %41 = load i32, i32* %j, align 4
  %inc83 = add i32 %41, 1
  store i32 %inc83, i32* %j, align 4
  br label %for.cond43

for.end84:                                        ; preds = %for.cond43
  br label %for.inc85

for.inc85:                                        ; preds = %for.end84
  %42 = load i32, i32* %i, align 4
  %inc86 = add i32 %42, 1
  store i32 %inc86, i32* %i, align 4
  br label %for.cond39

for.end87:                                        ; preds = %for.cond39
  br label %for.inc88

for.inc88:                                        ; preds = %for.end87
  %43 = load i32, i32* %t, align 4
  %inc89 = add i32 %43, 1
  store i32 %inc89, i32* %t, align 4
  br label %for.cond

for.end90:                                        ; preds = %for.cond
  ret i32 0
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 724bf4ee23a3993689d55afb2845949e05c83b1c)"}
