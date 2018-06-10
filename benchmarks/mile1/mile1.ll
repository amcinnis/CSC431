target triple="i686"
%struct.Power = type {i32, i32}


define i32 @calcPower(i32 %base, i32 %exp) 
{
.LU1:
	%_retval_ = alloca i32
	%_P_base = alloca i32
	store i32 %base, i32* %_P_base
	%_P_exp = alloca i32
	store i32 %exp, i32* %_P_exp
	%result = alloca i32
	store i32 1, i32* %result
	br label %.LU2
.LU2:
	%u0 = load i32* %_P_exp
	%u1 = icmp sgt i32 %u0, 0
	br i1 %u1, label %.LU3, label %.LU4
.LU3:
	%u2 = load i32* %result
	%u3 = load i32* %_P_base
	%u4 = mul i32 %u2, %u3
	store i32 %u4, i32* %result
	%u5 = load i32* %_P_exp
	%u6 = sub i32 %u5, 1
	store i32 %u6, i32* %_P_exp
	%u7 = load i32* %_P_exp
	%u8 = icmp sgt i32 %u7, 0
	br i1 %u8, label %.LU3, label %.LU4
.LU4:
	%u9 = load i32* %result
	store i32 %u9, i32* %_retval_
	br label %.LU0
.LU0:
	%u10 = load i32* %_retval_
	ret i32 %u10
}

define i32 @main() 
{
.LU6:
	%_retval_ = alloca i32
	%power = alloca %struct.Power*
	%input = alloca i32
	%result = alloca i32
	%exp = alloca i32
	%i = alloca i32
	store i32 0, i32* %result
	%u11 = call i8* @malloc(i32 16)
	%u12 = bitcast i8* %u11 to %struct.Power*
	store %struct.Power* %u12, %struct.Power** %power
	call i32 (i8*, ...)* @scanf(i8* getelementptr inbounds ([4 x i8]* @.read, i32 0, i32 0), i32* %input)
	%u13 = load i32* %input
	%u14 = load %struct.Power** %power
	%u15 = getelementptr %struct.Power* %u14, i1 0, i32 0
	store i32 %u13, i32* %u15
	call i32 (i8*, ...)* @scanf(i8* getelementptr inbounds ([4 x i8]* @.read, i32 0, i32 0), i32* %input)
	br label %.LU7
.LU7:
	%u16 = load i32* %input
	%u17 = icmp slt i32 %u16, 0
	br i1 %u17, label %.LU8, label %.JN0
.LU8:
	store i32 -1, i32* %_retval_
	br label %.LU5
.JN0:
	%u18 = load i32* %input
	%u19 = load %struct.Power** %power
	%u20 = getelementptr %struct.Power* %u19, i1 0, i32 1
	store i32 %u18, i32* %u20
	store i32 0, i32* %i
	br label %.LU9
.LU9:
	%u21 = load i32* %i
	%u22 = icmp slt i32 %u21, 1000000
	br i1 %u22, label %.LU10, label %.LU11
.LU10:
	%u23 = load i32* %i
	%u24 = add i32 %u23, 1
	store i32 %u24, i32* %i
	%u25 = load %struct.Power** %power
	%u26 = getelementptr %struct.Power* %u25, i1 0, i32 0
	%u27 = load i32* %u26
	%u28 = load %struct.Power** %power
	%u29 = getelementptr %struct.Power* %u28, i1 0, i32 1
	%u30 = load i32* %u29
	%u31 = call i32 @calcPower(i32 %u27, i32 %u30)
	store i32 %u31, i32* %result
	%u32 = load i32* %i
	%u33 = icmp slt i32 %u32, 1000000
	br i1 %u33, label %.LU10, label %.LU11
.LU11:
	%u34 = load i32* %result
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u34)
	store i32 1, i32* %_retval_
	br label %.LU5
.LU5:
	%u35 = load i32* %_retval_
	ret i32 %u35
}

declare i8* @malloc(i32)
declare void @free(i8*)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
@.println = private unnamed_addr constant [5 x i8] c"%ld\0A\00", align 1
@.print = private unnamed_addr constant [5 x i8] c"%ld \00", align 1
@.read = private unnamed_addr constant [4 x i8] c"%ld\00", align 1
@.read_scratch = common global i32 0, align 8
