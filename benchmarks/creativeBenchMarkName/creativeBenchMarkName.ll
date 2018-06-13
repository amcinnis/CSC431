target triple="i686"
%struct.node = type {i32, %struct.node*}


define %struct.node* @buildList() 
{
.LU1:
	%_retval_ = alloca %struct.node*
	%input = alloca i32
	%i = alloca i32
	%n0 = alloca %struct.node*
	%n1 = alloca %struct.node*
	%n2 = alloca %struct.node*
	%n3 = alloca %struct.node*
	%n4 = alloca %struct.node*
	%n5 = alloca %struct.node*
	%u0 = call i8* @malloc(i32 16)
	%u1 = bitcast i8* %u0 to %struct.node*
	store %struct.node* %u1, %struct.node** %n0
	%u2 = call i8* @malloc(i32 16)
	%u3 = bitcast i8* %u2 to %struct.node*
	store %struct.node* %u3, %struct.node** %n1
	%u4 = call i8* @malloc(i32 16)
	%u5 = bitcast i8* %u4 to %struct.node*
	store %struct.node* %u5, %struct.node** %n2
	%u6 = call i8* @malloc(i32 16)
	%u7 = bitcast i8* %u6 to %struct.node*
	store %struct.node* %u7, %struct.node** %n3
	%u8 = call i8* @malloc(i32 16)
	%u9 = bitcast i8* %u8 to %struct.node*
	store %struct.node* %u9, %struct.node** %n4
	%u10 = call i8* @malloc(i32 16)
	%u11 = bitcast i8* %u10 to %struct.node*
	store %struct.node* %u11, %struct.node** %n5
	%u12 = load %struct.node** %n0
	%u13 = getelementptr %struct.node* %u12, i1 0, i32 0
	call i32 (i8*, ...)* @scanf(i8* getelementptr inbounds ([4 x i8]* @.read, i32 0, i32 0), i32* %u13)
	%u14 = load %struct.node** %n1
	%u15 = getelementptr %struct.node* %u14, i1 0, i32 0
	call i32 (i8*, ...)* @scanf(i8* getelementptr inbounds ([4 x i8]* @.read, i32 0, i32 0), i32* %u15)
	%u16 = load %struct.node** %n2
	%u17 = getelementptr %struct.node* %u16, i1 0, i32 0
	call i32 (i8*, ...)* @scanf(i8* getelementptr inbounds ([4 x i8]* @.read, i32 0, i32 0), i32* %u17)
	%u18 = load %struct.node** %n3
	%u19 = getelementptr %struct.node* %u18, i1 0, i32 0
	call i32 (i8*, ...)* @scanf(i8* getelementptr inbounds ([4 x i8]* @.read, i32 0, i32 0), i32* %u19)
	%u20 = load %struct.node** %n4
	%u21 = getelementptr %struct.node* %u20, i1 0, i32 0
	call i32 (i8*, ...)* @scanf(i8* getelementptr inbounds ([4 x i8]* @.read, i32 0, i32 0), i32* %u21)
	%u22 = load %struct.node** %n5
	%u23 = getelementptr %struct.node* %u22, i1 0, i32 0
	call i32 (i8*, ...)* @scanf(i8* getelementptr inbounds ([4 x i8]* @.read, i32 0, i32 0), i32* %u23)
	%u24 = load %struct.node** %n1
	%u25 = load %struct.node** %n0
	%u26 = getelementptr %struct.node* %u25, i1 0, i32 1
	store %struct.node* %u24, %struct.node** %u26
	%u27 = load %struct.node** %n2
	%u28 = load %struct.node** %n1
	%u29 = getelementptr %struct.node* %u28, i1 0, i32 1
	store %struct.node* %u27, %struct.node** %u29
	%u30 = load %struct.node** %n3
	%u31 = load %struct.node** %n2
	%u32 = getelementptr %struct.node* %u31, i1 0, i32 1
	store %struct.node* %u30, %struct.node** %u32
	%u33 = load %struct.node** %n4
	%u34 = load %struct.node** %n3
	%u35 = getelementptr %struct.node* %u34, i1 0, i32 1
	store %struct.node* %u33, %struct.node** %u35
	%u36 = load %struct.node** %n5
	%u37 = load %struct.node** %n4
	%u38 = getelementptr %struct.node* %u37, i1 0, i32 1
	store %struct.node* %u36, %struct.node** %u38
	%u39 = load %struct.node** %n5
	%u40 = getelementptr %struct.node* %u39, i1 0, i32 1
	store %struct.node* null, %struct.node** %u40
	%u41 = load %struct.node** %n0
	store %struct.node* %u41, %struct.node** %_retval_
	br label %.LU0
.LU0:
	%u42 = load %struct.node** %_retval_
	ret %struct.node* %u42
}

