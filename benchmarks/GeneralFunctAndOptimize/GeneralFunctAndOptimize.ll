target triple="i686"
%struct.IntHolder = type {i32}

@interval = common global i32 0, align 8
@end = common global i32 0, align 8

define i32 @multBy4xTimes(%struct.IntHolder* %num, i32 %timesLeft) 
{
.LU1:
	%_retval_ = alloca i32
	%_P_num = alloca %struct.IntHolder*
	store %struct.IntHolder* %num, %struct.IntHolder** %_P_num
	%_P_timesLeft = alloca i32
	store i32 %timesLeft, i32* %_P_timesLeft
	br label %.LU2
.LU2:
	%u0 = load i32* %_P_timesLeft
	%u1 = icmp sle i32 %u0, 0
	br i1 %u1, label %.LU3, label %.JN0
.LU3:
	%u2 = load %struct.IntHolder** %_P_num
	%u3 = getelementptr %struct.IntHolder* %u2, i1 0, i32 0
	%u4 = load i32* %u3
	store i32 %u4, i32* %_retval_
	br label %.LU0
.JN0:
	%u5 = load %struct.IntHolder** %_P_num
	%u6 = getelementptr %struct.IntHolder* %u5, i1 0, i32 0
	%u7 = load i32* %u6
	%u8 = mul i32 4, %u7
	%u9 = load %struct.IntHolder** %_P_num
	%u10 = getelementptr %struct.IntHolder* %u9, i1 0, i32 0
	store i32 %u8, i32* %u10
	%u11 = load %struct.IntHolder** %_P_num
	%u12 = load i32* %_P_timesLeft
	%u13 = sub i32 %u12, 1
	%u14 = call i32 @multBy4xTimes(%struct.IntHolder* %u11, i32 %u13)
	%u15 = load %struct.IntHolder** %_P_num
	%u16 = getelementptr %struct.IntHolder* %u15, i1 0, i32 0
	%u17 = load i32* %u16
	store i32 %u17, i32* %_retval_
	br label %.LU0
.LU0:
	%u18 = load i32* %_retval_
	ret i32 %u18
}

define void @divideBy8(%struct.IntHolder* %num) 
{
.LU5:
	%_P_num = alloca %struct.IntHolder*
	store %struct.IntHolder* %num, %struct.IntHolder** %_P_num
	%u19 = load %struct.IntHolder** %_P_num
	%u20 = getelementptr %struct.IntHolder* %u19, i1 0, i32 0
	%u21 = load i32* %u20
	%u22 = sdiv i32 %u21, 2
	%u23 = load %struct.IntHolder** %_P_num
	%u24 = getelementptr %struct.IntHolder* %u23, i1 0, i32 0
	store i32 %u22, i32* %u24
	%u25 = load %struct.IntHolder** %_P_num
	%u26 = getelementptr %struct.IntHolder* %u25, i1 0, i32 0
	%u27 = load i32* %u26
	%u28 = sdiv i32 %u27, 2
	%u29 = load %struct.IntHolder** %_P_num
	%u30 = getelementptr %struct.IntHolder* %u29, i1 0, i32 0
	store i32 %u28, i32* %u30
	%u31 = load %struct.IntHolder** %_P_num
	%u32 = getelementptr %struct.IntHolder* %u31, i1 0, i32 0
	%u33 = load i32* %u32
	%u34 = sdiv i32 %u33, 2
	%u35 = load %struct.IntHolder** %_P_num
	%u36 = getelementptr %struct.IntHolder* %u35, i1 0, i32 0
	store i32 %u34, i32* %u36
	br label %.LU4
.LU4:
	ret void
}

