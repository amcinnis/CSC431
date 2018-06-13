target triple="i686"
%struct.thing = type {i32, i1, %struct.thing*}

@gi1 = common global i32 0, align 8
@gb1 = common global i1 false, align 8
@gs1 = common global %struct.thing* null, align 8
@counter = common global i32 0, align 8

define void @printgroup(i32 %groupnum) 
{
.LU1:
	%_P_groupnum = alloca i32
	store i32 %groupnum, i32* %_P_groupnum
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.print, i32 0, i32 0), i32 1)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.print, i32 0, i32 0), i32 0)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.print, i32 0, i32 0), i32 1)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.print, i32 0, i32 0), i32 0)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.print, i32 0, i32 0), i32 1)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.print, i32 0, i32 0), i32 0)
	%u0 = load i32* %_P_groupnum
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u0)
	br label %.LU0
.LU0:
	ret void
}

define i1 @setcounter(i32 %val) 
{
.LU3:
	%_retval_ = alloca i1
	%_P_val = alloca i32
	store i32 %val, i32* %_P_val
	%u1 = load i32* %_P_val
	store i32 %u1, i32* @counter
	store i1 true, i1* %_retval_
	br label %.LU2
.LU2:
	%u2 = load i1* %_retval_
	ret i1 %u2
}

define void @takealltypes(i32 %i, i1 %b, %struct.thing* %s) 
{
.LU5:
	%_P_i = alloca i32
	store i32 %i, i32* %_P_i
	%_P_b = alloca i1
	store i1 %b, i1* %_P_b
	%_P_s = alloca %struct.thing*
	store %struct.thing* %s, %struct.thing** %_P_s
	br label %.LU6
.LU6:
	%u3 = load i32* %_P_i
	%u4 = icmp eq i32 %u3, 3
	br i1 %u4, label %.LU7, label %.LU8
.LU7:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN0
.JN0:
	br label %.LU9
.LU9:
	%u5 = load i1* %_P_b
	br i1 %u5, label %.LU10, label %.LU11
.LU10:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN1
.JN1:
	br label %.LU12
.LU12:
	%u6 = load %struct.thing** %_P_s
	%u7 = getelementptr %struct.thing* %u6, i1 0, i32 1
	%u8 = load i1* %u7
	br i1 %u8, label %.LU13, label %.LU14
.LU13:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN2
.JN2:
	br label %.LU4
.LU14:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %.JN2
.LU11:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %.JN1
.LU8:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %.JN0
.LU4:
	ret void
}

define void @tonofargs(i32 %a1, i32 %a2, i32 %a3, i32 %a4, i32 %a5, i32 %a6, i32 %a7, i32 %a8) 
{
.LU16:
	%_P_a1 = alloca i32
	store i32 %a1, i32* %_P_a1
	%_P_a2 = alloca i32
	store i32 %a2, i32* %_P_a2
	%_P_a3 = alloca i32
	store i32 %a3, i32* %_P_a3
	%_P_a4 = alloca i32
	store i32 %a4, i32* %_P_a4
	%_P_a5 = alloca i32
	store i32 %a5, i32* %_P_a5
	%_P_a6 = alloca i32
	store i32 %a6, i32* %_P_a6
	%_P_a7 = alloca i32
	store i32 %a7, i32* %_P_a7
	%_P_a8 = alloca i32
	store i32 %a8, i32* %_P_a8
	br label %.LU17
.LU17:
	%u9 = load i32* %_P_a5
	%u10 = icmp eq i32 %u9, 5
	br i1 %u10, label %.LU18, label %.LU19
.LU18:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN3
.JN3:
	br label %.LU20
.LU20:
	%u12 = load i32* %_P_a6
	%u13 = icmp eq i32 %u12, 6
	br i1 %u13, label %.LU21, label %.LU22
.LU21:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN4
.JN4:
	br label %.LU23
.LU23:
	%u15 = load i32* %_P_a7
	%u16 = icmp eq i32 %u15, 7
	br i1 %u16, label %.LU24, label %.LU25
.LU24:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN5
.JN5:
	br label %.LU26
.LU26:
	%u18 = load i32* %_P_a8
	%u19 = icmp eq i32 %u18, 8
	br i1 %u19, label %.LU27, label %.LU28
.LU27:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN6
.JN6:
	br label %.LU15
.LU28:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.print, i32 0, i32 0), i32 0)
	%u20 = load i32* %_P_a8
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u20)
	br label %.JN6
