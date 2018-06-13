target triple="i686"
%struct.node = type {i32, %struct.node*}
%struct.tnode = type {i32, %struct.tnode*, %struct.tnode*}
%struct.i = type {i32}
%struct.myCopy = type {i1}

@a = common global i32 0, align 8
@b = common global i32 0, align 8
@i = common global %struct.i* null, align 8

define %struct.node* @concatLists(%struct.node* %first, %struct.node* %second) 
{
.LU1:
	%_retval_ = alloca %struct.node*
	%_P_first = alloca %struct.node*
	store %struct.node* %first, %struct.node** %_P_first
	%_P_second = alloca %struct.node*
	store %struct.node* %second, %struct.node** %_P_second
	%temp = alloca %struct.node*
	%u0 = load %struct.node** %_P_first
	store %struct.node* %u0, %struct.node** %temp
	br label %.LU2
.LU2:
	%u1 = load %struct.node** %_P_first
	%u2 = icmp eq %struct.node* %u1, null
	br i1 %u2, label %.LU3, label %.JN0
.LU3:
	%u3 = load %struct.node** %_P_second
	store %struct.node* %u3, %struct.node** %_retval_
	br label %.LU0
.JN0:
	br label %.LU4
.LU4:
	%u4 = load %struct.node** %temp
	%u5 = getelementptr %struct.node* %u4, i1 0, i32 1
	%u6 = load %struct.node** %u5
	%u7 = icmp ne %struct.node* %u6, null
	br i1 %u7, label %.LU5, label %.LU6
.LU5:
	%u8 = load %struct.node** %temp
	%u9 = getelementptr %struct.node* %u8, i1 0, i32 1
	%u10 = load %struct.node** %u9
	store %struct.node* %u10, %struct.node** %temp
	%u11 = load %struct.node** %temp
	%u12 = getelementptr %struct.node* %u11, i1 0, i32 1
	%u13 = load %struct.node** %u12
	%u14 = icmp ne %struct.node* %u13, null
	br i1 %u14, label %.LU5, label %.LU6
.LU6:
	%u15 = load %struct.node** %_P_second
	%u16 = load %struct.node** %temp
	%u17 = getelementptr %struct.node* %u16, i1 0, i32 1
	store %struct.node* %u15, %struct.node** %u17
	%u18 = load %struct.node** %_P_first
	store %struct.node* %u18, %struct.node** %_retval_
	br label %.LU0
.LU0:
	%u19 = load %struct.node** %_retval_
	ret %struct.node* %u19
}

define %struct.node* @add(%struct.node* %list, i32 %toAdd) 
{
.LU8:
	%_retval_ = alloca %struct.node*
	%_P_list = alloca %struct.node*
	store %struct.node* %list, %struct.node** %_P_list
	%_P_toAdd = alloca i32
	store i32 %toAdd, i32* %_P_toAdd
	%newNode = alloca %struct.node*
	%u20 = call i8* @malloc(i32 16)
	%u21 = bitcast i8* %u20 to %struct.node*
	store %struct.node* %u21, %struct.node** %newNode
	%u22 = load i32* %_P_toAdd
	%u23 = load %struct.node** %newNode
	%u24 = getelementptr %struct.node* %u23, i1 0, i32 0
	store i32 %u22, i32* %u24
	%u25 = load %struct.node** %_P_list
	%u26 = load %struct.node** %newNode
	%u27 = getelementptr %struct.node* %u26, i1 0, i32 1
	store %struct.node* %u25, %struct.node** %u27
	%u28 = load %struct.node** %newNode
	store %struct.node* %u28, %struct.node** %_retval_
	br label %.LU7
.LU7:
	%u29 = load %struct.node** %_retval_
	ret %struct.node* %u29
}

define i32 @size(%struct.node* %list) 
{
.LU10:
	%_retval_ = alloca i32
	%_P_list = alloca %struct.node*
	store %struct.node* %list, %struct.node** %_P_list
	br label %.LU11
.LU11:
	%u30 = load %struct.node** %_P_list
	%u31 = icmp eq %struct.node* %u30, null
	br i1 %u31, label %.LU12, label %.JN1
.LU12:
	store i32 0, i32* %_retval_
	br label %.LU9
.JN1:
	%u32 = load %struct.node** %_P_list
	%u33 = getelementptr %struct.node* %u32, i1 0, i32 1
	%u34 = load %struct.node** %u33
	%u35 = call i32 @size(%struct.node* %u34)
	%u36 = add i32 1, %u35
	store i32 %u36, i32* %_retval_
	br label %.LU9
.LU9:
	%u37 = load i32* %_retval_
	ret i32 %u37
}

