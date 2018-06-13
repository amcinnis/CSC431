target triple="i686"
%struct.simple = type {i32}
%struct.foo = type {i32, i1, %struct.simple*}

@globalfoo = common global %struct.foo* null, align 8

define void @tailrecursive(i32 %num) 
{
.LU1:
	%_P_num = alloca i32
	store i32 %num, i32* %_P_num
	br label %.LU2
.LU2:
	%u0 = load i32* %_P_num
	%u1 = icmp sle i32 %u0, 0
	br i1 %u1, label %.LU3, label %.JN0
.LU3:
	br label %.LU0
.JN0:
	%u2 = load i32* %_P_num
	%u3 = sub i32 %u2, 1
	call void @tailrecursive(i32 %u3)
	br label %.LU0
.LU0:
	ret void
}

define i32 @add(i32 %x, i32 %y) 
{
.LU5:
	%_retval_ = alloca i32
	%_P_x = alloca i32
	store i32 %x, i32* %_P_x
	%_P_y = alloca i32
	store i32 %y, i32* %_P_y
	%u4 = load i32* %_P_x
	%u5 = load i32* %_P_y
	%u6 = add i32 %u4, %u5
	store i32 %u6, i32* %_retval_
	br label %.LU4
.LU4:
	%u7 = load i32* %_retval_
	ret i32 %u7
}

define void @domath(i32 %num) 
{
.LU7:
	%_P_num = alloca i32
	store i32 %num, i32* %_P_num
	%math1 = alloca %struct.foo*
	%math2 = alloca %struct.foo*
	%tmp = alloca i32
	%u8 = call i8* @malloc(i32 24)
	%u9 = bitcast i8* %u8 to %struct.foo*
	store %struct.foo* %u9, %struct.foo** %math1
	%u10 = call i8* @malloc(i32 8)
	%u11 = bitcast i8* %u10 to %struct.simple*
	%u12 = load %struct.foo** %math1
	%u13 = getelementptr %struct.foo* %u12, i1 0, i32 2
	store %struct.simple* %u11, %struct.simple** %u13
	%u14 = call i8* @malloc(i32 24)
	%u15 = bitcast i8* %u14 to %struct.foo*
	store %struct.foo* %u15, %struct.foo** %math2
	%u16 = call i8* @malloc(i32 8)
	%u17 = bitcast i8* %u16 to %struct.simple*
	%u18 = load %struct.foo** %math2
	%u19 = getelementptr %struct.foo* %u18, i1 0, i32 2
	store %struct.simple* %u17, %struct.simple** %u19
	%u20 = load i32* %_P_num
	%u21 = load %struct.foo** %math1
	%u22 = getelementptr %struct.foo* %u21, i1 0, i32 0
	store i32 %u20, i32* %u22
	%u23 = load %struct.foo** %math2
	%u24 = getelementptr %struct.foo* %u23, i1 0, i32 0
	store i32 3, i32* %u24
	%u25 = load %struct.foo** %math1
	%u26 = getelementptr %struct.foo* %u25, i1 0, i32 0
	%u27 = load i32* %u26
	%u28 = load %struct.foo** %math1
	%u29 = getelementptr %struct.foo* %u28, i1 0, i32 2
	%u30 = load %struct.simple** %u29
	%u31 = getelementptr %struct.simple* %u30, i1 0, i32 0
	store i32 %u27, i32* %u31
	%u32 = load %struct.foo** %math2
	%u33 = getelementptr %struct.foo* %u32, i1 0, i32 0
	%u34 = load i32* %u33
	%u35 = load %struct.foo** %math2
	%u36 = getelementptr %struct.foo* %u35, i1 0, i32 2
	%u37 = load %struct.simple** %u36
	%u38 = getelementptr %struct.simple* %u37, i1 0, i32 0
	store i32 %u34, i32* %u38
	br label %.LU8
.LU8:
	%u39 = load i32* %_P_num
	%u40 = icmp sgt i32 %u39, 0
	br i1 %u40, label %.LU9, label %.LU10
.LU9:
	%u41 = load %struct.foo** %math1
	%u42 = getelementptr %struct.foo* %u41, i1 0, i32 0
	%u43 = load i32* %u42
	%u44 = load %struct.foo** %math2
	%u45 = getelementptr %struct.foo* %u44, i1 0, i32 0
	%u46 = load i32* %u45
	%u47 = mul i32 %u43, %u46
	store i32 %u47, i32* %tmp
	%u48 = load i32* %tmp
	%u49 = load %struct.foo** %math1
	%u50 = getelementptr %struct.foo* %u49, i1 0, i32 2
	%u51 = load %struct.simple** %u50
	%u52 = getelementptr %struct.simple* %u51, i1 0, i32 0
	%u53 = load i32* %u52
	%u54 = mul i32 %u48, %u53
	%u55 = load %struct.foo** %math2
	%u56 = getelementptr %struct.foo* %u55, i1 0, i32 0
	%u57 = load i32* %u56
	%u58 = sdiv i32 %u54, %u57
	store i32 %u58, i32* %tmp
	%u59 = load %struct.foo** %math2
	%u60 = getelementptr %struct.foo* %u59, i1 0, i32 2
	%u61 = load %struct.simple** %u60
	%u62 = getelementptr %struct.simple* %u61, i1 0, i32 0
	%u63 = load i32* %u62
	%u64 = load %struct.foo** %math1
	%u65 = getelementptr %struct.foo* %u64, i1 0, i32 0
	%u66 = load i32* %u65
	%u67 = call i32 @add(i32 %u63, i32 %u66)
	store i32 %u67, i32* %tmp
	%u68 = load %struct.foo** %math2
	%u69 = getelementptr %struct.foo* %u68, i1 0, i32 0
	%u70 = load i32* %u69
	%u71 = load %struct.foo** %math1
	%u72 = getelementptr %struct.foo* %u71, i1 0, i32 0
	%u73 = load i32* %u72
	%u74 = sub i32 %u70, %u73
	store i32 %u74, i32* %tmp
	%u75 = load i32* %_P_num
	%u76 = sub i32 %u75, 1
	store i32 %u76, i32* %_P_num
	%u77 = load i32* %_P_num
	%u78 = icmp sgt i32 %u77, 0
	br i1 %u78, label %.LU9, label %.LU10
.LU10:
	%u79 = load %struct.foo** %math1
	%u80 = bitcast %struct.foo* %u79 to i8*
	call void @free(i8* %u80)
	%u81 = load %struct.foo** %math2
	%u82 = bitcast %struct.foo* %u81 to i8*
	call void @free(i8* %u82)
	br label %.LU6
.LU6:
	ret void
}

