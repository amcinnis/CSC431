target triple="i686"
%struct.plate = type {i32, %struct.plate*}

@peg1 = common global %struct.plate* null, align 8
@peg2 = common global %struct.plate* null, align 8
@peg3 = common global %struct.plate* null, align 8
@numMoves = common global i32 0, align 8

define void @move(i32 %from, i32 %to) 
{
.LU1:
	%_P_from = alloca i32
	store i32 %from, i32* %_P_from
	%_P_to = alloca i32
	store i32 %to, i32* %_P_to
	%plateToMove = alloca %struct.plate*
	br label %.LU2
.LU2:
	%u0 = load i32* %_P_from
	%u1 = icmp eq i32 %u0, 1
	br i1 %u1, label %.LU3, label %.LU4
.LU3:
	%u2 = load %struct.plate** @peg1
	store %struct.plate* %u2, %struct.plate** %plateToMove
	%u3 = load %struct.plate** @peg1
	%u4 = getelementptr %struct.plate* %u3, i1 0, i32 1
	%u5 = load %struct.plate** %u4
	store %struct.plate* %u5, %struct.plate** @peg1
	br label %.JN1
.JN1:
	br label %.LU7
.LU7:
	%u16 = load i32* %_P_to
	%u17 = icmp eq i32 %u16, 1
	br i1 %u17, label %.LU8, label %.LU9
.LU8:
	%u18 = load %struct.plate** @peg1
	%u19 = load %struct.plate** %plateToMove
	%u20 = getelementptr %struct.plate* %u19, i1 0, i32 1
	store %struct.plate* %u18, %struct.plate** %u20
	%u21 = load %struct.plate** %plateToMove
	store %struct.plate* %u21, %struct.plate** @peg1
	br label %.JN3
.JN3:
	%u32 = load i32* @numMoves
	%u33 = add i32 %u32, 1
	store i32 %u33, i32* @numMoves
	br label %.LU0
.LU9:
	%u22 = load i32* %_P_to
	%u23 = icmp eq i32 %u22, 2
	br i1 %u23, label %.LU10, label %.LU11
.LU10:
	%u24 = load %struct.plate** @peg2
	%u25 = load %struct.plate** %plateToMove
	%u26 = getelementptr %struct.plate* %u25, i1 0, i32 1
	store %struct.plate* %u24, %struct.plate** %u26
	%u27 = load %struct.plate** %plateToMove
	store %struct.plate* %u27, %struct.plate** @peg2
	br label %.JN2
.JN2:
	br label %.JN3
.LU11:
	%u28 = load %struct.plate** @peg3
	%u29 = load %struct.plate** %plateToMove
	%u30 = getelementptr %struct.plate* %u29, i1 0, i32 1
	store %struct.plate* %u28, %struct.plate** %u30
	%u31 = load %struct.plate** %plateToMove
	store %struct.plate* %u31, %struct.plate** @peg3
	br label %.JN2
.LU4:
	%u6 = load i32* %_P_from
	%u7 = icmp eq i32 %u6, 2
	br i1 %u7, label %.LU5, label %.LU6
.LU5:
	%u8 = load %struct.plate** @peg2
	store %struct.plate* %u8, %struct.plate** %plateToMove
	%u9 = load %struct.plate** @peg2
	%u10 = getelementptr %struct.plate* %u9, i1 0, i32 1
	%u11 = load %struct.plate** %u10
	store %struct.plate* %u11, %struct.plate** @peg2
	br label %.JN0
.JN0:
	br label %.JN1
.LU6:
	%u12 = load %struct.plate** @peg3
	store %struct.plate* %u12, %struct.plate** %plateToMove
	%u13 = load %struct.plate** @peg3
	%u14 = getelementptr %struct.plate* %u13, i1 0, i32 1
	%u15 = load %struct.plate** %u14
	store %struct.plate* %u15, %struct.plate** @peg3
	br label %.JN0
.LU0:
	ret void
}

define void @hanoi(i32 %n, i32 %from, i32 %to, i32 %other) 
{
.LU13:
	%_P_n = alloca i32
	store i32 %n, i32* %_P_n
	%_P_from = alloca i32
	store i32 %from, i32* %_P_from
	%_P_to = alloca i32
	store i32 %to, i32* %_P_to
	%_P_other = alloca i32
	store i32 %other, i32* %_P_other
	br label %.LU14
.LU14:
	%u34 = load i32* %_P_n
	%u35 = icmp eq i32 %u34, 1
	br i1 %u35, label %.LU15, label %.LU16
.LU15:
	%u36 = load i32* %_P_from
	%u37 = load i32* %_P_to
	call void @move(i32 %u36, i32 %u37)
	br label %.JN4
.JN4:
	br label %.LU12
.LU16:
	%u38 = load i32* %_P_n
	%u39 = sub i32 %u38, 1
	%u40 = load i32* %_P_from
	%u41 = load i32* %_P_other
	%u42 = load i32* %_P_to
	call void @hanoi(i32 %u39, i32 %u40, i32 %u41, i32 %u42)
	%u43 = load i32* %_P_from
	%u44 = load i32* %_P_to
	call void @move(i32 %u43, i32 %u44)
	%u45 = load i32* %_P_n
	%u46 = sub i32 %u45, 1
	%u47 = load i32* %_P_other
	%u48 = load i32* %_P_to
	%u49 = load i32* %_P_from
	call void @hanoi(i32 %u46, i32 %u47, i32 %u48, i32 %u49)
	br label %.JN4
.LU12:
	ret void
}

