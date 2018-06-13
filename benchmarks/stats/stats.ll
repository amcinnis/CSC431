target triple="i686"
%struct.linkedNums = type {i32, %struct.linkedNums*}


define %struct.linkedNums* @getRands(i32 %seed, i32 %num) 
{
.LU1:
	%_retval_ = alloca %struct.linkedNums*
	%_P_seed = alloca i32
	store i32 %seed, i32* %_P_seed
	%_P_num = alloca i32
	store i32 %num, i32* %_P_num
	%cur = alloca i32
	%prev = alloca i32
	%curNode = alloca %struct.linkedNums*
	%prevNode = alloca %struct.linkedNums*
	store %struct.linkedNums* null, %struct.linkedNums** %curNode
	%u0 = load i32* %_P_seed
	%u1 = load i32* %_P_seed
	%u2 = mul i32 %u0, %u1
	store i32 %u2, i32* %cur
	%u3 = call i8* @malloc(i32 16)
	%u4 = bitcast i8* %u3 to %struct.linkedNums*
	store %struct.linkedNums* %u4, %struct.linkedNums** %prevNode
	%u5 = load i32* %cur
	%u6 = load %struct.linkedNums** %prevNode
	%u7 = getelementptr %struct.linkedNums* %u6, i1 0, i32 0
	store i32 %u5, i32* %u7
	%u8 = load %struct.linkedNums** %prevNode
	%u9 = getelementptr %struct.linkedNums* %u8, i1 0, i32 1
	store %struct.linkedNums* null, %struct.linkedNums** %u9
	%u10 = load i32* %_P_num
	%u11 = sub i32 %u10, 1
	store i32 %u11, i32* %_P_num
	%u12 = load i32* %cur
	store i32 %u12, i32* %prev
	br label %.LU2
.LU2:
	%u13 = load i32* %_P_num
	%u14 = icmp sgt i32 %u13, 0
	br i1 %u14, label %.LU3, label %.LU4
.LU3:
	%u15 = load i32* %prev
	%u16 = load i32* %prev
	%u17 = mul i32 %u15, %u16
	%u18 = load i32* %_P_seed
	%u19 = sdiv i32 %u17, %u18
	%u20 = load i32* %_P_seed
	%u21 = sdiv i32 %u20, 2
	%u22 = mul i32 %u19, %u21
	%u23 = add i32 %u22, 1
	store i32 %u23, i32* %cur
	%u24 = call i8* @malloc(i32 16)
	%u25 = bitcast i8* %u24 to %struct.linkedNums*
	store %struct.linkedNums* %u25, %struct.linkedNums** %curNode
	%u26 = load i32* %cur
	%u27 = load %struct.linkedNums** %curNode
	%u28 = getelementptr %struct.linkedNums* %u27, i1 0, i32 0
	store i32 %u26, i32* %u28
	%u29 = load %struct.linkedNums** %prevNode
	%u30 = load %struct.linkedNums** %curNode
	%u31 = getelementptr %struct.linkedNums* %u30, i1 0, i32 1
	store %struct.linkedNums* %u29, %struct.linkedNums** %u31
	%u32 = load %struct.linkedNums** %curNode
	store %struct.linkedNums* %u32, %struct.linkedNums** %prevNode
	%u33 = load i32* %_P_num
	%u34 = sub i32 %u33, 1
	store i32 %u34, i32* %_P_num
	%u35 = load i32* %cur
	store i32 %u35, i32* %prev
	%u36 = load i32* %_P_num
	%u37 = icmp sgt i32 %u36, 0
	br i1 %u37, label %.LU3, label %.LU4
.LU4:
	%u38 = load %struct.linkedNums** %curNode
	store %struct.linkedNums* %u38, %struct.linkedNums** %_retval_
	br label %.LU0
.LU0:
	%u39 = load %struct.linkedNums** %_retval_
	ret %struct.linkedNums* %u39
}