define i32 @get(%struct.node* %list, i32 %index) 
{
.LU14:
	%_retval_ = alloca i32
	%_P_list = alloca %struct.node*
	store %struct.node* %list, %struct.node** %_P_list
	%_P_index = alloca i32
	store i32 %index, i32* %_P_index
	br label %.LU15
.LU15:
	%u38 = load i32* %_P_index
	%u39 = icmp eq i32 %u38, 0
	br i1 %u39, label %.LU16, label %.JN2
.LU16:
	%u40 = load %struct.node** %_P_list
	%u41 = getelementptr %struct.node* %u40, i1 0, i32 0
	%u42 = load i32* %u41
	store i32 %u42, i32* %_retval_
	br label %.LU13
.JN2:
	%u43 = load %struct.node** %_P_list
	%u44 = getelementptr %struct.node* %u43, i1 0, i32 1
	%u45 = load %struct.node** %u44
	%u46 = load i32* %_P_index
	%u47 = sub i32 %u46, 1
	%u48 = call i32 @get(%struct.node* %u45, i32 %u47)
	store i32 %u48, i32* %_retval_
	br label %.LU13
.LU13:
	%u49 = load i32* %_retval_
	ret i32 %u49
}

define %struct.node* @pop(%struct.node* %list) 
{
.LU18:
	%_retval_ = alloca %struct.node*
	%_P_list = alloca %struct.node*
	store %struct.node* %list, %struct.node** %_P_list
	%u50 = load %struct.node** %_P_list
	%u51 = getelementptr %struct.node* %u50, i1 0, i32 1
	%u52 = load %struct.node** %u51
	store %struct.node* %u52, %struct.node** %_P_list
	%u53 = load %struct.node** %_P_list
	store %struct.node* %u53, %struct.node** %_retval_
	br label %.LU17
.LU17:
	%u54 = load %struct.node** %_retval_
	ret %struct.node* %u54
}

define void @printList(%struct.node* %list) 
{
.LU20:
	%_P_list = alloca %struct.node*
	store %struct.node* %list, %struct.node** %_P_list
	br label %.LU21
.LU21:
	%u55 = load %struct.node** %_P_list
	%u56 = icmp ne %struct.node* %u55, null
	br i1 %u56, label %.LU22, label %.JN3
.LU22:
	%u57 = load %struct.node** %_P_list
	%u58 = getelementptr %struct.node* %u57, i1 0, i32 0
	%u59 = load i32* %u58
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u59)
	%u60 = load %struct.node** %_P_list
	%u61 = getelementptr %struct.node* %u60, i1 0, i32 1
	%u62 = load %struct.node** %u61
	call void @printList(%struct.node* %u62)
	br label %.JN3
.JN3:
	br label %.LU19
.LU19:
	ret void
}

define void @treeprint(%struct.tnode* %root) 
{
.LU24:
	%_P_root = alloca %struct.tnode*
	store %struct.tnode* %root, %struct.tnode** %_P_root
	br label %.LU25
.LU25:
	%u63 = load %struct.tnode** %_P_root
	%u64 = icmp ne %struct.tnode* %u63, null
	br i1 %u64, label %.LU26, label %.JN4
.LU26:
	%u65 = load %struct.tnode** %_P_root
	%u66 = getelementptr %struct.tnode* %u65, i1 0, i32 1
	%u67 = load %struct.tnode** %u66
	call void @treeprint(%struct.tnode* %u67)
	%u68 = load %struct.tnode** %_P_root
	%u69 = getelementptr %struct.tnode* %u68, i1 0, i32 0
	%u70 = load i32* %u69
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u70)
	%u71 = load %struct.tnode** %_P_root
	%u72 = getelementptr %struct.tnode* %u71, i1 0, i32 2
	%u73 = load %struct.tnode** %u72
	call void @treeprint(%struct.tnode* %u73)
	br label %.JN4
.JN4:
	br label %.LU23
.LU23:
	ret void
}

define void @freeList(%struct.node* %list) 
{
.LU28:
	%_P_list = alloca %struct.node*
	store %struct.node* %list, %struct.node** %_P_list
	br label %.LU29
.LU29:
	%u74 = load %struct.node** %_P_list
	%u75 = icmp ne %struct.node* %u74, null
	br i1 %u75, label %.LU30, label %.JN5
.LU30:
	%u76 = load %struct.node** %_P_list
	%u77 = getelementptr %struct.node* %u76, i1 0, i32 1
	%u78 = load %struct.node** %u77
	call void @freeList(%struct.node* %u78)
	%u79 = load %struct.node** %_P_list
	%u80 = bitcast %struct.node* %u79 to i8*
	call void @free(i8* %u80)
	br label %.JN5
.JN5:
	br label %.LU27
.LU27:
	ret void
}