define void @printPeg(%struct.plate* %peg) 
{
.LU18:
	%_P_peg = alloca %struct.plate*
	store %struct.plate* %peg, %struct.plate** %_P_peg
	%aPlate = alloca %struct.plate*
	%u50 = load %struct.plate** %_P_peg
	store %struct.plate* %u50, %struct.plate** %aPlate
	br label %.LU19
.LU19:
	%u51 = load %struct.plate** %aPlate
	%u52 = icmp ne %struct.plate* %u51, null
	br i1 %u52, label %.LU20, label %.LU17
.LU20:
	%u53 = load %struct.plate** %aPlate
	%u54 = getelementptr %struct.plate* %u53, i1 0, i32 0
	%u55 = load i32* %u54
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u55)
	%u56 = load %struct.plate** %aPlate
	%u57 = getelementptr %struct.plate* %u56, i1 0, i32 1
	%u58 = load %struct.plate** %u57
	store %struct.plate* %u58, %struct.plate** %aPlate
	%u59 = load %struct.plate** %aPlate
	%u60 = icmp ne %struct.plate* %u59, null
	br i1 %u60, label %.LU20, label %.LU17
.LU17:
	ret void
}

define i32 @main() 
{
.LU22:
	%_retval_ = alloca i32
	%count = alloca i32
	%numPlates = alloca i32
	%aPlate = alloca %struct.plate*
	store %struct.plate* null, %struct.plate** @peg1
	store %struct.plate* null, %struct.plate** @peg2
	store %struct.plate* null, %struct.plate** @peg3
	store i32 0, i32* @numMoves
	call i32 (i8*, ...)* @scanf(i8* getelementptr inbounds ([4 x i8]* @.read, i32 0, i32 0), i32* %numPlates)
	br label %.LU23
.LU23:
	%u61 = load i32* %numPlates
	%u62 = icmp sge i32 %u61, 1
	br i1 %u62, label %.LU24, label %.JN5
.LU24:
	%u63 = load i32* %numPlates
	store i32 %u63, i32* %count
	br label %.LU25
.LU25:
	%u64 = load i32* %count
	%u65 = icmp ne i32 %u64, 0
	br i1 %u65, label %.LU26, label %.LU27
.LU26:
	%u66 = call i8* @malloc(i32 16)
	%u67 = bitcast i8* %u66 to %struct.plate*
	store %struct.plate* %u67, %struct.plate** %aPlate
	%u68 = load i32* %count
	%u69 = load %struct.plate** %aPlate
	%u70 = getelementptr %struct.plate* %u69, i1 0, i32 0
	store i32 %u68, i32* %u70
	%u71 = load %struct.plate** @peg1
	%u72 = load %struct.plate** %aPlate
	%u73 = getelementptr %struct.plate* %u72, i1 0, i32 1
	store %struct.plate* %u71, %struct.plate** %u73
	%u74 = load %struct.plate** %aPlate
	store %struct.plate* %u74, %struct.plate** @peg1
	%u75 = load i32* %count
	%u76 = sub i32 %u75, 1
	store i32 %u76, i32* %count
	%u77 = load i32* %count
	%u78 = icmp ne i32 %u77, 0
	br i1 %u78, label %.LU26, label %.LU27
.LU27:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	%u79 = load %struct.plate** @peg1
	call void @printPeg(%struct.plate* %u79)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 2)
	%u80 = load %struct.plate** @peg2
	call void @printPeg(%struct.plate* %u80)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 3)
	%u81 = load %struct.plate** @peg3
	call void @printPeg(%struct.plate* %u81)
	%u82 = load i32* %numPlates
	call void @hanoi(i32 %u82, i32 1, i32 3, i32 2)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	%u83 = load %struct.plate** @peg1
	call void @printPeg(%struct.plate* %u83)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 2)
	%u84 = load %struct.plate** @peg2
	call void @printPeg(%struct.plate* %u84)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 3)
	%u85 = load %struct.plate** @peg3
	call void @printPeg(%struct.plate* %u85)
	%u86 = load i32* @numMoves
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u86)
	br label %.LU28
.LU28:
	%u87 = load %struct.plate** @peg3
	%u88 = icmp ne %struct.plate* %u87, null
	br i1 %u88, label %.LU29, label %.JN5
.LU29:
	%u89 = load %struct.plate** @peg3
	store %struct.plate* %u89, %struct.plate** %aPlate
	%u90 = load %struct.plate** @peg3
	%u91 = getelementptr %struct.plate* %u90, i1 0, i32 1
	%u92 = load %struct.plate** %u91
	store %struct.plate* %u92, %struct.plate** @peg3
	%u93 = load %struct.plate** %aPlate
	%u94 = bitcast %struct.plate* %u93 to i8*
	call void @free(i8* %u94)
	%u95 = load %struct.plate** @peg3
	%u96 = icmp ne %struct.plate* %u95, null
	br i1 %u96, label %.LU29, label %.JN5
.JN5:
	store i32 0, i32* %_retval_
	br label %.LU21
.LU21:
	%u97 = load i32* %_retval_
	ret i32 %u97
}

declare i8* @malloc(i32)
declare void @free(i8*)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
@.println = private unnamed_addr constant [5 x i8] c"%ld\0A\00", align 1
@.print = private unnamed_addr constant [5 x i8] c"%ld \00", align 1
@.read = private unnamed_addr constant [4 x i8] c"%ld\00", align 1
@.read_scratch = common global i32 0, align 8
