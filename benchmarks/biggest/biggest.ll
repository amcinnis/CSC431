target triple="i686"
%struct.IntList = type {i32, %struct.IntList*}


define %struct.IntList* @getIntList() 
{
.LU1:
	%_retval_ = alloca %struct.IntList*
	%list = alloca %struct.IntList*
	%next = alloca i32
	%u0 = call i8* @malloc(i32 16)
	%u1 = bitcast i8* %u0 to %struct.IntList*
	store %struct.IntList* %u1, %struct.IntList** %list
	call i32 (i8*, ...)* @scanf(i8* getelementptr inbounds ([4 x i8]* @.read, i32 0, i32 0), i32* %next)
	br label %.LU2
.LU2:
	%u2 = load i32* %next
	%u3 = icmp eq i32 %u2, -1
	br i1 %u3, label %.LU3, label %.LU4
.LU3:
	%u4 = load i32* %next
	%u5 = load %struct.IntList** %list
	%u6 = getelementptr %struct.IntList* %u5, i1 0, i32 0
	store i32 %u4, i32* %u6
	%u7 = load %struct.IntList** %list
	%u8 = getelementptr %struct.IntList* %u7, i1 0, i32 1
	store %struct.IntList* null, %struct.IntList** %u8
	%u9 = load %struct.IntList** %list
	store %struct.IntList* %u9, %struct.IntList** %_retval_
	br label %.LU0
.LU4:
	%u10 = load i32* %next
	%u11 = load %struct.IntList** %list
	%u12 = getelementptr %struct.IntList* %u11, i1 0, i32 0
	store i32 %u10, i32* %u12
	%u13 = call %struct.IntList* @getIntList()
	%u14 = load %struct.IntList** %list
	%u15 = getelementptr %struct.IntList* %u14, i1 0, i32 1
	store %struct.IntList* %u13, %struct.IntList** %u15
	%u16 = load %struct.IntList** %list
	store %struct.IntList* %u16, %struct.IntList** %_retval_
	br label %.LU0
.LU0:
	%u17 = load %struct.IntList** %_retval_
	ret %struct.IntList* %u17
}

define i32 @biggest(i32 %num1, i32 %num2) 
{
.LU6:
	%_retval_ = alloca i32
	%_P_num1 = alloca i32
	store i32 %num1, i32* %_P_num1
	%_P_num2 = alloca i32
	store i32 %num2, i32* %_P_num2
	br label %.LU7
.LU7:
	%u18 = load i32* %_P_num1
	%u19 = load i32* %_P_num2
	%u20 = icmp sgt i32 %u18, %u19
	br i1 %u20, label %.LU8, label %.LU9
.LU8:
	%u21 = load i32* %_P_num1
	store i32 %u21, i32* %_retval_
	br label %.LU5
.LU9:
	%u22 = load i32* %_P_num2
	store i32 %u22, i32* %_retval_
	br label %.LU5
.LU5:
	%u23 = load i32* %_retval_
	ret i32 %u23
}

define i32 @biggestInList(%struct.IntList* %list) 
{
.LU11:
	%_retval_ = alloca i32
	%_P_list = alloca %struct.IntList*
	store %struct.IntList* %list, %struct.IntList** %_P_list
	%big = alloca i32
	%u24 = load %struct.IntList** %_P_list
	%u25 = getelementptr %struct.IntList* %u24, i1 0, i32 0
	%u26 = load i32* %u25
	store i32 %u26, i32* %big
	br label %.LU12
.LU12:
	%u27 = load %struct.IntList** %_P_list
	%u28 = getelementptr %struct.IntList* %u27, i1 0, i32 1
	%u29 = load %struct.IntList** %u28
	%u30 = icmp ne %struct.IntList* %u29, null
	br i1 %u30, label %.LU13, label %.LU14
.LU13:
	%u31 = load i32* %big
	%u32 = load %struct.IntList** %_P_list
	%u33 = getelementptr %struct.IntList* %u32, i1 0, i32 0
	%u34 = load i32* %u33
	%u35 = call i32 @biggest(i32 %u31, i32 %u34)
	store i32 %u35, i32* %big
	%u36 = load %struct.IntList** %_P_list
	%u37 = getelementptr %struct.IntList* %u36, i1 0, i32 1
	%u38 = load %struct.IntList** %u37
	store %struct.IntList* %u38, %struct.IntList** %_P_list
	%u39 = load %struct.IntList** %_P_list
	%u40 = getelementptr %struct.IntList* %u39, i1 0, i32 1
	%u41 = load %struct.IntList** %u40
	%u42 = icmp ne %struct.IntList* %u41, null
	br i1 %u42, label %.LU13, label %.LU14
.LU14:
	%u43 = load i32* %big
	store i32 %u43, i32* %_retval_
	br label %.LU10
.LU10:
	%u44 = load i32* %_retval_
	ret i32 %u44
}

define i32 @main() 
{
.LU16:
	%_retval_ = alloca i32
	%list = alloca %struct.IntList*
	%u45 = call %struct.IntList* @getIntList()
	store %struct.IntList* %u45, %struct.IntList** %list
	%u46 = load %struct.IntList** %list
	%u47 = call i32 @biggestInList(%struct.IntList* %u46)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u47)
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