define void @freeTree(%struct.tnode* %root) 
{
.LU32:
	%_P_root = alloca %struct.tnode*
	store %struct.tnode* %root, %struct.tnode** %_P_root
	br label %.LU33
.LU33:
	%u81 = load %struct.tnode** %_P_root
	%u82 = icmp eq %struct.tnode* %u81, null
	%u83 = xor i1 %u82, 1
	br i1 %u83, label %.LU34, label %.JN6
.LU34:
	%u84 = load %struct.tnode** %_P_root
	%u85 = getelementptr %struct.tnode* %u84, i1 0, i32 1
	%u86 = load %struct.tnode** %u85
	call void @freeTree(%struct.tnode* %u86)
	%u87 = load %struct.tnode** %_P_root
	%u88 = getelementptr %struct.tnode* %u87, i1 0, i32 2
	%u89 = load %struct.tnode** %u88
	call void @freeTree(%struct.tnode* %u89)
	%u90 = load %struct.tnode** %_P_root
	%u91 = bitcast %struct.tnode* %u90 to i8*
	call void @free(i8* %u91)
	br label %.JN6
.JN6:
	br label %.LU31
.LU31:
	ret void
}

define %struct.node* @postOrder(%struct.tnode* %root) 
{
.LU36:
	%_retval_ = alloca %struct.node*
	%_P_root = alloca %struct.tnode*
	store %struct.tnode* %root, %struct.tnode** %_P_root
	%temp = alloca %struct.node*
	br label %.LU37
.LU37:
	%u92 = load %struct.tnode** %_P_root
	%u93 = icmp ne %struct.tnode* %u92, null
	br i1 %u93, label %.LU38, label %.JN7
.LU38:
	%u94 = call i8* @malloc(i32 16)
	%u95 = bitcast i8* %u94 to %struct.node*
	store %struct.node* %u95, %struct.node** %temp
	%u96 = load %struct.tnode** %_P_root
	%u97 = getelementptr %struct.tnode* %u96, i1 0, i32 0
	%u98 = load i32* %u97
	%u99 = load %struct.node** %temp
	%u100 = getelementptr %struct.node* %u99, i1 0, i32 0
	store i32 %u98, i32* %u100
	%u101 = load %struct.node** %temp
	%u102 = getelementptr %struct.node* %u101, i1 0, i32 1
	store %struct.node* null, %struct.node** %u102
	%u103 = load %struct.tnode** %_P_root
	%u104 = getelementptr %struct.tnode* %u103, i1 0, i32 1
	%u105 = load %struct.tnode** %u104
	%u106 = call %struct.node* @postOrder(%struct.tnode* %u105)
	%u107 = load %struct.tnode** %_P_root
	%u108 = getelementptr %struct.tnode* %u107, i1 0, i32 2
	%u109 = load %struct.tnode** %u108
	%u110 = call %struct.node* @postOrder(%struct.tnode* %u109)
	%u111 = call %struct.node* @concatLists(%struct.node* %u106, %struct.node* %u110)
	%u112 = load %struct.node** %temp
	%u113 = call %struct.node* @concatLists(%struct.node* %u111, %struct.node* %u112)
	store %struct.node* %u113, %struct.node** %_retval_
	br label %.LU35
.JN7:
	store %struct.node* null, %struct.node** %_retval_
	br label %.LU35
.LU35:
	%u114 = load %struct.node** %_retval_
	ret %struct.node* %u114
}