define i32 @calcMean(%struct.linkedNums* %nums) 
{
.LU6:
	%_retval_ = alloca i32
	%_P_nums = alloca %struct.linkedNums*
	store %struct.linkedNums* %nums, %struct.linkedNums** %_P_nums
	%sum = alloca i32
	%num = alloca i32
	%mean = alloca i32
	store i32 0, i32* %sum
	store i32 0, i32* %num
	store i32 0, i32* %mean
	br label %.LU7
.LU7:
	%u40 = load %struct.linkedNums** %_P_nums
	%u41 = icmp ne %struct.linkedNums* %u40, null
	br i1 %u41, label %.LU8, label %.LU9
.LU8:
	%u42 = load i32* %num
	%u43 = add i32 %u42, 1
	store i32 %u43, i32* %num
	%u44 = load i32* %sum
	%u45 = load %struct.linkedNums** %_P_nums
	%u46 = getelementptr %struct.linkedNums* %u45, i1 0, i32 0
	%u47 = load i32* %u46
	%u48 = add i32 %u44, %u47
	store i32 %u48, i32* %sum
	%u49 = load %struct.linkedNums** %_P_nums
	%u50 = getelementptr %struct.linkedNums* %u49, i1 0, i32 1
	%u51 = load %struct.linkedNums** %u50
	store %struct.linkedNums* %u51, %struct.linkedNums** %_P_nums
	%u52 = load %struct.linkedNums** %_P_nums
	%u53 = icmp ne %struct.linkedNums* %u52, null
	br i1 %u53, label %.LU8, label %.LU9
.LU9:
	%u54 = load i32* %num
	%u55 = icmp ne i32 %u54, 0
	br i1 %u55, label %.LU10, label %.JN0
.LU10:
	%u56 = load i32* %sum
	%u57 = load i32* %num
	%u58 = sdiv i32 %u56, %u57
	store i32 %u58, i32* %mean
	br label %.JN0
.JN0:
	%u59 = load i32* %mean
	store i32 %u59, i32* %_retval_
	br label %.LU5
.LU5:
	%u60 = load i32* %_retval_
	ret i32 %u60
}

define i32 @approxSqrt(i32 %num) 
{
.LU12:
	%_retval_ = alloca i32
	%_P_num = alloca i32
	store i32 %num, i32* %_P_num
	%guess = alloca i32
	%result = alloca i32
	%prev = alloca i32
	store i32 1, i32* %guess
	%u61 = load i32* %guess
	store i32 %u61, i32* %prev
	store i32 0, i32* %result
	br label %.LU13
.LU13:
	%u62 = load i32* %result
	%u63 = load i32* %_P_num
	%u64 = icmp slt i32 %u62, %u63
	br i1 %u64, label %.LU14, label %.LU15
.LU14:
	%u65 = load i32* %guess
	%u66 = load i32* %guess
	%u67 = mul i32 %u65, %u66
	store i32 %u67, i32* %result
	%u68 = load i32* %guess
	store i32 %u68, i32* %prev
	%u69 = load i32* %guess
	%u70 = add i32 %u69, 1
	store i32 %u70, i32* %guess
	%u71 = load i32* %result
	%u72 = load i32* %_P_num
	%u73 = icmp slt i32 %u71, %u72
	br i1 %u73, label %.LU14, label %.LU15
.LU15:
	%u74 = load i32* %prev
	store i32 %u74, i32* %_retval_
	br label %.LU11
.LU11:
	%u75 = load i32* %_retval_
	ret i32 %u75
}

define void @approxSqrtAll(%struct.linkedNums* %nums) 
{
.LU17:
	%_P_nums = alloca %struct.linkedNums*
	store %struct.linkedNums* %nums, %struct.linkedNums** %_P_nums
	br label %.LU18
.LU18:
	%u76 = load %struct.linkedNums** %_P_nums
	%u77 = icmp ne %struct.linkedNums* %u76, null
	br i1 %u77, label %.LU19, label %.LU16
.LU19:
	%u78 = load %struct.linkedNums** %_P_nums
	%u79 = getelementptr %struct.linkedNums* %u78, i1 0, i32 0
	%u80 = load i32* %u79
	%u81 = call i32 @approxSqrt(i32 %u80)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u81)
	%u82 = load %struct.linkedNums** %_P_nums
	%u83 = getelementptr %struct.linkedNums* %u82, i1 0, i32 1
	%u84 = load %struct.linkedNums** %u83
	store %struct.linkedNums* %u84, %struct.linkedNums** %_P_nums
	%u85 = load %struct.linkedNums** %_P_nums
	%u86 = icmp ne %struct.linkedNums* %u85, null
	br i1 %u86, label %.LU19, label %.LU16
.LU16:
	ret void
}

