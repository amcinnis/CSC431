target triple="i686"


define i32 @test(i32 %a) 
{
.LU1:
	%_retval_ = alloca i32
	%_P_a = alloca i32
	store i32 %a, i32* %_P_a
	%u0 = load i32* %_P_a
	%u1 = add i32 %u0, 1
	store i32 %u1, i32* %_retval_
	br label %.LU0
.LU0:
	%u2 = load i32* %_retval_
	ret i32 %u2
}

define i32 @main() 
{
.LU3:
	%_retval_ = alloca i32
	%c = alloca i32
	%u3 = call i32 @test(i32 3)
	store i32 %u3, i32* %c
	%u4 = load i32* %c
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u4)
	store i32 0, i32* %_retval_
	br label %.LU2
.LU2:
	%u5 = load i32* %_retval_
	ret i32 %u5
}

declare i8* @malloc(i32)
declare void @free(i8*)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
@.println = private unnamed_addr constant [5 x i8] c"%ld\0A\00", align 1
@.print = private unnamed_addr constant [5 x i8] c"%ld \00", align 1
@.read = private unnamed_addr constant [4 x i8] c"%ld\00", align 1
@.read_scratch = common global i32 0, align 8
