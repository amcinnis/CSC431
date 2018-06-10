target triple="i686"


define i32 @sum(i32 %a, i32 %b) 
{
.LU1:
	%_retval_ = alloca i32
	%_P_a = alloca i32
	store i32 %a, i32* %_P_a
	%_P_b = alloca i32
	store i32 %b, i32* %_P_b
	%u0 = load i32* %_P_a
	%u1 = load i32* %_P_b
	%u2 = add i32 %u0, %u1
	store i32 %u2, i32* %_retval_
	br label %.LU0
.LU0:
	%u3 = load i32* %_retval_
	ret i32 %u3
}

define i32 @fact(i32 %n) 
{
.LU3:
	%_retval_ = alloca i32
	%_P_n = alloca i32
	store i32 %n, i32* %_P_n
	%t = alloca i32
	br label %.LU4
.LU4:
	%u4 = load i32* %_P_n
	%u5 = icmp eq i32 %u4, 1
	%u6 = load i32* %_P_n
	%u7 = icmp eq i32 %u6, 0
	%u8 = or i32 %u5, %u7
	br i1 %u8, label %.LU5, label %.JN0
.LU5:
	store i32 1, i32* %_retval_
	br label %.LU2
.JN0:
	br label %.LU6
.LU6:
	%u9 = load i32* %_P_n
	%u10 = icmp sle i32 %u9, 1
	br i1 %u10, label %.LU7, label %.JN1
.LU7:
	%u11 = load i32* %_P_n
	%u12 = mul i32 -1, %u11
	%u13 = call i32 @fact(i32 %u12)
	store i32 %u13, i32* %_retval_
	br label %.LU2
.JN1:
	%u14 = load i32* %_P_n
	%u15 = load i32* %_P_n
	%u16 = sub i32 %u15, 1
	%u17 = call i32 @fact(i32 %u16)
	%u18 = mul i32 %u14, %u17
	store i32 %u18, i32* %t
	%u19 = load i32* %t
	store i32 %u19, i32* %_retval_
	br label %.LU2
.LU2:
	%u20 = load i32* %_retval_
	ret i32 %u20
}

define i32 @main() 
{
.LU9:
	%_retval_ = alloca i32
	%num1 = alloca i32
	%num2 = alloca i32
	%flag = alloca i32
	store i32 0, i32* %flag
	br label %.LU10
.LU10:
	%u21 = load i32* %flag
	%u22 = icmp ne i32 %u21, -1
	br i1 %u22, label %.LU11, label %.LU12
.LU11:
	call i32 (i8*, ...)* @scanf(i8* getelementptr inbounds ([4 x i8]* @.read, i32 0, i32 0), i32* %num1)
	call i32 (i8*, ...)* @scanf(i8* getelementptr inbounds ([4 x i8]* @.read, i32 0, i32 0), i32* %num2)
	%u23 = load i32* %num1
	%u24 = call i32 @fact(i32 %u23)
	store i32 %u24, i32* %num1
	%u25 = load i32* %num2
	%u26 = call i32 @fact(i32 %u25)
	store i32 %u26, i32* %num2
	%u27 = load i32* %num1
	%u28 = load i32* %num2
	%u29 = call i32 @sum(i32 %u27, i32 %u28)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u29)
	call i32 (i8*, ...)* @scanf(i8* getelementptr inbounds ([4 x i8]* @.read, i32 0, i32 0), i32* %flag)
	%u30 = load i32* %flag
	%u31 = icmp ne i32 %u30, -1
	br i1 %u31, label %.LU11, label %.LU12
.LU12:
	store i32 0, i32* %_retval_
	br label %.LU8
.LU8:
	%u32 = load i32* %_retval_
	ret i32 %u32
}

declare i8* @malloc(i32)
declare void @free(i8*)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
@.println = private unnamed_addr constant [5 x i8] c"%ld\0A\00", align 1
@.print = private unnamed_addr constant [5 x i8] c"%ld \00", align 1
@.read = private unnamed_addr constant [4 x i8] c"%ld\00", align 1
@.read_scratch = common global i32 0, align 8
