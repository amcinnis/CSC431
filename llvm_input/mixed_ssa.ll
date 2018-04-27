target triple="i686"
%struct.foo = type {i32, i32, %struct.simple*}
%struct.simple = type {i32}

@globalfoo = common global %struct.foo* null, align 8

define void @tailrecursive(i32 %num)
{
LU1:
	%u0 = icmp sle i32 %num, 0
	br i1 %u0, label %LU2, label %LU3
LU2:
	br label %LU0
LU3:
	br label %LU4
LU4:
	%u1 = sub i32 %num, 1
	call void @tailrecursive(i32 %u1)
	br label %LU0
LU0:
	ret void
}

define i32 @add(i32 %x, i32 %y)
{
LU6:
	%u3 = add i32 %x, %y
	br label %LU5
LU5:
	ret i32 %u3
}

define void @domath(i32 %num)
{
LU8:
	%u4 = call i8* @malloc(i32 12)
	%u5 = bitcast i8* %u4 to %struct.foo*
	%u6 = call i8* @malloc(i32 4)
	%u7 = bitcast i8* %u6 to %struct.simple*
	%u8 = getelementptr %struct.foo* %u5, i1 0, i32 2
	store %struct.simple* %u7, %struct.simple** %u8
	%u9 = call i8* @malloc(i32 12)
	%u10 = bitcast i8* %u9 to %struct.foo*
	%u11 = call i8* @malloc(i32 4)
	%u12 = bitcast i8* %u11 to %struct.simple*
	%u13 = getelementptr %struct.foo* %u10, i1 0, i32 2
	store %struct.simple* %u12, %struct.simple** %u13
	%u14 = getelementptr %struct.foo* %u5, i1 0, i32 0
	store i32 %num, i32* %u14
	%u15 = getelementptr %struct.foo* %u10, i1 0, i32 0
	store i32 3, i32* %u15
	%u16 = getelementptr %struct.foo* %u5, i1 0, i32 0
	%u17 = load i32* %u16
	%u18 = getelementptr %struct.foo* %u5, i1 0, i32 2
	%u19 = load %struct.simple** %u18
	%u20 = getelementptr %struct.simple* %u19, i1 0, i32 0
	store i32 %u17, i32* %u20
	%u21 = getelementptr %struct.foo* %u10, i1 0, i32 0
	%u22 = load i32* %u21
	%u23 = getelementptr %struct.foo* %u10, i1 0, i32 2
	%u24 = load %struct.simple** %u23
	%u25 = getelementptr %struct.simple* %u24, i1 0, i32 0
	store i32 %u22, i32* %u25
	%u26 = icmp sgt i32 %num, 0
	br i1 %u26, label %LU9, label %LU10
LU9:
	%num0 = phi i32 [%num, %LU8], [%u52, %LU9]
	%u40 = getelementptr %struct.foo* %u10, i1 0, i32 2
	%u41 = load %struct.simple** %u40
	%u42 = getelementptr %struct.simple* %u41, i1 0, i32 0
	%u43 = load i32* %u42
	%u44 = getelementptr %struct.foo* %u5, i1 0, i32 0
	%u45 = load i32* %u44
	%u46 = call i32 @add(i32 %u43, i32 %u45)
	%u52 = sub i32 %num0, 1
	%u53 = icmp sgt i32 %u52, 0
	br i1 %u53, label %LU9, label %LU10
LU10:
	%u54 = bitcast %struct.foo* %u5 to i8*
	call void @free(i8* %u54)
	%u55 = bitcast %struct.foo* %u10 to i8*
	call void @free(i8* %u55)
	br label %LU7
LU7:
	ret void
}

define void @objinstantiation(i32 %num)
{
LU12:
	%u56 = icmp sgt i32 %num, 0
	br i1 %u56, label %LU13, label %LU14
LU13:
	%num0 = phi i32 [%u60, %LU13], [%num, %LU12]
	%u57 = call i8* @malloc(i32 12)
	%u58 = bitcast i8* %u57 to %struct.foo*
	%u59 = bitcast %struct.foo* %u58 to i8*
	call void @free(i8* %u59)
	%u60 = sub i32 %num0, 1
	%u61 = icmp sgt i32 %u60, 0
	br i1 %u61, label %LU13, label %LU14
LU14:
	br label %LU11
LU11:
	ret void
}

define i32 @ackermann(i32 %m, i32 %n)
{
LU16:
	%u62 = icmp eq i32 %m, 0
	br i1 %u62, label %LU17, label %LU18
LU17:
	%u63 = add i32 %n, 1
	br label %LU15
LU18:
	br label %LU19
LU19:
	%u64 = icmp eq i32 %n, 0
	br i1 %u64, label %LU20, label %LU21
LU20:
	%u65 = sub i32 %m, 1
	%u66 = call i32 @ackermann(i32 %u65, i32 1)
	br label %LU15
LU21:
	%u67 = sub i32 %m, 1
	%u68 = sub i32 %n, 1
	%u69 = call i32 @ackermann(i32 %m, i32 %u68)
	%u70 = call i32 @ackermann(i32 %u67, i32 %u69)
	br label %LU15
LU15:
	%_retval_0 = phi i32 [%u66, %LU20], [%u70, %LU21], [%u63, %LU17]
	ret i32 %_retval_0
}

define i32 @main()
{
LU23:
	call i32 (i8*, ...)* @scanf(i8* getelementptr inbounds ([4 x i8]* @.read, i32 0, i32 0), i32* @.read_scratch)
	%u71 = load i32* @.read_scratch
	call i32 (i8*, ...)* @scanf(i8* getelementptr inbounds ([4 x i8]* @.read, i32 0, i32 0), i32* @.read_scratch)
	%u72 = load i32* @.read_scratch
	call i32 (i8*, ...)* @scanf(i8* getelementptr inbounds ([4 x i8]* @.read, i32 0, i32 0), i32* @.read_scratch)
	%u73 = load i32* @.read_scratch
	call i32 (i8*, ...)* @scanf(i8* getelementptr inbounds ([4 x i8]* @.read, i32 0, i32 0), i32* @.read_scratch)
	%u74 = load i32* @.read_scratch
	call i32 (i8*, ...)* @scanf(i8* getelementptr inbounds ([4 x i8]* @.read, i32 0, i32 0), i32* @.read_scratch)
	%u75 = load i32* @.read_scratch
	call void @tailrecursive(i32 %u71)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u71)
	call void @domath(i32 %u72)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u72)
	call void @objinstantiation(i32 %u73)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u73)
	%u79 = call i32 @ackermann(i32 %u74, i32 %u75)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u79)
	br label %LU22
LU22:
	ret i32 0
}

declare i8* @malloc(i32)
declare void @free(i8*)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
@.println = private unnamed_addr constant [5 x i8] c"%ld\0A\00", align 1
@.print = private unnamed_addr constant [5 x i8] c"%ld \00", align 1
@.read = private unnamed_addr constant [4 x i8] c"%ld\00", align 1
@.read_scratch = common global i32 0, align 4