.LU25:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.print, i32 0, i32 0), i32 0)
	%u17 = load i32* %_P_a7
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u17)
	br label %.JN5
.LU22:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.print, i32 0, i32 0), i32 0)
	%u14 = load i32* %_P_a6
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u14)
	br label %.JN4
.LU19:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.print, i32 0, i32 0), i32 0)
	%u11 = load i32* %_P_a5
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u11)
	br label %.JN3
.LU15:
	ret void
}

define i32 @returnint(i32 %ret) 
{
.LU30:
	%_retval_ = alloca i32
	%_P_ret = alloca i32
	store i32 %ret, i32* %_P_ret
	%u21 = load i32* %_P_ret
	store i32 %u21, i32* %_retval_
	br label %.LU29
.LU29:
	%u22 = load i32* %_retval_
	ret i32 %u22
}

define i1 @returnbool(i1 %ret) 
{
.LU32:
	%_retval_ = alloca i1
	%_P_ret = alloca i1
	store i1 %ret, i1* %_P_ret
	%u23 = load i1* %_P_ret
	store i1 %u23, i1* %_retval_
	br label %.LU31
.LU31:
	%u24 = load i1* %_retval_
	ret i1 %u24
}

define %struct.thing* @returnstruct(%struct.thing* %ret) 
{
.LU34:
	%_retval_ = alloca %struct.thing*
	%_P_ret = alloca %struct.thing*
	store %struct.thing* %ret, %struct.thing** %_P_ret
	%u25 = load %struct.thing** %_P_ret
	store %struct.thing* %u25, %struct.thing** %_retval_
	br label %.LU33
.LU33:
	%u26 = load %struct.thing** %_retval_
	ret %struct.thing* %u26
}

