target triple="i686"
%struct.Node = type {i32, %struct.Node*, %struct.Node*}

@swapped = common global i32 0, align 8

define i32 @compare(%struct.Node* %a, %struct.Node* %b) 
{
.LU1:
	%_retval_ = alloca i32
	%_P_a = alloca %struct.Node*
	store %struct.Node* %a, %struct.Node** %_P_a
	%_P_b = alloca %struct.Node*
	store %struct.Node* %b, %struct.Node** %_P_b
	%u0 = load %struct.Node** %_P_a
	%u1 = getelementptr %struct.Node* %u0, i1 0, i32 0
	%u2 = load i32* %u1
	%u3 = load %struct.Node** %_P_b
	%u4 = getelementptr %struct.Node* %u3, i1 0, i32 0
	%u5 = load i32* %u4
	%u6 = sub i32 %u2, %u5
	store i32 %u6, i32* %_retval_
	br label %.LU0
.LU0:
	%u7 = load i32* %_retval_
	ret i32 %u7
}

define void @deathSort(%struct.Node* %head) 
{
.LU3:
	%_P_head = alloca %struct.Node*
	store %struct.Node* %head, %struct.Node** %_P_head
	%swapped = alloca i32
	%swap = alloca i32
	%currNode = alloca %struct.Node*
	store i32 1, i32* %swapped
	br label %.LU4
.LU4:
	%u8 = load i32* %swapped
	%u9 = icmp eq i32 %u8, 1
	br i1 %u9, label %.LU5, label %.LU2
.LU5:
	store i32 0, i32* %swapped
	%u10 = load %struct.Node** %_P_head
	store %struct.Node* %u10, %struct.Node** %currNode
	br label %.LU6
.LU6:
	%u11 = load %struct.Node** %currNode
	%u12 = getelementptr %struct.Node* %u11, i1 0, i32 2
	%u13 = load %struct.Node** %u12
	%u14 = load %struct.Node** %_P_head
	%u15 = icmp ne %struct.Node* %u13, %u14
	br i1 %u15, label %.LU7, label %.LU4
.LU7:
	%u16 = load %struct.Node** %currNode
	%u17 = load %struct.Node** %currNode
	%u18 = getelementptr %struct.Node* %u17, i1 0, i32 2
	%u19 = load %struct.Node** %u18
	%u20 = call i32 @compare(%struct.Node* %u16, %struct.Node* %u19)
	%u21 = icmp sgt i32 %u20, 0
	br i1 %u21, label %.LU8, label %.JN0
.LU8:
	%u22 = load %struct.Node** %currNode
	%u23 = getelementptr %struct.Node* %u22, i1 0, i32 0
	%u24 = load i32* %u23
	store i32 %u24, i32* %swap
	%u25 = load %struct.Node** %currNode
	%u26 = getelementptr %struct.Node* %u25, i1 0, i32 2
	%u27 = load %struct.Node** %u26
	%u28 = getelementptr %struct.Node* %u27, i1 0, i32 0
	%u29 = load i32* %u28
	%u30 = load %struct.Node** %currNode
	%u31 = getelementptr %struct.Node* %u30, i1 0, i32 0
	store i32 %u29, i32* %u31
	%u32 = load i32* %swap
	%u33 = load %struct.Node** %currNode
	%u34 = getelementptr %struct.Node* %u33, i1 0, i32 2
	%u35 = load %struct.Node** %u34
	%u36 = getelementptr %struct.Node* %u35, i1 0, i32 0
	store i32 %u32, i32* %u36
	store i32 1, i32* %swapped
	br label %.JN0
.JN0:
	%u37 = load %struct.Node** %currNode
	%u38 = getelementptr %struct.Node* %u37, i1 0, i32 2
	%u39 = load %struct.Node** %u38
	store %struct.Node* %u39, %struct.Node** %currNode
	%u40 = load %struct.Node** %currNode
	%u41 = getelementptr %struct.Node* %u40, i1 0, i32 2
	%u42 = load %struct.Node** %u41
	%u43 = load %struct.Node** %_P_head
	%u44 = icmp ne %struct.Node* %u42, %u43
	br i1 %u44, label %.LU7, label %.LU4
.LU2:
	ret void
}

define void @printEVILList(%struct.Node* %head) 
{
.LU10:
	%_P_head = alloca %struct.Node*
	store %struct.Node* %head, %struct.Node** %_P_head
	%currNode = alloca %struct.Node*
	%toFree = alloca %struct.Node*
	%u47 = load %struct.Node** %_P_head
	%u48 = getelementptr %struct.Node* %u47, i1 0, i32 2
	%u49 = load %struct.Node** %u48
	store %struct.Node* %u49, %struct.Node** %currNode
	%u50 = load %struct.Node** %_P_head
	%u51 = getelementptr %struct.Node* %u50, i1 0, i32 0
	%u52 = load i32* %u51
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u52)
	%u53 = load %struct.Node** %_P_head
	%u54 = bitcast %struct.Node* %u53 to i8*
	call void @free(i8* %u54)
	br label %.LU11
.LU11:
	%u55 = load %struct.Node** %currNode
	%u56 = load %struct.Node** %_P_head
	%u57 = icmp ne %struct.Node* %u55, %u56
	br i1 %u57, label %.LU12, label %.LU9
