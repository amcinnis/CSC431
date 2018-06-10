target triple="i686"


define i32 @mod(i32 %a, i32 %b) 
{
.LU1:
	%_retval_ = alloca i32
	%_P_a = alloca i32
	store i32 %a, i32* %_P_a
	%_P_b = alloca i32
	store i32 %b, i32* %_P_b
	%u0 = load i32* %_P_a
	%u1 = load i32* %_P_a
	%u2 = load i32* %_P_b
	%u3 = sdiv i32 %u1, %u2
	%u4 = load i32* %_P_b
	%u5 = mul i32 %u3, %u4
	%u6 = sub i32 %u0, %u5
	store i32 %u6, i32* %_retval_
	br label %.LU0
.LU0:
	%u7 = load i32* %_retval_
	ret i32 %u7
}

define void @hailstone(i32 %n) 
{
.LU3:
	%_P_n = alloca i32
	store i32 %n, i32* %_P_n
	br label %.LU4
.LU4:
	br label %.LU5
.LU5:
	%u8 = load i32* %_P_n
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.print, i32 0, i32 0), i32 %u8)
	br label %.LU6
.LU6:
	%u9 = load i32* %_P_n
	%u10 = call i32 @mod(i32 %u9, i32 2)
	%u11 = icmp eq i32 %u10, 1
	br i1 %u11, label %.LU7, label %.LU8
.LU7:
	%u12 = load i32* %_P_n
	%u13 = mul i32 3, %u12
	%u14 = add i32 %u13, 1
	store i32 %u14, i32* %_P_n
	br label %.JN0
.JN0:
	br label %.LU9
.LU9:
	%u17 = load i32* %_P_n
	%u18 = icmp sle i32 %u17, 1
	br i1 %u18, label %.LU10, label %.JN1
.LU10:
	%u19 = load i32* %_P_n
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u19)
	br label %.LU2
.JN1:
	br label %.LU4
.LU8:
	%u15 = load i32* %_P_n
	%u16 = sdiv i32 %u15, 2
	store i32 %u16, i32* %_P_n
	br label %.JN0
.LU2:
	ret void
}

define i32 @main() 
{
.LU12:
	%_retval_ = alloca i32
	%num = alloca i32
	call i32 (i8*, ...)* @scanf(i8* getelementptr inbounds ([4 x i8]* @.read, i32 0, i32 0), i32* %num)
	%u20 = load i32* %num
	call void @hailstone(i32 %u20)
	store i32 0, i32* %_retval_
	br label %.LU11
.LU11:
	%u21 = load i32* %_retval_
	ret i32 %u21
}

declare i8* @malloc(i32)
declare void @free(i8*)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
@.println = private unnamed_addr constant [5 x i8] c"%ld\0A\00", align 1
@.print = private unnamed_addr constant [5 x i8] c"%ld \00", align 1
@.read = private unnamed_addr constant [4 x i8] c"%ld\00", align 1
@.read_scratch = common global i32 0, align 8