define i32 @main() 
{
.LU36:
	%_retval_ = alloca i32
	%b1 = alloca i1
	%b2 = alloca i1
	%i1 = alloca i32
	%i2 = alloca i32
	%i3 = alloca i32
	%s1 = alloca %struct.thing*
	%s2 = alloca %struct.thing*
	store i32 0, i32* @counter
	call void @printgroup(i32 1)
	store i1 false, i1* %b1
	store i1 false, i1* %b2
	br label %.LU37
.LU37:
	%u27 = load i1* %b1
	%u28 = load i1* %b2
	%u29 = and i1 %u27, %u28
	br i1 %u29, label %.LU38, label %.LU39
.LU38:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %.JN7
.JN7:
	store i1 true, i1* %b1
	store i1 false, i1* %b2
	br label %.LU40
.LU40:
	%u30 = load i1* %b1
	%u31 = load i1* %b2
	%u32 = and i1 %u30, %u31
	br i1 %u32, label %.LU41, label %.LU42
.LU41:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %.JN8
.JN8:
	store i1 false, i1* %b1
	store i1 true, i1* %b2
	br label %.LU43
.LU43:
	%u33 = load i1* %b1
	%u34 = load i1* %b2
	%u35 = and i1 %u33, %u34
	br i1 %u35, label %.LU44, label %.LU45
.LU44:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %.JN9
.JN9:
	store i1 true, i1* %b1
	store i1 true, i1* %b2
	br label %.LU46
.LU46:
	%u36 = load i1* %b1
	%u37 = load i1* %b2
	%u38 = and i1 %u36, %u37
	br i1 %u38, label %.LU47, label %.LU48
.LU47:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN10
.JN10:
	store i32 0, i32* @counter
	call void @printgroup(i32 2)
	store i1 true, i1* %b1
	store i1 true, i1* %b2
	br label %.LU49
.LU49:
	%u39 = load i1* %b1
	%u40 = load i1* %b2
	%u41 = or i1 %u39, %u40
	br i1 %u41, label %.LU50, label %.LU51
.LU50:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN11
.JN11:
	store i1 true, i1* %b1
	store i1 false, i1* %b2
	br label %.LU52
.LU52:
	%u42 = load i1* %b1
	%u43 = load i1* %b2
	%u44 = or i1 %u42, %u43
	br i1 %u44, label %.LU53, label %.LU54
.LU53:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN12
.JN12:
	store i1 false, i1* %b1
	store i1 true, i1* %b2
	br label %.LU55
.LU55:
	%u45 = load i1* %b1
	%u46 = load i1* %b2
	%u47 = or i1 %u45, %u46
	br i1 %u47, label %.LU56, label %.LU57
.LU56:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN13
.JN13:
	store i1 false, i1* %b1
	store i1 false, i1* %b2
	br label %.LU58
.LU58:
	%u48 = load i1* %b1
	%u49 = load i1* %b2
	%u50 = or i1 %u48, %u49
	br i1 %u50, label %.LU59, label %.LU60
.LU59:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %.JN14
.JN14:
	call void @printgroup(i32 3)
	br label %.LU61
.LU61:
	%u51 = icmp sgt i32 42, 1
	br i1 %u51, label %.LU62, label %.LU63
.LU62:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN15
.JN15:
	br label %.LU64
.LU64:
	%u52 = icmp sge i32 42, 1
	br i1 %u52, label %.LU65, label %.LU66
.LU65:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN16
.JN16:
	br label %.LU67
.LU67:
	%u53 = icmp slt i32 42, 1
	br i1 %u53, label %.LU68, label %.LU69
.LU68:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %.JN17
.JN17:
	br label %.LU70
.LU70:
	%u54 = icmp sle i32 42, 1
	br i1 %u54, label %.LU71, label %.LU72
.LU71:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %.JN18
.JN18:
	br label %.LU73
.LU73:
	%u55 = icmp eq i32 42, 1
	br i1 %u55, label %.LU74, label %.LU75
.LU74:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %.JN19
.JN19:
	br label %.LU76
.LU76:
	%u56 = icmp ne i32 42, 1
	br i1 %u56, label %.LU77, label %.LU78
.LU77:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN20
.JN20:
	br label %.LU79
.LU79:
	br label %.LU80
.LU80:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN21
.JN21:
	br label %.LU82
.LU82:
	br label %.LU84
.LU83:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %.JN22
.JN22:
	br label %.LU85
.LU85:
	br label %.LU87
.LU86:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %.JN23
.JN23:
	br label %.LU88
.LU88:
	br label %.LU89
.LU89:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN24
.JN24:
	br label %.LU91
.LU91:
	br label %.LU92
.LU92:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN25
.JN25:
	call void @printgroup(i32 4)
	br label %.LU94
.LU94:
	%u57 = add i32 2, 3
	%u58 = icmp eq i32 %u57, 5
	br i1 %u58, label %.LU95, label %.LU96
.LU95:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN26
.JN26:
	br label %.LU97
.LU97:
	%u60 = mul i32 2, 3
	%u61 = icmp eq i32 %u60, 6
	br i1 %u61, label %.LU98, label %.LU99
.LU98:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN27
.JN27:
	br label %.LU100
.LU100:
	%u63 = sub i32 3, 2
	%u64 = icmp eq i32 %u63, 1
	br i1 %u64, label %.LU101, label %.LU102
.LU101:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN28
.JN28:
	br label %.LU103
.LU103:
	%u66 = sdiv i32 6, 3
	%u67 = icmp eq i32 %u66, 2
	br i1 %u67, label %.LU104, label %.LU105
.LU104:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN29
.JN29:
	br label %.LU106
.LU106:
	%u69 = icmp slt i32 -6, 0
	br i1 %u69, label %.LU107, label %.LU108
.LU107:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN30
.JN30:
	call void @printgroup(i32 5)
	store i32 42, i32* %i1
	br label %.LU109
.LU109:
	%u70 = load i32* %i1
	%u71 = icmp eq i32 %u70, 42
	br i1 %u71, label %.LU110, label %.LU111
.LU110:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN31
.JN31:
	store i32 3, i32* %i1
	store i32 2, i32* %i2
	%u72 = load i32* %i1
	%u73 = load i32* %i2
	%u74 = add i32 %u72, %u73
	store i32 %u74, i32* %i3
	br label %.LU112
.LU112:
	%u75 = load i32* %i3
	%u76 = icmp eq i32 %u75, 5
	br i1 %u76, label %.LU113, label %.LU114
.LU113:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN32
.JN32:
	store i1 true, i1* %b1
	br label %.LU115
.LU115:
	%u77 = load i1* %b1
	br i1 %u77, label %.LU116, label %.LU117
.LU116:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN33
.JN33:
	br label %.LU118
.LU118:
	%u78 = load i1* %b1
	%u79 = xor i1 %u78, 1
	br i1 %u79, label %.LU119, label %.LU120
.LU119:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %.JN34
.JN34:
	store i1 false, i1* %b1
	br label %.LU121
.LU121:
	%u80 = load i1* %b1
	br i1 %u80, label %.LU122, label %.LU123
.LU122:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %.JN35
.JN35:
	br label %.LU124
.LU124:
	%u81 = load i1* %b1
	%u82 = xor i1 %u81, 1
	br i1 %u82, label %.LU125, label %.LU126
.LU125:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN36
.JN36:
	br label %.LU127
.LU127:
	%u83 = load i1* %b1
	br i1 %u83, label %.LU128, label %.LU129
.LU128:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %.JN37
.JN37:
	call void @printgroup(i32 6)
	store i32 0, i32* %i1
	br label %.LU130
.LU130:
	%u84 = load i32* %i1
	%u85 = icmp slt i32 %u84, 5
	br i1 %u85, label %.LU131, label %.LU133
.LU131:
	%u86 = load i32* %i1
	%u87 = icmp sge i32 %u86, 5
	br i1 %u87, label %.LU132, label %.JN38
.LU132:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %.JN38
.JN38:
	%u88 = load i32* %i1
	%u89 = add i32 %u88, 5
	store i32 %u89, i32* %i1
	%u90 = load i32* %i1
	%u91 = icmp slt i32 %u90, 5
	br i1 %u91, label %.LU131, label %.LU133
.LU133:
	%u92 = load i32* %i1
	%u93 = icmp eq i32 %u92, 5
	br i1 %u93, label %.LU134, label %.LU135
.LU134:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN39
.JN39:
	call void @printgroup(i32 7)
	%u95 = call i8* @malloc(i32 24)
	%u96 = bitcast i8* %u95 to %struct.thing*
	store %struct.thing* %u96, %struct.thing** %s1
	%u97 = load %struct.thing** %s1
	%u98 = getelementptr %struct.thing* %u97, i1 0, i32 0
	store i32 42, i32* %u98
	%u99 = load %struct.thing** %s1
	%u100 = getelementptr %struct.thing* %u99, i1 0, i32 1
	store i1 true, i1* %u100
	br label %.LU136
.LU136:
	%u101 = load %struct.thing** %s1
	%u102 = getelementptr %struct.thing* %u101, i1 0, i32 0
	%u103 = load i32* %u102
	%u104 = icmp eq i32 %u103, 42
	br i1 %u104, label %.LU137, label %.LU138
.LU137:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN40
.JN40:
	br label %.LU139
.LU139:
	%u108 = load %struct.thing** %s1
	%u109 = getelementptr %struct.thing* %u108, i1 0, i32 1
	%u110 = load i1* %u109
	br i1 %u110, label %.LU140, label %.LU141
.LU140:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN41
.JN41:
	%u111 = call i8* @malloc(i32 24)
	%u112 = bitcast i8* %u111 to %struct.thing*
	%u113 = load %struct.thing** %s1
	%u114 = getelementptr %struct.thing* %u113, i1 0, i32 2
	store %struct.thing* %u112, %struct.thing** %u114
	%u115 = load %struct.thing** %s1
	%u116 = getelementptr %struct.thing* %u115, i1 0, i32 2
	%u117 = load %struct.thing** %u116
	%u118 = getelementptr %struct.thing* %u117, i1 0, i32 0
	store i32 13, i32* %u118
	%u119 = load %struct.thing** %s1
	%u120 = getelementptr %struct.thing* %u119, i1 0, i32 2
	%u121 = load %struct.thing** %u120
	%u122 = getelementptr %struct.thing* %u121, i1 0, i32 1
	store i1 false, i1* %u122
	br label %.LU142
.LU142:
	%u123 = load %struct.thing** %s1
	%u124 = getelementptr %struct.thing* %u123, i1 0, i32 2
	%u125 = load %struct.thing** %u124
	%u126 = getelementptr %struct.thing* %u125, i1 0, i32 0
	%u127 = load i32* %u126
	%u128 = icmp eq i32 %u127, 13
	br i1 %u128, label %.LU143, label %.LU144
.LU143:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN42
.JN42:
	br label %.LU145
.LU145:
	%u134 = load %struct.thing** %s1
	%u135 = getelementptr %struct.thing* %u134, i1 0, i32 2
	%u136 = load %struct.thing** %u135
	%u137 = getelementptr %struct.thing* %u136, i1 0, i32 1
	%u138 = load i1* %u137
	%u139 = xor i1 %u138, 1
	br i1 %u139, label %.LU146, label %.LU147
.LU146:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN43
.JN43:
	br label %.LU148
.LU148:
	%u140 = load %struct.thing** %s1
	%u141 = load %struct.thing** %s1
	%u142 = icmp eq %struct.thing* %u140, %u141
	br i1 %u142, label %.LU149, label %.LU150
.LU149:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN44
.JN44:
	br label %.LU151
.LU151:
	%u143 = load %struct.thing** %s1
	%u144 = load %struct.thing** %s1
	%u145 = getelementptr %struct.thing* %u144, i1 0, i32 2
	%u146 = load %struct.thing** %u145
	%u147 = icmp ne %struct.thing* %u143, %u146
	br i1 %u147, label %.LU152, label %.LU153
.LU152:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN45
.JN45:
	%u148 = load %struct.thing** %s1
	%u149 = getelementptr %struct.thing* %u148, i1 0, i32 2
	%u150 = load %struct.thing** %u149
	%u151 = bitcast %struct.thing* %u150 to i8*
	call void @free(i8* %u151)
	%u152 = load %struct.thing** %s1
	%u153 = bitcast %struct.thing* %u152 to i8*
	call void @free(i8* %u153)
	call void @printgroup(i32 8)
	store i32 7, i32* @gi1
	br label %.LU154
.LU154:
	%u154 = load i32* @gi1
	%u155 = icmp eq i32 %u154, 7
	br i1 %u155, label %.LU155, label %.LU156
.LU155:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN46
.JN46:
	store i1 true, i1* @gb1
	br label %.LU157
.LU157:
	%u157 = load i1* @gb1
	br i1 %u157, label %.LU158, label %.LU159
.LU158:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN47
.JN47:
	%u158 = call i8* @malloc(i32 24)
	%u159 = bitcast i8* %u158 to %struct.thing*
	store %struct.thing* %u159, %struct.thing** @gs1
	%u160 = load %struct.thing** @gs1
	%u161 = getelementptr %struct.thing* %u160, i1 0, i32 0
	store i32 34, i32* %u161
	%u162 = load %struct.thing** @gs1
	%u163 = getelementptr %struct.thing* %u162, i1 0, i32 1
	store i1 false, i1* %u163
	br label %.LU160
.LU160:
	%u164 = load %struct.thing** @gs1
	%u165 = getelementptr %struct.thing* %u164, i1 0, i32 0
	%u166 = load i32* %u165
	%u167 = icmp eq i32 %u166, 34
	br i1 %u167, label %.LU161, label %.LU162
.LU161:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN48
.JN48:
	br label %.LU163
.LU163:
	%u171 = load %struct.thing** @gs1
	%u172 = getelementptr %struct.thing* %u171, i1 0, i32 1
	%u173 = load i1* %u172
	%u174 = xor i1 %u173, 1
	br i1 %u174, label %.LU164, label %.LU165
.LU164:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN49
.JN49:
	%u175 = call i8* @malloc(i32 24)
	%u176 = bitcast i8* %u175 to %struct.thing*
	%u177 = load %struct.thing** @gs1
	%u178 = getelementptr %struct.thing* %u177, i1 0, i32 2
	store %struct.thing* %u176, %struct.thing** %u178
	%u179 = load %struct.thing** @gs1
	%u180 = getelementptr %struct.thing* %u179, i1 0, i32 2
	%u181 = load %struct.thing** %u180
	%u182 = getelementptr %struct.thing* %u181, i1 0, i32 0
	store i32 16, i32* %u182
	%u183 = load %struct.thing** @gs1
	%u184 = getelementptr %struct.thing* %u183, i1 0, i32 2
	%u185 = load %struct.thing** %u184
	%u186 = getelementptr %struct.thing* %u185, i1 0, i32 1
	store i1 true, i1* %u186
	br label %.LU166
.LU166:
	%u187 = load %struct.thing** @gs1
	%u188 = getelementptr %struct.thing* %u187, i1 0, i32 2
	%u189 = load %struct.thing** %u188
	%u190 = getelementptr %struct.thing* %u189, i1 0, i32 0
	%u191 = load i32* %u190
	%u192 = icmp eq i32 %u191, 16
	br i1 %u192, label %.LU167, label %.LU168
.LU167:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN50
.JN50:
	br label %.LU169
.LU169:
	%u198 = load %struct.thing** @gs1
	%u199 = getelementptr %struct.thing* %u198, i1 0, i32 2
	%u200 = load %struct.thing** %u199
	%u201 = getelementptr %struct.thing* %u200, i1 0, i32 1
	%u202 = load i1* %u201
	br i1 %u202, label %.LU170, label %.LU171
.LU170:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN51
.JN51:
	%u203 = load %struct.thing** @gs1
	%u204 = getelementptr %struct.thing* %u203, i1 0, i32 2
	%u205 = load %struct.thing** %u204
	%u206 = bitcast %struct.thing* %u205 to i8*
	call void @free(i8* %u206)
	%u207 = load %struct.thing** @gs1
	%u208 = bitcast %struct.thing* %u207 to i8*
	call void @free(i8* %u208)
	call void @printgroup(i32 9)
	%u209 = call i8* @malloc(i32 24)
	%u210 = bitcast i8* %u209 to %struct.thing*
	store %struct.thing* %u210, %struct.thing** %s1
	%u211 = load %struct.thing** %s1
	%u212 = getelementptr %struct.thing* %u211, i1 0, i32 1
	store i1 true, i1* %u212
	%u213 = load %struct.thing** %s1
	call void @takealltypes(i32 3, i1 true, %struct.thing* %u213)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 2)
	call void @tonofargs(i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8)
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 3)
	%u214 = call i32 @returnint(i32 3)
	store i32 %u214, i32* %i1
	br label %.LU172