define i32 @main() 
{
.LU7:
	%_retval_ = alloca i32
	%start = alloca i32
	%countOuter = alloca i32
	%countInner = alloca i32
	%calc = alloca i32
	%tempAnswer = alloca i32
	%tempInterval = alloca i32
	%x = alloca %struct.IntHolder*
	%uselessVar = alloca i1
	%uselessVar2 = alloca i1
	%u37 = call i8* @malloc(i32 8)
	%u38 = bitcast i8* %u37 to %struct.IntHolder*
	store %struct.IntHolder* %u38, %struct.IntHolder** %x
	store i32 1000000, i32* @end
	call i32 (i8*, ...)* @scanf(i8* getelementptr inbounds ([4 x i8]* @.read, i32 0, i32 0), i32* %start)
	call i32 (i8*, ...)* @scanf(i8* getelementptr inbounds ([4 x i8]* @.read, i32 0, i32 0), i32* @interval)
	%u39 = load i32* %start
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u39)
	%u40 = load i32* @interval
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u40)
	store i32 0, i32* %countOuter
	store i32 0, i32* %countInner
	store i32 0, i32* %calc
	br label %.LU8
.LU8:
	%u41 = load i32* %countOuter
	%u42 = icmp slt i32 %u41, 50
	br i1 %u42, label %.LU9, label %.LU15
.LU9:
	store i32 0, i32* %countInner
	br label %.LU10
.LU10:
	%u43 = load i32* %countInner
	%u44 = load i32* @end
	%u45 = icmp sle i32 %u43, %u44
	br i1 %u45, label %.LU11, label %.LU14
.LU11:
	%u46 = mul i32 1, 2
	%u47 = mul i32 %u46, 3
	%u48 = mul i32 %u47, 4
	%u49 = mul i32 %u48, 5
	%u50 = mul i32 %u49, 6
	%u51 = mul i32 %u50, 7
	%u52 = mul i32 %u51, 8
	%u53 = mul i32 %u52, 9
	%u54 = mul i32 %u53, 10
	%u55 = mul i32 %u54, 11
	store i32 %u55, i32* %calc
	%u56 = load i32* %countInner
	%u57 = add i32 %u56, 1
	store i32 %u57, i32* %countInner
	%u58 = load i32* %countInner
	%u59 = load %struct.IntHolder** %x
	%u60 = getelementptr %struct.IntHolder* %u59, i1 0, i32 0
	store i32 %u58, i32* %u60
	%u61 = load %struct.IntHolder** %x
	%u62 = getelementptr %struct.IntHolder* %u61, i1 0, i32 0
	%u63 = load i32* %u62
	store i32 %u63, i32* %tempAnswer
	%u64 = load %struct.IntHolder** %x
	%u65 = call i32 @multBy4xTimes(%struct.IntHolder* %u64, i32 2)
	%u66 = load %struct.IntHolder** %x
	call void @divideBy8(%struct.IntHolder* %u66)
	%u67 = load i32* @interval
	%u68 = sub i32 %u67, 1
	store i32 %u68, i32* %tempInterval
	%u69 = load i32* %tempInterval
	%u70 = icmp sle i32 %u69, 0
	store i1 %u70, i1* %uselessVar
	br label %.LU12
.LU12:
	%u71 = load i32* %tempInterval
	%u72 = icmp sle i32 %u71, 0
	br i1 %u72, label %.LU13, label %.JN1
.LU13:
	store i32 1, i32* %tempInterval
	br label %.JN1
.JN1:
	%u73 = load i32* %countInner
	%u74 = load i32* %tempInterval
	%u75 = add i32 %u73, %u74
	store i32 %u75, i32* %countInner
	%u76 = load i32* %countInner
	%u77 = load i32* @end
	%u78 = icmp sle i32 %u76, %u77
	br i1 %u78, label %.LU11, label %.LU14
.LU14:
	%u79 = load i32* %countOuter
	%u80 = add i32 %u79, 1
	store i32 %u80, i32* %countOuter
	%u81 = load i32* %countOuter
	%u82 = icmp slt i32 %u81, 50
	br i1 %u82, label %.LU9, label %.LU15
.LU15:
	%u83 = load i32* %countInner
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u83)
	%u84 = load i32* %calc
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u84)
	store i32 0, i32* %_retval_
	br label %.LU6
.LU6:
	%u85 = load i32* %_retval_
	ret i32 %u85
}

declare i8* @malloc(i32)
declare void @free(i8*)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
@.println = private unnamed_addr constant [5 x i8] c"%ld\0A\00", align 1
@.print = private unnamed_addr constant [5 x i8] c"%ld \00", align 1
@.read = private unnamed_addr constant [4 x i8] c"%ld\00", align 1
@.read_scratch = common global i32 0, align 8