define %struct.tnode* @treeadd(%struct.tnode* %root, i32 %toAdd) 
{
.LU40:
	%_retval_ = alloca %struct.tnode*
	%_P_root = alloca %struct.tnode*
	store %struct.tnode* %root, %struct.tnode** %_P_root
	%_P_toAdd = alloca i32
	store i32 %toAdd, i32* %_P_toAdd
	%temp = alloca %struct.tnode*
	br label %.LU41
.LU41:
	%u115 = load %struct.tnode** %_P_root
	%u116 = icmp eq %struct.tnode* %u115, null
	br i1 %u116, label %.LU42, label %.JN8
.LU42:
	%u117 = call i8* @malloc(i32 24)
	%u118 = bitcast i8* %u117 to %struct.tnode*
	store %struct.tnode* %u118, %struct.tnode** %temp
	%u119 = load i32* %_P_toAdd
	%u120 = load %struct.tnode** %temp
	%u121 = getelementptr %struct.tnode* %u120, i1 0, i32 0
	store i32 %u119, i32* %u121
	%u122 = load %struct.tnode** %temp
	%u123 = getelementptr %struct.tnode* %u122, i1 0, i32 1
	store %struct.tnode* null, %struct.tnode** %u123
	%u124 = load %struct.tnode** %temp
	%u125 = getelementptr %struct.tnode* %u124, i1 0, i32 2
	store %struct.tnode* null, %struct.tnode** %u125
	%u126 = load %struct.tnode** %temp
	store %struct.tnode* %u126, %struct.tnode** %_retval_
	br label %.LU39
.JN8:
	br label %.LU43
.LU43:
	%u127 = load i32* %_P_toAdd
	%u128 = load %struct.tnode** %_P_root
	%u129 = getelementptr %struct.tnode* %u128, i1 0, i32 0
	%u130 = load i32* %u129
	%u131 = icmp slt i32 %u127, %u130
	br i1 %u131, label %.LU44, label %.LU45
.LU44:
	%u132 = load %struct.tnode** %_P_root
	%u133 = getelementptr %struct.tnode* %u132, i1 0, i32 1
	%u134 = load %struct.tnode** %u133
	%u135 = load i32* %_P_toAdd
	%u136 = call %struct.tnode* @treeadd(%struct.tnode* %u134, i32 %u135)
	%u137 = load %struct.tnode** %_P_root
	%u138 = getelementptr %struct.tnode* %u137, i1 0, i32 1
	store %struct.tnode* %u136, %struct.tnode** %u138
	br label %.JN9
.JN9:
	%u146 = load %struct.tnode** %_P_root
	store %struct.tnode* %u146, %struct.tnode** %_retval_
	br label %.LU39
.LU45:
	%u139 = load %struct.tnode** %_P_root
	%u140 = getelementptr %struct.tnode* %u139, i1 0, i32 2
	%u141 = load %struct.tnode** %u140
	%u142 = load i32* %_P_toAdd
	%u143 = call %struct.tnode* @treeadd(%struct.tnode* %u141, i32 %u142)
	%u144 = load %struct.tnode** %_P_root
	%u145 = getelementptr %struct.tnode* %u144, i1 0, i32 2
	store %struct.tnode* %u143, %struct.tnode** %u145
	br label %.JN9
.LU39:
	%u147 = load %struct.tnode** %_retval_
	ret %struct.tnode* %u147
}

define %struct.node* @quickSort(%struct.node* %list) 
{
.LU47:
	%_retval_ = alloca %struct.node*
	%_P_list = alloca %struct.node*
	store %struct.node* %list, %struct.node** %_P_list
	%pivot = alloca i32
	%i = alloca i32
	%less = alloca %struct.node*
	%greater = alloca %struct.node*
	%temp = alloca %struct.node*
	store %struct.node* null, %struct.node** %less
	store %struct.node* null, %struct.node** %greater
	br label %.LU48
.LU48:
	%u148 = load %struct.node** %_P_list
	%u149 = call i32 @size(%struct.node* %u148)
	%u150 = icmp sle i32 %u149, 1
	br i1 %u150, label %.LU49, label %.JN10
.LU49:
	%u151 = load %struct.node** %_P_list
	store %struct.node* %u151, %struct.node** %_retval_
	br label %.LU46
.JN10:
	%u152 = load %struct.node** %_P_list
	%u153 = call i32 @get(%struct.node* %u152, i32 0)
	%u154 = load %struct.node** %_P_list
	%u155 = load %struct.node** %_P_list
	%u156 = call i32 @size(%struct.node* %u155)
	%u157 = sub i32 %u156, 1
	%u158 = call i32 @get(%struct.node* %u154, i32 %u157)
	%u159 = add i32 %u153, %u158
	%u160 = sdiv i32 %u159, 2
	store i32 %u160, i32* %pivot
	%u161 = load %struct.node** %_P_list
	store %struct.node* %u161, %struct.node** %temp
	store i32 0, i32* %i
	br label %.LU50
.LU50:
	%u162 = load %struct.node** %temp
	%u163 = icmp ne %struct.node* %u162, null
	br i1 %u163, label %.LU51, label %.LU54
.LU51:
	%u164 = load %struct.node** %_P_list
	%u165 = load i32* %i
	%u166 = call i32 @get(%struct.node* %u164, i32 %u165)
	%u167 = load i32* %pivot
	%u168 = icmp sgt i32 %u166, %u167
	br i1 %u168, label %.LU52, label %.LU53
.LU52:
	%u169 = load %struct.node** %greater
	%u170 = load %struct.node** %_P_list
	%u171 = load i32* %i
	%u172 = call i32 @get(%struct.node* %u170, i32 %u171)
	%u173 = call %struct.node* @add(%struct.node* %u169, i32 %u172)
	store %struct.node* %u173, %struct.node** %greater
	br label %.JN11
.JN11:
	%u179 = load %struct.node** %temp
	%u180 = getelementptr %struct.node* %u179, i1 0, i32 1
	%u181 = load %struct.node** %u180
	store %struct.node* %u181, %struct.node** %temp
	%u182 = load i32* %i
	%u183 = add i32 %u182, 1
	store i32 %u183, i32* %i
	%u184 = load %struct.node** %temp
	%u185 = icmp ne %struct.node* %u184, null
	br i1 %u185, label %.LU51, label %.LU54
.LU53:
	%u174 = load %struct.node** %less
	%u175 = load %struct.node** %_P_list
	%u176 = load i32* %i
	%u177 = call i32 @get(%struct.node* %u175, i32 %u176)
	%u178 = call %struct.node* @add(%struct.node* %u174, i32 %u177)
	store %struct.node* %u178, %struct.node** %less
	br label %.JN11
.LU54:
	%u186 = load %struct.node** %_P_list
	call void @freeList(%struct.node* %u186)
	%u187 = load %struct.node** %less
	%u188 = call %struct.node* @quickSort(%struct.node* %u187)
	%u189 = load %struct.node** %greater
	%u190 = call %struct.node* @quickSort(%struct.node* %u189)
	%u191 = call %struct.node* @concatLists(%struct.node* %u188, %struct.node* %u190)
	store %struct.node* %u191, %struct.node** %_retval_
	br label %.LU46
.LU46:
	%u192 = load %struct.node** %_retval_
	ret %struct.node* %u192
}