.LU172:
	%u215 = load i32* %i1
	%u216 = icmp eq i32 %u215, 3
	br i1 %u216, label %.LU173, label %.LU174
.LU173:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN52
.JN52:
	%u218 = call i1 @returnbool(i1 true)
	store i1 %u218, i1* %b1
	br label %.LU175
.LU175:
	%u219 = load i1* %b1
	br i1 %u219, label %.LU176, label %.LU177
.LU176:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN53
.JN53:
	%u220 = call i8* @malloc(i32 24)
	%u221 = bitcast i8* %u220 to %struct.thing*
	store %struct.thing* %u221, %struct.thing** %s1
	%u222 = load %struct.thing** %s1
	%u223 = call %struct.thing* @returnstruct(%struct.thing* %u222)
	store %struct.thing* %u223, %struct.thing** %s2
	br label %.LU178
.LU178:
	%u224 = load %struct.thing** %s1
	%u225 = load %struct.thing** %s2
	%u226 = icmp eq %struct.thing* %u224, %u225
	br i1 %u226, label %.LU179, label %.LU180
.LU179:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN54
.JN54:
	call void @printgroup(i32 10)
	store i32 0, i32* %_retval_
	br label %.LU35
.LU180:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %.JN54
.LU177:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %.JN53
.LU174:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.print, i32 0, i32 0), i32 0)
	%u217 = load i32* %i1
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u217)
	br label %.JN52
