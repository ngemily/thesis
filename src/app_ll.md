LLVM generated from C code
==========================

From source code
----------------

```llvm
; ModuleID = 'src/source.bc'
target datalayout = "e-m:e-p:32:32-f64:32:64-f80:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

@.str3 = private unnamed_addr constant [21 x i8] c"sum of elements in C\00", align 1
@.str4 = private unnamed_addr constant [6 x i8] c"%llu\0A\00", align 1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #0

; Function Attrs: nounwind
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
  %A = alloca [400 x i32], align 4
  %B = alloca [400 x i32], align 4
  br label %.lr.ph.i

.lr.ph.i:                                         ; preds = %.lr.ph.i, %0
  %1 = phi i32 [ %3, %.lr.ph.i ], [ 0, %0 ]
  %scevgep9 = getelementptr [400 x i32]* %A, i32 0, i32 %1
  %2 = add i32 %1, 1
  %3 = add nsw i32 %1, 1
  store i32 %2, i32* %scevgep9, align 4, !tbaa !1
  %exitcond = icmp eq i32 %3, 400
  br i1 %exitcond, label %.lr.ph.i2.preheader, label %.lr.ph.i

.lr.ph.i2.preheader:                              ; preds = %.lr.ph.i
  br label %.lr.ph.i2

.lr.ph.i2:                                        ; preds = %.lr.ph.i2, %.lr.ph.i2.preheader
  %4 = phi i32 [ %6, %.lr.ph.i2 ], [ 0, %.lr.ph.i2.preheader ]
  %scevgep8 = getelementptr [400 x i32]* %B, i32 0, i32 %4
  %5 = add i32 %4, 401
  store i32 %5, i32* %scevgep8, align 4, !tbaa !1
  %6 = add nsw i32 %4, 1
  %exitcond7 = icmp eq i32 %6, 400
  br i1 %exitcond7, label %.preheader.lr.ph.split.us.us.i.preheader, label %.lr.ph.i2

.preheader.lr.ph.split.us.us.i.preheader:         ; preds = %.lr.ph.i2
  br label %.preheader.lr.ph.split.us.us.i

; <label>:7                                       ; preds = %9
  %8 = add nsw i32 %23, 1
  %exitcond5 = icmp eq i32 %8, 20
  br i1 %exitcond5, label %matrixMultiply.exit, label %.preheader.lr.ph.split.us.us.i

; <label>:9                                       ; preds = %13
  %10 = add nsw i32 %21, %sum.15.us.us.i
  %11 = add nsw i32 %12, 1
  %exitcond3 = icmp eq i32 %11, 20
  br i1 %exitcond3, label %7, label %.lr.ph.us.us.i

.lr.ph.us.us.i:                                   ; preds = %.preheader.lr.ph.split.us.us.i, %9
  %sum.15.us.us.i = phi i32 [ %sum.09.us.i, %.preheader.lr.ph.split.us.us.i ], [ %10, %9 ]
  %12 = phi i32 [ 0, %.preheader.lr.ph.split.us.us.i ], [ %11, %9 ]
  br label %13

; <label>:13                                      ; preds = %13, %.lr.ph.us.us.i
  %row_dot_col.03.us.us.i = phi i32 [ 0, %.lr.ph.us.us.i ], [ %21, %13 ]
  %14 = phi i32 [ 0, %.lr.ph.us.us.i ], [ %22, %13 ]
  %15 = add i32 %24, %14
  %scevgep2 = getelementptr [400 x i32]* %A, i32 0, i32 %15
  %16 = mul i32 %14, 20
  %17 = add i32 %12, %16
  %scevgep = getelementptr [400 x i32]* %B, i32 0, i32 %17
  %18 = load i32* %scevgep2, align 4, !tbaa !1
  %19 = load i32* %scevgep, align 4, !tbaa !1
  %20 = mul nsw i32 %19, %18
  %21 = add nsw i32 %20, %row_dot_col.03.us.us.i
  %22 = add nsw i32 %14, 1
  %exitcond1 = icmp eq i32 %22, 20
  br i1 %exitcond1, label %9, label %13

.preheader.lr.ph.split.us.us.i:                   ; preds = %7, %.preheader.lr.ph.split.us.us.i.preheader
  %sum.09.us.i = phi i32 [ %10, %7 ], [ 0, %.preheader.lr.ph.split.us.us.i.preheader ]
  %23 = phi i32 [ %8, %7 ], [ 0, %.preheader.lr.ph.split.us.us.i.preheader ]
  %24 = mul i32 %23, 20
  br label %.lr.ph.us.us.i

matrixMultiply.exit:                              ; preds = %7
  %25 = sext i32 %10 to i64
  %26 = tail call i32 @puts(i8* getelementptr inbounds ([21 x i8]* @.str3, i32 0, i32 0)) #1
  %27 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str4, i32 0, i32 0), i64 %25) #1
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #0

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nobuiltin nounwind }

!llvm.ident = !{!0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0}

!0 = metadata !{metadata !"Ubuntu clang version 3.5.2-2 (tags/RELEASE_352/final) (based on LLVM 3.5.2)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"int", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
```