define i32 @multiple(%struct.node* %list) 
{
.LU3:
	%_retval_ = alloca i32
	%_P_list = alloca %struct.node*
	store %struct.node* %list, %struct.node** %_P_list
	%i = alloca i32
	%product = alloca i32
	%cur = alloca %struct.node*
	store i32 0, i32* %i
	%u43 = load %struct.node** %_P_list
	store %struct.node* %u43, %struct.node** %cur
	%u44 = load %struct.node** %cur
	%u45 = getelementptr %struct.node* %u44, i1 0, i32 0
	%u46 = load i32* %u45
	store i32 %u46, i32* %product
	%u47 = load %struct.node** %cur
	%u48 = getelementptr %struct.node* %u47, i1 0, i32 1
	%u49 = load %struct.node** %u48
	store %struct.node* %u49, %struct.node** %cur
	br label %.LU4
.LU4:
	%u50 = load i32* %i
	%u51 = icmp slt i32 %u50, 5
	br i1 %u51, label %.LU5, label %.LU6
.LU5:
	%u52 = load i32* %product
	%u53 = load %struct.node** %cur
	%u54 = getelementptr %struct.node* %u53, i1 0, i32 0
	%u55 = load i32* %u54
	%u56 = mul i32 %u52, %u55
	store i32 %u56, i32* %product
	%u57 = load %struct.node** %cur
	%u58 = getelementptr %struct.node* %u57, i1 0, i32 1
	%u59 = load %struct.node** %u58
	store %struct.node* %u59, %struct.node** %cur
	%u60 = load i32* %product
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u60)
	%u61 = load i32* %i
	%u62 = add i32 %u61, 1
	store i32 %u62, i32* %i
	%u63 = load i32* %i
	%u64 = icmp slt i32 %u63, 5
	br i1 %u64, label %.LU5, label %.LU6
.LU6:
	%u65 = load i32* %product
	store i32 %u65, i32* %_retval_
	br label %.LU2
.LU2:
	%u66 = load i32* %_retval_
	ret i32 %u66
}

define i32 @add(%struct.node* %list) 
{
.LU8:
	%_retval_ = alloca i32
	%_P_list = alloca %struct.node*
	store %struct.node* %list, %struct.node** %_P_list
	%i = alloca i32
	%sum = alloca i32
	%cur = alloca %struct.node*
	store i32 0, i32* %i
	%u67 = load %struct.node** %_P_list
	store %struct.node* %u67, %struct.node** %cur
	%u68 = load %struct.node** %cur
	%u69 = getelementptr %struct.node* %u68, i1 0, i32 0
	%u70 = load i32* %u69
	store i32 %u70, i32* %sum
	%u71 = load %struct.node** %cur
	%u72 = getelementptr %struct.node* %u71, i1 0, i32 1
	%u73 = load %struct.node** %u72
	store %struct.node* %u73, %struct.node** %cur
	br label %.LU9
.LU9:
	%u74 = load i32* %i
	%u75 = icmp slt i32 %u74, 5
	br i1 %u75, label %.LU10, label %.LU11
.LU10:
	%u76 = load i32* %sum
	%u77 = load %struct.node** %cur
	%u78 = getelementptr %struct.node* %u77, i1 0, i32 0
	%u79 = load i32* %u78
	%u80 = add i32 %u76, %u79
	store i32 %u80, i32* %sum
	%u81 = load %struct.node** %cur
	%u82 = getelementptr %struct.node* %u81, i1 0, i32 1
	%u83 = load %struct.node** %u82
	store %struct.node* %u83, %struct.node** %cur
	%u84 = load i32* %sum
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u84)
	%u85 = load i32* %i
	%u86 = add i32 %u85, 1
	store i32 %u86, i32* %i
	%u87 = load i32* %i
	%u88 = icmp slt i32 %u87, 5
	br i1 %u88, label %.LU10, label %.LU11
.LU11:
	%u89 = load i32* %sum
	store i32 %u89, i32* %_retval_
	br label %.LU7
