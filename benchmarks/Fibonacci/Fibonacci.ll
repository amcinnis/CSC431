target triple="i686"


define i32 @computeFib(i32 %input) 
{
.LU1:
	%_retval_ = alloca i32
	%_P_input = alloca i32
	store i32 %input, i32* %_P_input
	br label %.LU2
.LU2:
	%u0 = load i32* %_P_input
	%u1 = icmp eq i32 %u0, 0
	br i1 %u1, label %.LU3, label %.LU4
.LU3:
	store i32 0, i32* %_retval_
	br label %.LU0
.LU4:
	%u2 = load i32* %_P_input
	%u3 = icmp sle i32 %u2, 2
	br i1 %u3, label %.LU5, label %.LU6
.LU5:
	store i32 1, i32* %_retval_
	br label %.LU0
.LU6:
	%u4 = load i32* %_P_input
	%u5 = sub i32 %u4, 1
	%u6 = call i32 @computeFib(i32 %u5)
	%u7 = load i32* %_P_input
	%u8 = sub i32 %u7, 2
	%u9 = call i32 @computeFib(i32 %u8)
	%u10 = add i32 %u6, %u9
	store i32 %u10, i32* %_retval_
	br label %.LU0
.LU0:
	%u11 = load i32* %_retval_
	ret i32 %u11
}

define i32 @main() 
{
.LU8:
	%_retval_ = alloca i32
	%input = alloca i32
	call i32 (i8*, ...)* @scanf(i8* getelementptr inbounds ([4 x i8]* @.read, i32 0, i32 0), i32* %input)
	%u12 = load i32* %input
	%u13 = call i32 @computeFib(i32 %u12)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u13)
	store i32 0, i32* %_retval_
	br label %.LU7
.LU7:
	%u14 = load i32* %_retval_
	ret i32 %u14
}

declare i8* @malloc(i32)
declare void @free(i8*)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
@.println = private unnamed_addr constant [5 x i8] c"%ld\0A\00", align 1
@.print = private unnamed_addr constant [5 x i8] c"%ld \00", align 1
@.read = private unnamed_addr constant [4 x i8] c"%ld\00", align 1
@.read_scratch = common global i32 0, align 8