define %struct.node* @quickSortMain(%struct.node* %list) 
{
.LU56:
	%_retval_ = alloca %struct.node*
	%_P_list = alloca %struct.node*
	store %struct.node* %list, %struct.node** %_P_list
	%u193 = load %struct.node** %_P_list
	call void @printList(%struct.node* %u193)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 -999)
	%u194 = load %struct.node** %_P_list
	call void @printList(%struct.node* %u194)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 -999)
	%u195 = load %struct.node** %_P_list
	call void @printList(%struct.node* %u195)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 -999)
	store %struct.node* null, %struct.node** %_retval_
	br label %.LU55
.LU55:
	%u196 = load %struct.node** %_retval_
	ret %struct.node* %u196
}

define i32 @treesearch(%struct.tnode* %root, i32 %target) 
{
.LU58:
	%_retval_ = alloca i32
	%_P_root = alloca %struct.tnode*
	store %struct.tnode* %root, %struct.tnode** %_P_root
	%_P_target = alloca i32
	store i32 %target, i32* %_P_target
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 -1)
	br label %.LU59
.LU59:
	%u197 = load %struct.tnode** %_P_root
	%u198 = icmp ne %struct.tnode* %u197, null
	br i1 %u198, label %.LU60, label %.JN15
.LU60:
	%u199 = load %struct.tnode** %_P_root
	%u200 = getelementptr %struct.tnode* %u199, i1 0, i32 0
	%u201 = load i32* %u200
	%u202 = load i32* %_P_target
	%u203 = icmp eq i32 %u201, %u202
	br i1 %u203, label %.LU61, label %.JN12
.LU61:
	store i32 1, i32* %_retval_
	br label %.LU57
.JN12:
	br label %.LU62
.LU62:
	%u204 = load %struct.tnode** %_P_root
	%u205 = getelementptr %struct.tnode* %u204, i1 0, i32 1
	%u206 = load %struct.tnode** %u205
	%u207 = load i32* %_P_target
	%u208 = call i32 @treesearch(%struct.tnode* %u206, i32 %u207)
	%u209 = icmp eq i32 %u208, 1
	br i1 %u209, label %.LU63, label %.JN13
.LU63:
	store i32 1, i32* %_retval_
	br label %.LU57
.JN13:
	br label %.LU64
.LU64:
	%u210 = load %struct.tnode** %_P_root
	%u211 = getelementptr %struct.tnode* %u210, i1 0, i32 2
	%u212 = load %struct.tnode** %u211
	%u213 = load i32* %_P_target
	%u214 = call i32 @treesearch(%struct.tnode* %u212, i32 %u213)
	%u215 = icmp eq i32 %u214, 1
	br i1 %u215, label %.LU65, label %.LU66
.LU65:
	store i32 1, i32* %_retval_
	br label %.LU57
.JN14:
	br label %.JN15
.JN15:
	store i32 0, i32* %_retval_
	br label %.LU57
.LU66:
	store i32 0, i32* %_retval_
	br label %.LU57
.LU57:
	%u216 = load i32* %_retval_
	ret i32 %u216
}