.LU12:
	%u58 = load %struct.Node** %currNode
	store %struct.Node* %u58, %struct.Node** %toFree
	%u59 = load %struct.Node** %currNode
	%u60 = getelementptr %struct.Node* %u59, i1 0, i32 0
	%u61 = load i32* %u60
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u61)
	%u62 = load %struct.Node** %currNode
	%u63 = getelementptr %struct.Node* %u62, i1 0, i32 2
	%u64 = load %struct.Node** %u63
	store %struct.Node* %u64, %struct.Node** %currNode
	%u65 = load %struct.Node** %toFree
	%u66 = bitcast %struct.Node* %u65 to i8*
	call void @free(i8* %u66)
	%u67 = load %struct.Node** %currNode
	%u68 = load %struct.Node** %_P_head
	%u69 = icmp ne %struct.Node* %u67, %u68
	br i1 %u69, label %.LU12, label %.LU9
.LU9:
	ret void
}

define i32 @main() 
{
.LU14:
	%_retval_ = alloca i32
	%numNodes = alloca i32
	%counter = alloca i32
	%currNode = alloca %struct.Node*
	%head = alloca %struct.Node*
	%previous = alloca %struct.Node*
	store i32 666, i32* @swapped
	call i32 (i8*, ...)* @scanf(i8* getelementptr inbounds ([4 x i8]* @.read, i32 0, i32 0), i32* %numNodes)
	br label %.LU15
.LU15:
	%u70 = load i32* %numNodes
	%u71 = icmp sle i32 %u70, 0
	br i1 %u71, label %.LU16, label %.JN1
.LU16:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 -1)
	store i32 -1, i32* %_retval_
	br label %.LU13
.JN1:
	%u72 = load i32* %numNodes
	%u73 = mul i32 %u72, 1000
	store i32 %u73, i32* %numNodes
	%u74 = load i32* %numNodes
	store i32 %u74, i32* %counter
	%u75 = call i8* @malloc(i32 24)
	%u76 = bitcast i8* %u75 to %struct.Node*
	store %struct.Node* %u76, %struct.Node** %head
	%u77 = load i32* %counter
	%u78 = load %struct.Node** %head
	%u79 = getelementptr %struct.Node* %u78, i1 0, i32 0
	store i32 %u77, i32* %u79
	%u80 = load %struct.Node** %head
	%u81 = load %struct.Node** %head
	%u82 = getelementptr %struct.Node* %u81, i1 0, i32 1
	store %struct.Node* %u80, %struct.Node** %u82
	%u83 = load %struct.Node** %head
	%u84 = load %struct.Node** %head
	%u85 = getelementptr %struct.Node* %u84, i1 0, i32 2
	store %struct.Node* %u83, %struct.Node** %u85
	%u86 = load i32* %counter
	%u87 = sub i32 %u86, 1
	store i32 %u87, i32* %counter
	%u88 = load %struct.Node** %head
	store %struct.Node* %u88, %struct.Node** %previous
	br label %.LU17
.LU17:
	%u89 = load i32* %counter
	%u90 = icmp sgt i32 %u89, 0
	br i1 %u90, label %.LU18, label %.LU19
.LU18:
	%u91 = call i8* @malloc(i32 24)
	%u92 = bitcast i8* %u91 to %struct.Node*
	store %struct.Node* %u92, %struct.Node** %currNode
	%u93 = load i32* %counter
	%u94 = load %struct.Node** %currNode
	%u95 = getelementptr %struct.Node* %u94, i1 0, i32 0
	store i32 %u93, i32* %u95
	%u96 = load %struct.Node** %previous
	%u97 = load %struct.Node** %currNode
	%u98 = getelementptr %struct.Node* %u97, i1 0, i32 1
	store %struct.Node* %u96, %struct.Node** %u98
	%u99 = load %struct.Node** %head
	%u100 = load %struct.Node** %currNode
	%u101 = getelementptr %struct.Node* %u100, i1 0, i32 2
	store %struct.Node* %u99, %struct.Node** %u101
	%u102 = load %struct.Node** %currNode
	%u103 = load %struct.Node** %previous
	%u104 = getelementptr %struct.Node* %u103, i1 0, i32 2
	store %struct.Node* %u102, %struct.Node** %u104
	%u105 = load %struct.Node** %currNode
	store %struct.Node* %u105, %struct.Node** %previous
	%u106 = load i32* %counter
	%u107 = sub i32 %u106, 1
	store i32 %u107, i32* %counter
	%u108 = load i32* %counter
	%u109 = icmp sgt i32 %u108, 0
	br i1 %u109, label %.LU18, label %.LU19
.LU19:
	%u110 = load %struct.Node** %head
	call void @deathSort(%struct.Node* %u110)
	%u111 = load %struct.Node** %head
	call void @printEVILList(%struct.Node* %u111)
	store i32 0, i32* %_retval_
	br label %.LU13
.LU13:
	%u112 = load i32* %_retval_
	ret i32 %u112
}

declare i8* @malloc(i32)
declare void @free(i8*)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
@.println = private unnamed_addr constant [5 x i8] c"%ld\0A\00", align 1
@.print = private unnamed_addr constant [5 x i8] c"%ld \00", align 1
@.read = private unnamed_addr constant [4 x i8] c"%ld\00", align 1
@.read_scratch = common global i32 0, align 8
