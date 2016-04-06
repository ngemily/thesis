LLVM generated from C code
==========================

From source code
----------------

```c
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
```

From recovered code
-------------------

```llvm
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
```