From recovered code
-------------------

```llvm
; ModuleID = 'src/recovered.bc'
target datalayout = "e-m:e-p:32:32-f64:32:64-f80:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

@.str = private unnamed_addr constant [21 x i8] c"sum of elements in C\00", align 1
@.str1 = private unnamed_addr constant [6 x i8] c"%llu\0A\00", align 1

; Function Attrs: nounwind
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
  %v1 = alloca [400 x i32], align 4
  %v2 = alloca [400 x i32], align 4
  %v3 = alloca [400 x i32], align 4
  %1 = getelementptr inbounds [400 x i32]* %v1, i32 0, i32 0
  store i32 1, i32* %1, align 4, !tbaa !1
  %2 = getelementptr inbounds [400 x i32]* %v1, i32 0, i32 1
  store i32 2, i32* %2, align 4, !tbaa !1
  br label %.lr.ph.i

.lr.ph.i:                                         ; preds = %.lr.ph.i, %0
  %indvar9 = phi i32 [ %indvar.next10, %.lr.ph.i ], [ 0, %0 ]
  %n.01.i = add i32 %indvar9, 2
  %scevgep11 = getelementptr [400 x i32]* %v1, i32 0, i32 %n.01.i
  %3 = add i32 %indvar9, 3
  store i32 %3, i32* %scevgep11, align 4, !tbaa !1
  %indvar.next10 = add i32 %indvar9, 1
  %exitcond = icmp eq i32 %indvar.next10, 398
  br i1 %exitcond, label %initializeMatrix.exit, label %.lr.ph.i

initializeMatrix.exit:                            ; preds = %.lr.ph.i
  %4 = getelementptr inbounds [400 x i32]* %v2, i32 0, i32 0
  store i32 401, i32* %4, align 4, !tbaa !1
  %5 = getelementptr inbounds [400 x i32]* %v2, i32 0, i32 1
  store i32 402, i32* %5, align 4, !tbaa !1
  br label %.lr.ph.i2

.lr.ph.i2:                                        ; preds = %.lr.ph.i2, %initializeMatrix.exit
  %indvar6 = phi i32 [ %indvar.next7, %.lr.ph.i2 ], [ 0, %initializeMatrix.exit ]
  %n.01.i1 = add i32 %indvar6, 2
  %scevgep = getelementptr [400 x i32]* %v2, i32 0, i32 %n.01.i1
  %6 = add i32 %indvar6, 403
  store i32 %6, i32* %scevgep, align 4, !tbaa !1
  %indvar.next7 = add i32 %indvar6, 1
  %exitcond8 = icmp eq i32 %indvar.next7, 398
  br i1 %exitcond8, label %initializeMatrix.exit3, label %.lr.ph.i2

initializeMatrix.exit3:                           ; preds = %.lr.ph.i2
  %7 = ptrtoint [400 x i32]* %v1 to i32
  %8 = ptrtoint [400 x i32]* %v2 to i32
  %9 = ptrtoint [400 x i32]* %v3 to i32
  %10 = add i32 %8, 80
  %11 = add i32 %7, 4
  br label %.split.us.us.i

; <label>:12                                      ; preds = %14
  %13 = add nsw i32 %37, 1
  %exitcond5 = icmp eq i32 %13, 20
  br i1 %exitcond5, label %matrixMultiply.exit, label %.split.us.us.i

; <label>:14                                      ; preds = %26
  %15 = add nsw i32 %36, %v8.0.us.us.i
  %16 = inttoptr i32 %18 to i32*
  store i32 %36, i32* %16, align 4, !tbaa !1
  %indvar.next3 = add i32 %indvar2, 1
  %exitcond4 = icmp eq i32 %indvar.next3, 20
  br i1 %exitcond4, label %12, label %.lr.ph.us.us.i

.lr.ph.us.us.i:                                   ; preds = %.split.us.us.i, %14
  %indvar2 = phi i32 [ 0, %.split.us.us.i ], [ %indvar.next3, %14 ]
  %v8.0.us.us.i = phi i32 [ %v4.0.us.i, %.split.us.us.i ], [ %15, %14 ]
  %17 = shl i32 %indvar2, 2
  %18 = add i32 %39, %17
  %19 = shl i32 %indvar2, 2
  %20 = add i32 %10, %19
  %21 = add i32 %8, %19
  %22 = inttoptr i32 %21 to i32*
  %23 = load i32* %22, align 4, !tbaa !1
  %24 = load i32* %42, align 4, !tbaa !1
  %25 = mul nsw i32 %24, %23
  br label %26

; <label>:26                                      ; preds = %26, %.lr.ph.us.us.i
  %indvar = phi i32 [ %indvar.next, %26 ], [ 0, %.lr.ph.us.us.i ]
  %v14.01.us.us.i = phi i32 [ %36, %26 ], [ %25, %.lr.ph.us.us.i ]
  %27 = shl i32 %indvar, 2
  %28 = add i32 %40, %27
  %29 = mul i32 %indvar, 80
  %30 = add i32 %20, %29
  %31 = inttoptr i32 %28 to i32*
  %32 = load i32* %31, align 4, !tbaa !1
  %33 = inttoptr i32 %30 to i32*
  %34 = load i32* %33, align 4, !tbaa !1
  %35 = mul nsw i32 %34, %32
  %36 = add nsw i32 %35, %v14.01.us.us.i
  %indvar.next = add i32 %indvar, 1
  %exitcond1 = icmp eq i32 %indvar.next, 19
  br i1 %exitcond1, label %14, label %26

.split.us.us.i:                                   ; preds = %12, %initializeMatrix.exit3
  %v4.0.us.i = phi i32 [ %15, %12 ], [ 0, %initializeMatrix.exit3 ]
  %37 = phi i32 [ %13, %12 ], [ 0, %initializeMatrix.exit3 ]
  %38 = mul i32 %37, 80
  %39 = add i32 %9, %38
  %40 = add i32 %11, %38
  %41 = add i32 %7, %38
  %42 = inttoptr i32 %41 to i32*
  br label %.lr.ph.us.us.i

matrixMultiply.exit:                              ; preds = %12
  %43 = sext i32 %15 to i64
  %44 = call i32 @puts(i8* getelementptr inbounds ([21 x i8]* @.str, i32 0, i32 0)) #1
  %45 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str1, i32 0, i32 0), i64 %43) #1
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #0

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #0

attributes #0 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nobuiltin nounwind }

!llvm.ident = !{!0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0}

!0 = metadata !{metadata !"Ubuntu clang version 3.5.2-2 (tags/RELEASE_352/final) (based on LLVM 3.5.2)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"int", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
```
