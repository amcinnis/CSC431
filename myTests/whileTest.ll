target triple="i686"


define i32 @main() 
{
.LU1:
	%_retval_ = alloca i32
	%a = alloca i32
	store i32 5, i32* %a
	br label %.LU2
.LU2:
	%u0 = load i32* %a
	%u1 = icmp sge i32 %u0, 0
	br i1 %u1, label %.LU3, label %.LU4
.LU3:
	%u2 = load i32* %a
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u2)
	%u3 = load i32* %a
	%u4 = sub i32 %u3, 1
	store i32 %u4, i32* %a
	%u5 = load i32* %a
	%u6 = icmp sge i32 %u5, 0
	br i1 %u6, label %.LU3, label %.LU4
.LU4:
	%u7 = load i32* %a
	store i32 %u7, i32* %_retval_
	br label %.LU0
.LU0:
	%u8 = load i32* %_retval_
	ret i32 %u8
}

declare i8* @malloc(i32)
declare void @free(i8*)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
@.println = private unnamed_addr constant [5 x i8] c"%ld\0A\00", align 1
@.print = private unnamed_addr constant [5 x i8] c"%ld \00", align 1
@.read = private unnamed_addr constant [4 x i8] c"%ld\00", align 1
@.read_scratch = common global i32 0, align 8