define %struct.node* @inOrder(%struct.tnode* %root) 
{
.LU68:
	%_retval_ = alloca %struct.node*
	%_P_root = alloca %struct.tnode*
	store %struct.tnode* %root, %struct.tnode** %_P_root
	%temp = alloca %struct.node*
	br label %.LU69
.LU69:
	%u217 = load %struct.tnode** %_P_root
	%u218 = icmp ne %struct.tnode* %u217, null
	br i1 %u218, label %.LU70, label %.LU71
.LU70:
	%u219 = call i8* @malloc(i32 16)
	%u220 = bitcast i8* %u219 to %struct.node*
	store %struct.node* %u220, %struct.node** %temp
	%u221 = load %struct.tnode** %_P_root
	%u222 = getelementptr %struct.tnode* %u221, i1 0, i32 0
	%u223 = load i32* %u222
	%u224 = load %struct.node** %temp
	%u225 = getelementptr %struct.node* %u224, i1 0, i32 0
	store i32 %u223, i32* %u225
	%u226 = load %struct.node** %temp
	%u227 = getelementptr %struct.node* %u226, i1 0, i32 1
	store %struct.node* null, %struct.node** %u227
	%u228 = load %struct.tnode** %_P_root
	%u229 = getelementptr %struct.tnode* %u228, i1 0, i32 1
	%u230 = load %struct.tnode** %u229
	%u231 = call %struct.node* @inOrder(%struct.tnode* %u230)
	%u232 = load %struct.node** %temp
	%u233 = load %struct.tnode** %_P_root
	%u234 = getelementptr %struct.tnode* %u233, i1 0, i32 2
	%u235 = load %struct.tnode** %u234
	%u236 = call %struct.node* @inOrder(%struct.tnode* %u235)
	%u237 = call %struct.node* @concatLists(%struct.node* %u232, %struct.node* %u236)
	%u238 = call %struct.node* @concatLists(%struct.node* %u231, %struct.node* %u237)
	store %struct.node* %u238, %struct.node** %_retval_
	br label %.LU67
.JN16:
	br label %.LU67
.LU71:
	store %struct.node* null, %struct.node** %_retval_
	br label %.LU67
.LU67:
	%u239 = load %struct.node** %_retval_
	ret %struct.node* %u239
}

define i32 @bintreesearch(%struct.tnode* %root, i32 %target) 
{
.LU73:
	%_retval_ = alloca i32
	%_P_root = alloca %struct.tnode*
	store %struct.tnode* %root, %struct.tnode** %_P_root
	%_P_target = alloca i32
	store i32 %target, i32* %_P_target
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 -1)
	br label %.LU74
.LU74:
	%u240 = load %struct.tnode** %_P_root
	%u241 = icmp ne %struct.tnode* %u240, null
	br i1 %u241, label %.LU75, label %.JN19
.LU75:
	%u242 = load %struct.tnode** %_P_root
	%u243 = getelementptr %struct.tnode* %u242, i1 0, i32 0
	%u244 = load i32* %u243
	%u245 = load i32* %_P_target
	%u246 = icmp eq i32 %u244, %u245
	br i1 %u246, label %.LU76, label %.JN17
.LU76:
	store i32 1, i32* %_retval_
	br label %.LU72
.JN17:
	br label %.LU77
.LU77:
	%u247 = load i32* %_P_target
	%u248 = load %struct.tnode** %_P_root
	%u249 = getelementptr %struct.tnode* %u248, i1 0, i32 0
	%u250 = load i32* %u249
	%u251 = icmp slt i32 %u247, %u250
	br i1 %u251, label %.LU78, label %.LU79
.LU78:
	%u252 = load %struct.tnode** %_P_root
	%u253 = getelementptr %struct.tnode* %u252, i1 0, i32 1
	%u254 = load %struct.tnode** %u253
	%u255 = load i32* %_P_target
	%u256 = call i32 @bintreesearch(%struct.tnode* %u254, i32 %u255)
	store i32 %u256, i32* %_retval_
	br label %.LU72
.JN18:
	br label %.JN19
.JN19:
	store i32 0, i32* %_retval_
	br label %.LU72
.LU79:
	%u257 = load %struct.tnode** %_P_root
	%u258 = getelementptr %struct.tnode* %u257, i1 0, i32 2
	%u259 = load %struct.tnode** %u258
	%u260 = load i32* %_P_target
	%u261 = call i32 @bintreesearch(%struct.tnode* %u259, i32 %u260)
	store i32 %u261, i32* %_retval_
	br label %.LU72
.LU72:
	%u262 = load i32* %_retval_
	ret i32 %u262
}