.LU171:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %.JN51
.LU168:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.print, i32 0, i32 0), i32 0)
	%u193 = load %struct.thing** @gs1
	%u194 = getelementptr %struct.thing* %u193, i1 0, i32 2
	%u195 = load %struct.thing** %u194
	%u196 = getelementptr %struct.thing* %u195, i1 0, i32 0
	%u197 = load i32* %u196
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u197)
	br label %.JN50
.LU165:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %.JN49
.LU162:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.print, i32 0, i32 0), i32 0)
	%u168 = load %struct.thing** @gs1
	%u169 = getelementptr %struct.thing* %u168, i1 0, i32 0
	%u170 = load i32* %u169
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u170)
	br label %.JN48
.LU159:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %.JN47
.LU156:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.print, i32 0, i32 0), i32 0)
	%u156 = load i32* @gi1
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u156)
	br label %.JN46
.LU153:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %.JN45
.LU150:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %.JN44
.LU147:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %.JN43
.LU144:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.print, i32 0, i32 0), i32 0)
	%u129 = load %struct.thing** %s1
	%u130 = getelementptr %struct.thing* %u129, i1 0, i32 2
	%u131 = load %struct.thing** %u130
	%u132 = getelementptr %struct.thing* %u131, i1 0, i32 0
	%u133 = load i32* %u132
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u133)
	br label %.JN42
