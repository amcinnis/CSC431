target triple="i686"
%struct.simple = type {i32}
%struct.foo = type {i32, i32, %struct.simple*}

@globalfoo = common global %struct.foo* null, align 8

define void @tailrecursive(i32 %num) 
{
.LU1:
	%_P_num = alloca i32
	store i32 %num, i32* %_P_num
	%unused = alloca %struct.foo*
	br label %.LU2
.LU2:
	%u0 = load i32* %_P_num
	%u1 = icmp sle i32 %u0, 0
	br i1 %u1, label %.LU3, label %.JN0
.LU3:
	br label %.LU0
.JN0:
	%u2 = call i8* @malloc(i32 24)
	%u3 = bitcast i8* %u2 to %struct.foo*
	store %struct.foo* %u3, %struct.foo** %unused
	%u4 = load i32* %_P_num
	%u5 = sub i32 %u4, 1
	call void @tailrecursive(i32 %u5)
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
	%u6 = load i32* %_P_x
	%u7 = load i32* %_P_y
	%u8 = add i32 %u6, %u7
	store i32 %u8, i32* %_retval_
	br label %.LU4
.LU4:
	%u9 = load i32* %_retval_
	ret i32 %u9
}

define void @domath(i32 %num) 
{
.LU7:
	%_P_num = alloca i32
	store i32 %num, i32* %_P_num
	%math1 = alloca %struct.foo*
	%math2 = alloca %struct.foo*
	%tmp = alloca i32
	%u10 = call i8* @malloc(i32 24)
	%u11 = bitcast i8* %u10 to %struct.foo*
	store %struct.foo* %u11, %struct.foo** %math1
	%u12 = call i8* @malloc(i32 8)
	%u13 = bitcast i8* %u12 to %struct.simple*
	%u14 = load %struct.foo** %math1
	%u15 = getelementptr %struct.foo* %u14, i1 0, i32 2
	store %struct.simple* %u13, %struct.simple** %u15
	%u16 = call i8* @malloc(i32 24)
	%u17 = bitcast i8* %u16 to %struct.foo*
	store %struct.foo* %u17, %struct.foo** %math2
	%u18 = call i8* @malloc(i32 8)
	%u19 = bitcast i8* %u18 to %struct.simple*
	%u20 = load %struct.foo** %math2
	%u21 = getelementptr %struct.foo* %u20, i1 0, i32 2
	store %struct.simple* %u19, %struct.simple** %u21
	%u22 = load i32* %_P_num
	%u23 = load %struct.foo** %math1
	%u24 = getelementptr %struct.foo* %u23, i1 0, i32 0
	store i32 %u22, i32* %u24
	%u25 = load %struct.foo** %math2
	%u26 = getelementptr %struct.foo* %u25, i1 0, i32 0
	store i32 3, i32* %u26
	%u27 = load %struct.foo** %math1
	%u28 = getelementptr %struct.foo* %u27, i1 0, i32 0
	%u29 = load i32* %u28
	%u30 = load %struct.foo** %math1
	%u31 = getelementptr %struct.foo* %u30, i1 0, i32 2
	%u32 = load %struct.simple** %u31
	%u33 = getelementptr %struct.simple* %u32, i1 0, i32 0
	store i32 %u29, i32* %u33
	%u34 = load %struct.foo** %math2
	%u35 = getelementptr %struct.foo* %u34, i1 0, i32 0
	%u36 = load i32* %u35
	%u37 = load %struct.foo** %math2
	%u38 = getelementptr %struct.foo* %u37, i1 0, i32 2
	%u39 = load %struct.simple** %u38
	%u40 = getelementptr %struct.simple* %u39, i1 0, i32 0
	store i32 %u36, i32* %u40
	br label %.LU8
.LU8:
	%u41 = load i32* %_P_num
	%u42 = icmp sgt i32 %u41, 0
	br i1 %u42, label %.LU9, label %.LU10
.LU9:
	%u43 = load %struct.foo** %math1
	%u44 = getelementptr %struct.foo* %u43, i1 0, i32 0
	%u45 = load i32* %u44
	%u46 = load %struct.foo** %math2
	%u47 = getelementptr %struct.foo* %u46, i1 0, i32 0
	%u48 = load i32* %u47
	%u49 = mul i32 %u45, %u48
	store i32 %u49, i32* %tmp
	%u50 = load i32* %tmp
	%u51 = load %struct.foo** %math1
	%u52 = getelementptr %struct.foo* %u51, i1 0, i32 2
	%u53 = load %struct.simple** %u52
	%u54 = getelementptr %struct.simple* %u53, i1 0, i32 0
	%u55 = load i32* %u54
	%u56 = mul i32 %u50, %u55
	%u57 = load %struct.foo** %math2
	%u58 = getelementptr %struct.foo* %u57, i1 0, i32 0
	%u59 = load i32* %u58
	%u60 = sdiv i32 %u56, %u59
	store i32 %u60, i32* %tmp
	%u61 = load %struct.foo** %math2
	%u62 = getelementptr %struct.foo* %u61, i1 0, i32 2
	%u63 = load %struct.simple** %u62
	%u64 = getelementptr %struct.simple* %u63, i1 0, i32 0
	%u65 = load i32* %u64
	%u66 = load %struct.foo** %math1
	%u67 = getelementptr %struct.foo* %u66, i1 0, i32 0
	%u68 = load i32* %u67
	%u69 = call i32 @add(i32 %u65, i32 %u68)
	store i32 %u69, i32* %tmp
	%u70 = load %struct.foo** %math2
	%u71 = getelementptr %struct.foo* %u70, i1 0, i32 0
	%u72 = load i32* %u71
	%u73 = load %struct.foo** %math1
	%u74 = getelementptr %struct.foo* %u73, i1 0, i32 0
	%u75 = load i32* %u74
	%u76 = sub i32 %u72, %u75
	store i32 %u76, i32* %tmp
	%u77 = load i32* %_P_num
	%u78 = sub i32 %u77, 1
	store i32 %u78, i32* %_P_num
	%u79 = load i32* %_P_num
	%u80 = icmp sgt i32 %u79, 0
	br i1 %u80, label %.LU9, label %.LU10
.LU10:
	%u81 = load %struct.foo** %math1
	%u82 = bitcast %struct.foo* %u81 to i8*
	call void @free(i8* %u82)
	%u83 = load %struct.foo** %math2
	%u84 = bitcast %struct.foo* %u83 to i8*
	call void @free(i8* %u84)
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
	%u85 = load i32* %_P_num
	%u86 = icmp sgt i32 %u85, 0
	br i1 %u86, label %.LU14, label %.LU11
.LU14:
	%u87 = call i8* @malloc(i32 24)
	%u88 = bitcast i8* %u87 to %struct.foo*
	store %struct.foo* %u88, %struct.foo** %tmp
	%u89 = load %struct.foo** %tmp
	%u90 = bitcast %struct.foo* %u89 to i8*
	call void @free(i8* %u90)
	%u91 = load i32* %_P_num
	%u92 = sub i32 %u91, 1
	store i32 %u92, i32* %_P_num
	%u93 = load i32* %_P_num
	%u94 = icmp sgt i32 %u93, 0
	br i1 %u94, label %.LU14, label %.LU11
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
	%u95 = load i32* %_P_m
	%u96 = icmp eq i32 %u95, 0
	br i1 %u96, label %.LU18, label %.JN1
.LU18:
	%u97 = load i32* %_P_n
	%u98 = add i32 %u97, 1
	store i32 %u98, i32* %_retval_
	br label %.LU15
.JN1:
	br label %.LU19
.LU19:
	%u99 = load i32* %_P_n
	%u100 = icmp eq i32 %u99, 0
	br i1 %u100, label %.LU20, label %.LU21
.LU20:
	%u101 = load i32* %_P_m
	%u102 = sub i32 %u101, 1
	%u103 = call i32 @ackermann(i32 %u102, i32 1)
	store i32 %u103, i32* %_retval_
	br label %.LU15
.LU21:
	%u104 = load i32* %_P_m
	%u105 = sub i32 %u104, 1
	%u106 = load i32* %_P_m
	%u107 = load i32* %_P_n
	%u108 = sub i32 %u107, 1
	%u109 = call i32 @ackermann(i32 %u106, i32 %u108)
	%u110 = call i32 @ackermann(i32 %u105, i32 %u109)
	store i32 %u110, i32* %_retval_
	br label %.LU15
.LU15:
	%u111 = load i32* %_retval_
	ret i32 %u111
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
	%u112 = load i32* %a
	call void @tailrecursive(i32 %u112)
	%u113 = load i32* %a
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u113)
	%u114 = load i32* %b
	call void @domath(i32 %u114)
	%u115 = load i32* %b
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u115)
	%u116 = load i32* %c
	call void @objinstantiation(i32 %u116)
	%u117 = load i32* %c
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u117)
	%u118 = load i32* %d
	%u119 = load i32* %e
	%u120 = call i32 @ackermann(i32 %u118, i32 %u119)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u120)
	store i32 0, i32* %_retval_
	br label %.LU22
.LU22:
	%u121 = load i32* %_retval_
	ret i32 %u121
}

declare i8* @malloc(i32)
declare void @free(i8*)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
@.println = private unnamed_addr constant [5 x i8] c"%ld\0A\00", align 1
@.print = private unnamed_addr constant [5 x i8] c"%ld \00", align 1
@.read = private unnamed_addr constant [4 x i8] c"%ld\00", align 1
@.read_scratch = common global i32 0, align 8