define %struct.tnode* @buildTree(%struct.node* %list) 
{
.LU81:
	%_retval_ = alloca %struct.tnode*
	%_P_list = alloca %struct.node*
	store %struct.node* %list, %struct.node** %_P_list
	%i = alloca i32
	%root = alloca %struct.tnode*
	store %struct.tnode* null, %struct.tnode** %root
	store i32 0, i32* %i
	br label %.LU82
.LU82:
	%u263 = load i32* %i
	%u264 = load %struct.node** %_P_list
	%u265 = call i32 @size(%struct.node* %u264)
	%u266 = icmp slt i32 %u263, %u265
	br i1 %u266, label %.LU83, label %.LU84
.LU83:
	%u267 = load %struct.tnode** %root
	%u268 = load %struct.node** %_P_list
	%u269 = load i32* %i
	%u270 = call i32 @get(%struct.node* %u268, i32 %u269)
	%u271 = call %struct.tnode* @treeadd(%struct.tnode* %u267, i32 %u270)
	store %struct.tnode* %u271, %struct.tnode** %root
	%u272 = load i32* %i
	%u273 = add i32 %u272, 1
	store i32 %u273, i32* %i
	%u274 = load i32* %i
	%u275 = load %struct.node** %_P_list
	%u276 = call i32 @size(%struct.node* %u275)
	%u277 = icmp slt i32 %u274, %u276
	br i1 %u277, label %.LU83, label %.LU84
.LU84:
	%u278 = load %struct.tnode** %root
	store %struct.tnode* %u278, %struct.tnode** %_retval_
	br label %.LU80
.LU80:
	%u279 = load %struct.tnode** %_retval_
	ret %struct.tnode* %u279
}

define void @treeMain(%struct.node* %list) 
{
.LU86:
	%_P_list = alloca %struct.node*
	store %struct.node* %list, %struct.node** %_P_list
	%root = alloca %struct.tnode*
	%inList = alloca %struct.node*
	%postList = alloca %struct.node*
	%u280 = load %struct.node** %_P_list
	%u281 = call %struct.tnode* @buildTree(%struct.node* %u280)
	store %struct.tnode* %u281, %struct.tnode** %root
	%u282 = load %struct.tnode** %root
	call void @treeprint(%struct.tnode* %u282)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 -999)
	%u283 = load %struct.tnode** %root
	%u284 = call %struct.node* @inOrder(%struct.tnode* %u283)
	store %struct.node* %u284, %struct.node** %inList
	%u285 = load %struct.node** %inList
	call void @printList(%struct.node* %u285)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 -999)
	%u286 = load %struct.node** %inList
	call void @freeList(%struct.node* %u286)
	%u287 = load %struct.tnode** %root
	%u288 = call %struct.node* @postOrder(%struct.tnode* %u287)
	store %struct.node* %u288, %struct.node** %postList
	%u289 = load %struct.node** %postList
	call void @printList(%struct.node* %u289)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 -999)
	%u290 = load %struct.node** %postList
	call void @freeList(%struct.node* %u290)
	%u291 = load %struct.tnode** %root
	%u292 = call i32 @treesearch(%struct.tnode* %u291, i32 0)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u292)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 -999)
	%u293 = load %struct.tnode** %root
	%u294 = call i32 @treesearch(%struct.tnode* %u293, i32 10)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u294)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 -999)
	%u295 = load %struct.tnode** %root
	%u296 = call i32 @treesearch(%struct.tnode* %u295, i32 -2)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u296)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 -999)
	%u297 = load %struct.tnode** %root
	%u298 = call i32 @treesearch(%struct.tnode* %u297, i32 2)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u298)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 -999)
	%u299 = load %struct.tnode** %root
	%u300 = call i32 @treesearch(%struct.tnode* %u299, i32 3)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u300)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 -999)
	%u301 = load %struct.tnode** %root
	%u302 = call i32 @treesearch(%struct.tnode* %u301, i32 9)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u302)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 -999)
	%u303 = load %struct.tnode** %root
	%u304 = call i32 @treesearch(%struct.tnode* %u303, i32 1)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u304)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 -999)
	%u305 = load %struct.tnode** %root
	%u306 = call i32 @bintreesearch(%struct.tnode* %u305, i32 0)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u306)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 -999)
	%u307 = load %struct.tnode** %root
	%u308 = call i32 @bintreesearch(%struct.tnode* %u307, i32 10)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u308)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 -999)
	%u309 = load %struct.tnode** %root
	%u310 = call i32 @bintreesearch(%struct.tnode* %u309, i32 -2)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u310)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 -999)
	%u311 = load %struct.tnode** %root
	%u312 = call i32 @bintreesearch(%struct.tnode* %u311, i32 2)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u312)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 -999)
	%u313 = load %struct.tnode** %root
	%u314 = call i32 @bintreesearch(%struct.tnode* %u313, i32 3)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u314)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 -999)
	%u315 = load %struct.tnode** %root
	%u316 = call i32 @bintreesearch(%struct.tnode* %u315, i32 9)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u316)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 -999)
	%u317 = load %struct.tnode** %root
	%u318 = call i32 @bintreesearch(%struct.tnode* %u317, i32 1)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u318)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 -999)
	%u319 = load %struct.tnode** %root
	call void @freeTree(%struct.tnode* %u319)
	br label %.LU85