.LU141:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %.JN41
.LU138:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.print, i32 0, i32 0), i32 0)
	%u105 = load %struct.thing** %s1
	%u106 = getelementptr %struct.thing* %u105, i1 0, i32 0
	%u107 = load i32* %u106
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u107)
	br label %.JN40
.LU135:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.print, i32 0, i32 0), i32 0)
	%u94 = load i32* %i1
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u94)
	br label %.JN39
.LU129:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN37
.LU126:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %.JN36
.LU123:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN35
.LU120:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN34
.LU117:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %.JN33
.LU114:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %.JN32
.LU111:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %.JN31
.LU108:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %.JN30
.LU105:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.print, i32 0, i32 0), i32 0)
	%u68 = sdiv i32 6, 3
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u68)
	br label %.JN29
.LU102:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.print, i32 0, i32 0), i32 0)
	%u65 = sub i32 3, 2
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u65)
	br label %.JN28
.LU99:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.print, i32 0, i32 0), i32 0)
	%u62 = mul i32 2, 3
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u62)
	br label %.JN27
.LU96:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.print, i32 0, i32 0), i32 0)
	%u59 = add i32 2, 3
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 %u59)
	br label %.JN26
.LU93:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %.JN25
.LU90:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %.JN24
.LU87:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN23
.LU84:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN22
.LU81:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %.JN21
.LU78:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %.JN20
.LU75:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN19
.LU72:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN18
.LU69:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN17
.LU66:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %.JN16
.LU63:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %.JN15
.LU60:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN14
.LU57:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %.JN13
.LU54:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %.JN12
.LU51:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %.JN11
.LU48:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 0)
	br label %.JN10
.LU45:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN9
.LU42:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN8
.LU39:
	call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.println, i32 0, i32 0), i32 1)
	br label %.JN7
.LU35:
	%u227 = load i32* %_retval_
	ret i32 %u227
}

declare i8* @malloc(i32)
declare void @free(i8*)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
@.println = private unnamed_addr constant [5 x i8] c"%ld\0A\00", align 1
@.print = private unnamed_addr constant [5 x i8] c"%ld \00", align 1
@.read = private unnamed_addr constant [4 x i8] c"%ld\00", align 1
@.read_scratch = common global i32 0, align 8