define void @objinstantiation(i32 %num) 
{
.LU12:
	%_P_num = alloca i32
	store i32 %num, i32* %_P_num
	%tmp = alloca %struct.foo*
	br label %.LU13
.LU13:
	%u83 = load i32* %_P_num
	%u84 = icmp sgt i32 %u83, 0
	br i1 %u84, label %.LU14, label %.LU11
.LU14:
	%u85 = call i8* @malloc(i32 24)
	%u86 = bitcast i8* %u85 to %struct.foo*
	store %struct.foo* %u86, %struct.foo** %tmp
	%u87 = load %struct.foo** %tmp
	%u88 = bitcast %struct.foo* %u87 to i8*
	call void @free(i8* %u88)
	%u89 = load i32* %_P_num
	%u90 = sub i32 %u89, 1
	store i32 %u90, i32* %_P_num
	%u91 = load i32* %_P_num
	%u92 = icmp sgt i32 %u91, 0
	br i1 %u92, label %.LU14, label %.LU11
.LU11:
	ret void
}

define i32 @ackermann(i32 %m, i32 %n) 
{
.LU16:
	%_retval_ = alloca i32
	%_P_m = alloca i32
	store i32 %m, i32* %_P_m
	%_P_n = alloca i32
	store i32 %n, i32* %_P_n
	br label %.LU17
.LU17:
	%u93 = load i32* %_P_m
	%u94 = icmp eq i32 %u93, 0
	br i1 %u94, label %.LU18, label %.JN1
.LU18:
	%u95 = load i32* %_P_n
	%u96 = add i32 %u95, 1
	store i32 %u96, i32* %_retval_
	br label %.LU15
.JN1:
	br label %.LU19
.LU19:
	%u97 = load i32* %_P_n
	%u98 = icmp eq i32 %u97, 0
	br i1 %u98, label %.LU20, label %.LU21
.LU20:
	%u99 = load i32* %_P_m
	%u100 = sub i32 %u99, 1
	%u101 = call i32 @ackermann(i32 %u100, i32 1)
	store i32 %u101, i32* %_retval_
	br label %.LU15
.JN2:
	br label %.LU15
.LU21:
	%u102 = load i32* %_P_m
	%u103 = sub i32 %u102, 1
	%u104 = load i32* %_P_m
	%u105 = load i32* %_P_n
	%u106 = sub i32 %u105, 1
	%u107 = call i32 @ackermann(i32 %u104, i32 %u106)
	%u108 = call i32 @ackermann(i32 %u103, i32 %u107)
	store i32 %u108, i32* %_retval_
	br label %.LU15
.LU15:
	%u109 = load i32* %_retval_
	ret i32 %u109
}

define i32 @main() 
{
.LU23:
	%_retval_ = alloca i32
	%a = alloca i32
	%b = alloca i32
	%c = alloca i32
	%d = alloca i32
	%e = alloca i32
	call i32 (i8*, ...)* @scanf(i8* getelementptr inbounds ([4 x i8]* @.read, i32 0, i32 0), i32* %a)
	call i32 (i8*, ...)* @scanf(i8* getelementptr inbounds ([4 x i8]* @.read, i32 0, i32 0), i32* %b)
	call i32 (i8*, ...)* @scanf(i8* getelementptr inbounds ([4 x i8]* @.read, i32 0, i32 0), i32* %c)
	call i32 (i8*, ...)* @scanf(i8* getelementptr inbounds ([4 x i8]* @.read, i32 0, i32 0), i32* %d)
	call i32 (i8*, ...)* @scanf(i8* getelementptr inbounds ([4 x i8]* @.read, i32 0, i32 0), i32* %e)
	%u110 = load i32* %a
	call void @tailrecursive(i32 %u110)
	%u111 = load i32* %a
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u111)
	%u112 = load i32* %b
	call void @domath(i32 %u112)
	%u113 = load i32* %b
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u113)
	%u114 = load i32* %c
	call void @objinstantiation(i32 %u114)
	%u115 = load i32* %c
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u115)
	%u116 = load i32* %d
	%u117 = load i32* %e
	%u118 = call i32 @ackermann(i32 %u116, i32 %u117)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u118)
	store i32 0, i32* %_retval_
	br label %.LU22
.LU22:
	%u119 = load i32* %_retval_
	ret i32 %u119
}

declare i8* @malloc(i32)
declare void @free(i8*)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
@.println = private unnamed_addr constant [5 x i8] c"%ld\0A\00", align 1
@.print = private unnamed_addr constant [5 x i8] c"%ld \00", align 1
@.read = private unnamed_addr constant [4 x i8] c"%ld\00", align 1
@.read_scratch = common global i32 0, align 8