define void @range(%struct.linkedNums* %nums) 
{
.LU21:
	%_P_nums = alloca %struct.linkedNums*
	store %struct.linkedNums* %nums, %struct.linkedNums** %_P_nums
	%min = alloca i32
	%max = alloca i32
	%first = alloca i1
	store i32 0, i32* %min
	store i32 0, i32* %max
	store i1 true, i1* %first
	br label %.LU22
.LU22:
	%u87 = load %struct.linkedNums** %_P_nums
	%u88 = icmp ne %struct.linkedNums* %u87, null
	br i1 %u88, label %.LU23, label %.LU29
.LU23:
	%u89 = load i1* %first
	br i1 %u89, label %.LU24, label %.LU25
.LU24:
	%u90 = load %struct.linkedNums** %_P_nums
	%u91 = getelementptr %struct.linkedNums* %u90, i1 0, i32 0
	%u92 = load i32* %u91
	store i32 %u92, i32* %min
	%u93 = load %struct.linkedNums** %_P_nums
	%u94 = getelementptr %struct.linkedNums* %u93, i1 0, i32 0
	%u95 = load i32* %u94
	store i32 %u95, i32* %max
	store i1 false, i1* %first
	br label %.JN3
.JN3:
	%u112 = load %struct.linkedNums** %_P_nums
	%u113 = getelementptr %struct.linkedNums* %u112, i1 0, i32 1
	%u114 = load %struct.linkedNums** %u113
	store %struct.linkedNums* %u114, %struct.linkedNums** %_P_nums
	%u115 = load %struct.linkedNums** %_P_nums
	%u116 = icmp ne %struct.linkedNums* %u115, null
	br i1 %u116, label %.LU23, label %.LU29
.LU25:
	%u96 = load %struct.linkedNums** %_P_nums
	%u97 = getelementptr %struct.linkedNums* %u96, i1 0, i32 0
	%u98 = load i32* %u97
	%u99 = load i32* %min
	%u100 = icmp slt i32 %u98, %u99
	br i1 %u100, label %.LU26, label %.LU27
.LU26:
	%u101 = load %struct.linkedNums** %_P_nums
	%u102 = getelementptr %struct.linkedNums* %u101, i1 0, i32 0
	%u103 = load i32* %u102
	store i32 %u103, i32* %min
	br label %.JN2
.JN2:
	br label %.JN3
.LU27:
	%u104 = load %struct.linkedNums** %_P_nums
	%u105 = getelementptr %struct.linkedNums* %u104, i1 0, i32 0
	%u106 = load i32* %u105
	%u107 = load i32* %max
	%u108 = icmp sgt i32 %u106, %u107
	br i1 %u108, label %.LU28, label %.JN1
.LU28:
	%u109 = load %struct.linkedNums** %_P_nums
	%u110 = getelementptr %struct.linkedNums* %u109, i1 0, i32 0
	%u111 = load i32* %u110
	store i32 %u111, i32* %max
	br label %.JN1
.JN1:
	br label %.JN2
.LU29:
	%u117 = load i32* %min
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u117)
	%u118 = load i32* %max
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u118)
	br label %.LU20
.LU20:
	ret void
}

define i32 @main() 
{
.LU31:
	%_retval_ = alloca i32
	%seed = alloca i32
	%num = alloca i32
	%mean = alloca i32
	%nums = alloca %struct.linkedNums*
	call i32 (i8*, ...)* @scanf(i8* getelementptr inbounds ([4 x i8]* @.read, i32 0, i32 0), i32* %seed)
	call i32 (i8*, ...)* @scanf(i8* getelementptr inbounds ([4 x i8]* @.read, i32 0, i32 0), i32* %num)
	%u119 = load i32* %seed
	%u120 = load i32* %num
	%u121 = call %struct.linkedNums* @getRands(i32 %u119, i32 %u120)
	store %struct.linkedNums* %u121, %struct.linkedNums** %nums
	%u122 = load %struct.linkedNums** %nums
	%u123 = call i32 @calcMean(%struct.linkedNums* %u122)
	store i32 %u123, i32* %mean
	%u124 = load i32* %mean
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u124)
	%u125 = load %struct.linkedNums** %nums
	call void @range(%struct.linkedNums* %u125)
	%u126 = load %struct.linkedNums** %nums
	call void @approxSqrtAll(%struct.linkedNums* %u126)
	store i32 0, i32* %_retval_
	br label %.LU30
.LU30:
	%u127 = load i32* %_retval_
	ret i32 %u127
}

declare i8* @malloc(i32)
declare void @free(i8*)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
@.println = private unnamed_addr constant [5 x i8] c"%ld\0A\00", align 1
@.print = private unnamed_addr constant [5 x i8] c"%ld \00", align 1
@.read = private unnamed_addr constant [4 x i8] c"%ld\00", align 1
@.read_scratch = common global i32 0, align 8
