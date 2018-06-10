target triple="i686"


define i32 @isqrt(i32 %a) 
{
.LU1:
	%_retval_ = alloca i32
	%_P_a = alloca i32
	store i32 %a, i32* %_P_a
	%square = alloca i32
	%delta = alloca i32
	store i32 1, i32* %square
	store i32 3, i32* %delta
	br label %.LU2
.LU2:
	%u0 = load i32* %square
	%u1 = load i32* %_P_a
	%u2 = icmp sle i32 %u0, %u1
	br i1 %u2, label %.LU3, label %.LU4
.LU3:
	%u3 = load i32* %square
	%u4 = load i32* %delta
	%u5 = add i32 %u3, %u4
	store i32 %u5, i32* %square
	%u6 = load i32* %delta
	%u7 = add i32 %u6, 2
	store i32 %u7, i32* %delta
	%u8 = load i32* %square
	%u9 = load i32* %_P_a
	%u10 = icmp sle i32 %u8, %u9
	br i1 %u10, label %.LU3, label %.LU4
.LU4:
	%u11 = load i32* %delta
	%u12 = sdiv i32 %u11, 2
	%u13 = sub i32 %u12, 1
	store i32 %u13, i32* %_retval_
	br label %.LU0
.LU0:
	%u14 = load i32* %_retval_
	ret i32 %u14
}

define i1 @prime(i32 %a) 
{
.LU6:
	%_retval_ = alloca i1
	%_P_a = alloca i32
	store i32 %a, i32* %_P_a
	%max = alloca i32
	%divisor = alloca i32
	%remainder = alloca i32
	br label %.LU7
.LU7:
	%u15 = load i32* %_P_a
	%u16 = icmp slt i32 %u15, 2
	br i1 %u16, label %.LU8, label %.LU9
.LU8:
	store i1 false, i1* %_retval_
	br label %.LU5
.LU9:
	%u17 = load i32* %_P_a
	%u18 = call i32 @isqrt(i32 %u17)
	store i32 %u18, i32* %max
	store i32 2, i32* %divisor
	br label %.LU10
.LU10:
	%u19 = load i32* %divisor
	%u20 = load i32* %max
	%u21 = icmp sle i32 %u19, %u20
	br i1 %u21, label %.LU11, label %.LU14
.LU11:
	%u22 = load i32* %_P_a
	%u23 = load i32* %_P_a
	%u24 = load i32* %divisor
	%u25 = sdiv i32 %u23, %u24
	%u26 = load i32* %divisor
	%u27 = mul i32 %u25, %u26
	%u28 = sub i32 %u22, %u27
	store i32 %u28, i32* %remainder
	br label %.LU12
.LU12:
	%u29 = load i32* %remainder
	%u30 = icmp eq i32 %u29, 0
	br i1 %u30, label %.LU13, label %.JN0
.LU13:
	store i1 false, i1* %_retval_
	br label %.LU5
.JN0:
	%u31 = load i32* %divisor
	%u32 = add i32 %u31, 1
	store i32 %u32, i32* %divisor
	%u33 = load i32* %divisor
	%u34 = load i32* %max
	%u35 = icmp sle i32 %u33, %u34
	br i1 %u35, label %.LU11, label %.LU14
.LU14:
	store i1 true, i1* %_retval_
	br label %.LU5
.LU5:
	%u36 = load i1* %_retval_
	ret i1 %u36
}

define i32 @main() 
{
.LU16:
	%_retval_ = alloca i32
	%limit = alloca i32
	%a = alloca i32
	call i32 (i8*, ...)* @scanf(i8* getelementptr inbounds ([4 x i8]* @.read, i32 0, i32 0), i32* %limit)
	store i32 0, i32* %a
	br label %.LU17
.LU17:
	%u37 = load i32* %a
	%u38 = load i32* %limit
	%u39 = icmp sle i32 %u37, %u38
	br i1 %u39, label %.LU18, label %.LU20
.LU18:
	%u40 = load i32* %a
	%u41 = call i1 @prime(i32 %u40)
	br i1 %u41, label %.LU19, label %.JN2
.LU19:
	%u42 = load i32* %a
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u42)
	br label %.JN2
.JN2:
	%u43 = load i32* %a
	%u44 = add i32 %u43, 1
	store i32 %u44, i32* %a
	%u45 = load i32* %a
	%u46 = load i32* %limit
	%u47 = icmp sle i32 %u45, %u46
	br i1 %u47, label %.LU18, label %.LU20
.LU20:
	store i32 0, i32* %_retval_
	br label %.LU15
.LU15:
	%u48 = load i32* %_retval_
	ret i32 %u48
}

declare i8* @malloc(i32)
declare void @free(i8*)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
@.println = private unnamed_addr constant [5 x i8] c"%ld\0A\00", align 1
@.print = private unnamed_addr constant [5 x i8] c"%ld \00", align 1
@.read = private unnamed_addr constant [4 x i8] c"%ld\00", align 1
@.read_scratch = common global i32 0, align 8