.LU7:
	%u90 = load i32* %_retval_
	ret i32 %u90
}

define i32 @recurseList(%struct.node* %list) 
{
.LU13:
	%_retval_ = alloca i32
	%_P_list = alloca %struct.node*
	store %struct.node* %list, %struct.node** %_P_list
	br label %.LU14
.LU14:
	%u91 = load %struct.node** %_P_list
	%u92 = getelementptr %struct.node* %u91, i1 0, i32 1
	%u93 = load %struct.node** %u92
	%u94 = icmp eq %struct.node* %u93, null
	br i1 %u94, label %.LU15, label %.LU16
.LU15:
	%u95 = load %struct.node** %_P_list
	%u96 = getelementptr %struct.node* %u95, i1 0, i32 0
	%u97 = load i32* %u96
	store i32 %u97, i32* %_retval_
	br label %.LU12
.JN0:
	br label %.LU12
.LU16:
	%u98 = load %struct.node** %_P_list
	%u99 = getelementptr %struct.node* %u98, i1 0, i32 0
	%u100 = load i32* %u99
	%u101 = load %struct.node** %_P_list
	%u102 = getelementptr %struct.node* %u101, i1 0, i32 1
	%u103 = load %struct.node** %u102
	%u104 = call i32 @recurseList(%struct.node* %u103)
	%u105 = mul i32 %u100, %u104
	store i32 %u105, i32* %_retval_
	br label %.LU12
.LU12:
	%u106 = load i32* %_retval_
	ret i32 %u106
}

define i32 @main() 
{
.LU18:
	%_retval_ = alloca i32
	%list = alloca %struct.node*
	%product = alloca i32
	%sum = alloca i32
	%result = alloca i32
	%bigProduct = alloca i32
	%i = alloca i32
	store i32 0, i32* %i
	store i32 0, i32* %bigProduct
	%u107 = call %struct.node* @buildList()
	store %struct.node* %u107, %struct.node** %list
	%u108 = load %struct.node** %list
	%u109 = call i32 @multiple(%struct.node* %u108)
	store i32 %u109, i32* %product
	%u110 = load %struct.node** %list
	%u111 = call i32 @add(%struct.node* %u110)
	store i32 %u111, i32* %sum
	%u112 = load i32* %product
	%u113 = load i32* %sum
	%u114 = sdiv i32 %u113, 2
	%u115 = sub i32 %u112, %u114
	store i32 %u115, i32* %result
	br label %.LU19
.LU19:
	%u116 = load i32* %i
	%u117 = icmp slt i32 %u116, 2
	br i1 %u117, label %.LU20, label %.LU21
.LU20:
	%u118 = load i32* %bigProduct
	%u119 = load %struct.node** %list
	%u120 = call i32 @recurseList(%struct.node* %u119)
	%u121 = add i32 %u118, %u120
	store i32 %u121, i32* %bigProduct
	%u122 = load i32* %i
	%u123 = add i32 %u122, 1
	store i32 %u123, i32* %i
	%u124 = load i32* %i
	%u125 = icmp slt i32 %u124, 2
	br i1 %u125, label %.LU20, label %.LU21
.LU21:
	%u126 = load i32* %bigProduct
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u126)
	br label %.LU22
.LU22:
	%u127 = load i32* %bigProduct
	%u128 = icmp ne i32 %u127, 0
	br i1 %u128, label %.LU23, label %.LU24
.LU23:
	%u129 = load i32* %bigProduct
	%u130 = sub i32 %u129, 1
	store i32 %u130, i32* %bigProduct
	%u131 = load i32* %bigProduct
	%u132 = icmp ne i32 %u131, 0
	br i1 %u132, label %.LU23, label %.LU24
.LU24:
	%u133 = load i32* %result
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u133)
	%u134 = load i32* %bigProduct
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u134)
	store i32 0, i32* %_retval_
	br label %.LU17
.LU17:
	%u135 = load i32* %_retval_
	ret i32 %u135
}

declare i8* @malloc(i32)
declare void @free(i8*)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
@.println = private unnamed_addr constant [5 x i8] c"%ld\0A\00", align 1
@.print = private unnamed_addr constant [5 x i8] c"%ld \00", align 1
@.read = private unnamed_addr constant [4 x i8] c"%ld\00", align 1
@.read_scratch = common global i32 0, align 8