.LU85:
	ret void
}

define %struct.node* @myCopy(%struct.node* %src) 
{
.LU88:
	%_retval_ = alloca %struct.node*
	%_P_src = alloca %struct.node*
	store %struct.node* %src, %struct.node** %_P_src
	br label %.LU89
.LU89:
	%u320 = load %struct.node** %_P_src
	%u321 = icmp eq %struct.node* %u320, null
	br i1 %u321, label %.LU90, label %.JN20
.LU90:
	store %struct.node* null, %struct.node** %_retval_
	br label %.LU87
.JN20:
	%u322 = load %struct.node** %_P_src
	%u323 = getelementptr %struct.node* %u322, i1 0, i32 0
	%u324 = load i32* %u323
	%u325 = call %struct.node* @add(%struct.node* null, i32 %u324)
	%u326 = load %struct.node** %_P_src
	%u327 = getelementptr %struct.node* %u326, i1 0, i32 1
	%u328 = load %struct.node** %u327
	%u329 = call %struct.node* @myCopy(%struct.node* %u328)
	%u330 = call %struct.node* @concatLists(%struct.node* %u325, %struct.node* %u329)
	store %struct.node* %u330, %struct.node** %_retval_
	br label %.LU87
.LU87:
	%u331 = load %struct.node** %_retval_
	ret %struct.node* %u331
}

define i32 @main() 
{
.LU92:
	%_retval_ = alloca i32
	%i = alloca i32
	%element = alloca i32
	%myList = alloca %struct.node*
	%copyList1 = alloca %struct.node*
	%copyList2 = alloca %struct.node*
	%sortedList = alloca %struct.node*
	store %struct.node* null, %struct.node** %myList
	store %struct.node* null, %struct.node** %copyList1
	store %struct.node* null, %struct.node** %copyList2
	store i32 0, i32* %i
	br label %.LU93
.LU93:
	%u332 = load i32* %i
	%u333 = icmp slt i32 %u332, 10
	br i1 %u333, label %.LU94, label %.LU95
.LU94:
	call i32 (i8*, ...)* @scanf(i8* getelementptr inbounds ([4 x i8]* @.read, i32 0, i32 0), i32* %element)
	%u334 = load %struct.node** %myList
	%u335 = load i32* %element
	%u336 = call %struct.node* @add(%struct.node* %u334, i32 %u335)
	store %struct.node* %u336, %struct.node** %myList
	%u337 = load %struct.node** %myList
	%u338 = call %struct.node* @myCopy(%struct.node* %u337)
	store %struct.node* %u338, %struct.node** %copyList1
	%u339 = load %struct.node** %myList
	%u340 = call %struct.node* @myCopy(%struct.node* %u339)
	store %struct.node* %u340, %struct.node** %copyList2
	%u341 = load %struct.node** %copyList1
	%u342 = call %struct.node* @quickSortMain(%struct.node* %u341)
	store %struct.node* %u342, %struct.node** %sortedList
	%u343 = load %struct.node** %sortedList
	call void @freeList(%struct.node* %u343)
	%u344 = load %struct.node** %copyList2
	call void @treeMain(%struct.node* %u344)
	%u345 = load i32* %i
	%u346 = add i32 %u345, 1
	store i32 %u346, i32* %i
	%u347 = load i32* %i
	%u348 = icmp slt i32 %u347, 10
	br i1 %u348, label %.LU94, label %.LU95
.LU95:
	%u349 = load %struct.node** %myList
	call void @freeList(%struct.node* %u349)
	%u350 = load %struct.node** %copyList1
	call void @freeList(%struct.node* %u350)
	%u351 = load %struct.node** %copyList2
	call void @freeList(%struct.node* %u351)
	store i32 0, i32* %_retval_
	br label %.LU91
.LU91:
	%u352 = load i32* %_retval_
	ret i32 %u352
}

declare i8* @malloc(i32)
declare void @free(i8*)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
@.println = private unnamed_addr constant [5 x i8] c"%ld\0A\00", align 1
@.print = private unnamed_addr constant [5 x i8] c"%ld \00", align 1
@.read = private unnamed_addr constant [4 x i8] c"%ld\00", align 1
@.read_scratch = common global i32 0, align 8
