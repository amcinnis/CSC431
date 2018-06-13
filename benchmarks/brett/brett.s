	.arch armv7-a
	.comm	gi1,4,4
	.comm	gb1,4,4
	.comm	gs1,4,4
	.comm	counter,4,4
	.text

	.align 2
	.global printgroup
printgroup:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #4
	str r0, [fp, #-8]
	mov r1, r4
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	mov r1, r10
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	mov r1, r4
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	mov r1, r10
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	mov r1, r4
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	mov r1, r10
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	ldr r10, [fp, #-8]
	mov r1, r10
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU0
.LU0:
	add sp, sp, #4
	pop {r4-r10, fp, pc}
	.size printgroup, .-printgroup
	.align 2
	.global setcounter
setcounter:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #8
	str r10, [fp, #-8]
	ldr r5, [fp, #-8]
	str r5, [r4]
	str r4, [fp, #-12]
	b .LU2
.LU2:
	ldr r10, [fp, #-12]
	mov r0, r10
	add sp, sp, #8
	pop {r4-r10, fp, pc}
	.size setcounter, .-setcounter
	.align 2
	.global takealltypes
takealltypes:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #12
	str r0, [fp, #-8]
	str r1, [fp, #-12]
	str r2, [fp, #-16]
	b .LU6
.LU6:
	ldr r6, [fp, #-8]
	mov r5, #0
	cmp r6, #3
	moveq r5, #1
	cmp r5, #1
	beq .LU7
	b .LU8
.LU7:
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN0
.JN0:
	b .LU9
.LU9:
	ldr r10, [fp, #-12]
	cmp r10, #1
	beq .LU10
	b .LU11
.LU10:
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN1
.JN1:
	b .LU12
.LU12:
	ldr r10, [fp, #-16]
	add r5, r10, #4
	ldr r5, [r5]
	cmp r5, #1
	beq .LU13
	b .LU14
.LU13:
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN2
.JN2:
	b .LU4
.LU14:
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN2
.LU11:
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN1
.LU8:
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN0
.LU4:
	add sp, sp, #12
	pop {r4-r10, fp, pc}
	.size takealltypes, .-takealltypes
	.align 2
	.global tonofargs
tonofargs:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	push {r4, r5, r6, r7}
	sub sp, sp, #32
	str r0, [fp, #-8]
	str r1, [fp, #-12]
	str r2, [fp, #-16]
	str r3, [fp, #-20]
	str r4, [fp, #-24]
	str r5, [fp, #-28]
	str r6, [fp, #-32]
	str r7, [fp, #-36]
	b .LU17
.LU17:
	ldr r6, [fp, #-24]
	mov r5, #0
	cmp r6, #5
	moveq r5, #1
	cmp r5, #1
	beq .LU18
	b .LU19
.LU18:
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN3
.JN3:
	b .LU20
.LU20:
	ldr r5, [fp, #-28]
	mov r6, #0
	cmp r5, #6
	moveq r6, #1
	cmp r6, #1
	beq .LU21
	b .LU22
.LU21:
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN4
.JN4:
	b .LU23
.LU23:
	ldr r6, [fp, #-32]
	mov r5, #0
	cmp r6, #7
	moveq r5, #1
	cmp r5, #1
	beq .LU24
	b .LU25
.LU24:
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN5
.JN5:
	b .LU26
.LU26:
	ldr r6, [fp, #-36]
	mov r5, #0
	cmp r6, #8
	moveq r5, #1
	cmp r5, #1
	beq .LU27
	b .LU28
.LU27:
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN6
.JN6:
	b .LU15
.LU28:
	mov r1, r4
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	ldr r10, [fp, #-36]
	mov r1, r10
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN6
.LU25:
	mov r1, r4
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	ldr r5, [fp, #-32]
	mov r1, r5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN5
.LU22:
	mov r1, r4
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	ldr r10, [fp, #-28]
	mov r1, r10
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN4
.LU19:
	mov r1, r4
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	ldr r5, [fp, #-24]
	mov r1, r5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN3
.LU15:
	pop {r4, r5, r6, r7}
	add sp, sp, #32
	pop {r4-r10, fp, pc}
	.size tonofargs, .-tonofargs
	.align 2
	.global returnint
returnint:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #8
	str r0, [fp, #-8]
	ldr r10, [fp, #-8]
	str r10, [fp, #-12]
	b .LU29
.LU29:
	ldr r10, [fp, #-12]
	mov r0, r10
	add sp, sp, #8
	pop {r4-r10, fp, pc}
	.size returnint, .-returnint
	.align 2
	.global returnbool
returnbool:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #8
	str r0, [fp, #-8]
	ldr r10, [fp, #-8]
	str r10, [fp, #-12]
	b .LU31
.LU31:
	ldr r10, [fp, #-12]
	mov r0, r10
	add sp, sp, #8
	pop {r4-r10, fp, pc}
	.size returnbool, .-returnbool
	.align 2
	.global returnstruct
returnstruct:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #8
	str r0, [fp, #-8]
	ldr r10, [fp, #-8]
	str r10, [fp, #-12]
	b .LU33
.LU33:
	ldr r10, [fp, #-12]
	mov r0, r10
	add sp, sp, #8
	pop {r4-r10, fp, pc}
	.size returnstruct, .-returnstruct
	.align 2
	.global main
main:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #32
	mov r4, #0
	str r4, [r6]
	mov r0, #1
	bl printgroup
	str r7, [fp, #-12]
	str r7, [fp, #-16]
	b .LU37
.LU37:
	ldr r4, [fp, #-12]
	ldr r5, [fp, #-16]
	and r4, r4, r5
	cmp r4, #1
	beq .LU38
	b .LU39
.LU38:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN7
.JN7:
	str r7, [fp, #-12]
	str r7, [fp, #-16]
	b .LU40
.LU40:
	ldr r4, [fp, #-12]
	ldr r5, [fp, #-16]
	and r4, r4, r5
	cmp r4, #1
	beq .LU41
	b .LU42
.LU41:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN8
.JN8:
	str r7, [fp, #-12]
	str r7, [fp, #-16]
	b .LU43
.LU43:
	ldr r5, [fp, #-12]
	ldr r4, [fp, #-16]
	and r4, r5, r4
	cmp r4, #1
	beq .LU44
	b .LU45
.LU44:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN9
.JN9:
	str r7, [fp, #-12]
	str r7, [fp, #-16]
	b .LU46
.LU46:
	ldr r5, [fp, #-12]
	ldr r4, [fp, #-16]
	and r4, r5, r4
	cmp r4, #1
	beq .LU47
	b .LU48
.LU47:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN10
.JN10:
	mov r4, #0
	str r4, [r6]
	mov r0, #2
	bl printgroup
	str r7, [fp, #-12]
	str r7, [fp, #-16]
	b .LU49
.LU49:
	ldr r5, [fp, #-12]
	ldr r4, [fp, #-16]
	orr r4, r5, r4
	cmp r4, #1
	beq .LU50
	b .LU51
.LU50:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN11
.JN11:
	str r7, [fp, #-12]
	str r7, [fp, #-16]
	b .LU52
.LU52:
	ldr r5, [fp, #-12]
	ldr r4, [fp, #-16]
	orr r4, r5, r4
	cmp r4, #1
	beq .LU53
	b .LU54
.LU53:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN12
.JN12:
	str r7, [fp, #-12]
	str r7, [fp, #-16]
	b .LU55
.LU55:
	ldr r4, [fp, #-12]
	ldr r5, [fp, #-16]
	orr r4, r4, r5
	cmp r4, #1
	beq .LU56
	b .LU57
.LU56:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN13
.JN13:
	str r7, [fp, #-12]
	str r7, [fp, #-16]
	b .LU58
.LU58:
	ldr r5, [fp, #-12]
	ldr r4, [fp, #-16]
	orr r4, r5, r4
	cmp r4, #1
	beq .LU59
	b .LU60
.LU59:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN14
.JN14:
	mov r0, #3
	bl printgroup
	b .LU61
.LU61:
	mov r4, #0
	cmp #42, #1
	movgt r4, #1
	cmp r4, #1
	beq .LU62
	b .LU63
.LU62:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN15
.JN15:
	b .LU64
.LU64:
	mov r4, #0
	cmp #42, #1
	movge r4, #1
	cmp r4, #1
	beq .LU65
	b .LU66
.LU65:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN16
.JN16:
	b .LU67
.LU67:
	mov r4, #0
	cmp #42, #1
	movlt r4, #1
	cmp r4, #1
	beq .LU68
	b .LU69
.LU68:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN17
.JN17:
	b .LU70
.LU70:
	mov r4, #0
	cmp #42, #1
	movle r4, #1
	cmp r4, #1
	beq .LU71
	b .LU72
.LU71:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN18
.JN18:
	b .LU73
.LU73:
	mov r4, #0
	cmp #42, #1
	moveq r4, #1
	cmp r4, #1
	beq .LU74
	b .LU75
.LU74:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN19
.JN19:
	b .LU76
.LU76:
	mov r4, #0
	cmp #42, #1
	movne r4, #1
	cmp r4, #1
	beq .LU77
	b .LU78
.LU77:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN20
.JN20:
	b .LU79
.LU79:
	b .LU80
.LU80:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN21
.JN21:
	b .LU82
.LU82:
	b .LU84
.LU83:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN22
.JN22:
	b .LU85
.LU85:
	b .LU87
.LU86:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN23
.JN23:
	b .LU88
.LU88:
	b .LU89
.LU89:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN24
.JN24:
	b .LU91
.LU91:
	b .LU92
.LU92:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN25
.JN25:
	mov r0, #4
	bl printgroup
	b .LU94
.LU94:
	mov r5, #2
	mov r4, #3
	add r5, r5, r4
	mov r4, #0
	cmp r5, #5
	moveq r4, #1
	cmp r4, #1
	beq .LU95
	b .LU96
.LU95:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN26
.JN26:
	b .LU97
.LU97:
	mov r5, #2
	mov r4, #3
	mul r5, r5, r4
	mov r4, #0
	cmp r5, #6
	moveq r4, #1
	cmp r4, #1
	beq .LU98
	b .LU99
.LU98:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN27
.JN27:
	b .LU100
.LU100:
	mov r5, #3
	mov r4, #2
	sub r4, r5, r4
	mov r5, #0
	cmp r4, #1
	moveq r5, #1
	cmp r5, #1
	beq .LU101
	b .LU102
.LU101:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN28
.JN28:
	b .LU103
.LU103:
	mov r5, #6
	mov r4, #3
	mov r0, r5
	mov r1, r4
	bl __aeabi_idiv
	mov r5, r0
	mov r4, #0
	cmp r5, #2
	moveq r4, #1
	cmp r4, #1
	beq .LU104
	b .LU105
.LU104:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN29
.JN29:
	b .LU106
.LU106:
	mov r4, #0
	cmp #-6, #0
	movlt r4, #1
	cmp r4, #1
	beq .LU107
	b .LU108
.LU107:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN30
.JN30:
	mov r0, #5
	bl printgroup
	mov r4, #42
	str r4, [fp, #-20]
	b .LU109
.LU109:
	ldr r4, [fp, #-20]
	mov r5, #0
	cmp r4, #42
	moveq r5, #1
	cmp r5, #1
	beq .LU110
	b .LU111
.LU110:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN31
.JN31:
	mov r4, #3
	str r4, [fp, #-20]
	mov r4, #2
	str r4, [fp, #-24]
	ldr r5, [fp, #-20]
	ldr r4, [fp, #-24]
	add r4, r5, r4
	str r4, [fp, #-28]
	b .LU112
.LU112:
	ldr r5, [fp, #-28]
	mov r4, #0
	cmp r5, #5
	moveq r4, #1
	cmp r4, #1
	beq .LU113
	b .LU114
.LU113:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN32
.JN32:
	str r7, [fp, #-12]
	b .LU115
.LU115:
	ldr r4, [fp, #-12]
	cmp r4, #1
	beq .LU116
	b .LU117
.LU116:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN33
.JN33:
	b .LU118
.LU118:
	ldr r4, [fp, #-12]
	mov r5, #1
	eor r4, r4, r5
	cmp r4, #1
	beq .LU119
	b .LU120
.LU119:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN34
.JN34:
	str r7, [fp, #-12]
	b .LU121
.LU121:
	ldr r4, [fp, #-12]
	cmp r4, #1
	beq .LU122
	b .LU123
.LU122:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN35
.JN35:
	b .LU124
.LU124:
	ldr r4, [fp, #-12]
	mov r5, #1
	eor r4, r4, r5
	cmp r4, #1
	beq .LU125
	b .LU126
.LU125:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN36
.JN36:
	b .LU127
.LU127:
	ldr r4, [fp, #-12]
	cmp r4, #1
	beq .LU128
	b .LU129
.LU128:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN37
.JN37:
	mov r0, #6
	bl printgroup
	mov r4, #0
	str r4, [fp, #-20]
	b .LU130
.LU130:
	ldr r5, [fp, #-20]
	mov r4, #0
	cmp r5, #5
	movlt r4, #1
	cmp r4, #1
	beq .LU131
	b .LU133
.LU131:
	ldr r5, [fp, #-20]
	mov r4, #0
	cmp r5, #5
	movge r4, #1
	cmp r4, #1
	beq .LU132
	b .JN38
.LU132:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN38
.JN38:
	ldr r4, [fp, #-20]
	mov r5, #5
	add r4, r4, r5
	str r4, [fp, #-20]
	ldr r5, [fp, #-20]
	mov r4, #0
	cmp r5, #5
	movlt r4, #1
	cmp r4, #1
	beq .LU131
	b .LU133
.LU133:
	ldr r4, [fp, #-20]
	mov r5, #0
	cmp r4, #5
	moveq r5, #1
	cmp r5, #1
	beq .LU134
	b .LU135
.LU134:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN39
.JN39:
	mov r0, #7
	bl printgroup
	movw r0, #12
	bl malloc
	mov r4, r0
	mov r4, r4
	str r4, [fp, #-32]
	ldr r4, [fp, #-32]
	mov r5, r4
	mov r4, #42
	str r4, [r5]
	ldr r4, [fp, #-32]
	add r4, r4, #4
	str r7, [r4]
	b .LU136
.LU136:
	ldr r4, [fp, #-32]
	mov r4, r4
	ldr r4, [r4]
	mov r5, #0
	cmp r4, #42
	moveq r5, #1
	cmp r5, #1
	beq .LU137
	b .LU138
.LU137:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN40
.JN40:
	b .LU139
.LU139:
	ldr r4, [fp, #-32]
	add r4, r4, #4
	ldr r4, [r4]
	cmp r4, #1
	beq .LU140
	b .LU141
.LU140:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN41
.JN41:
	movw r0, #12
	bl malloc
	mov r4, r0
	mov r4, r4
	ldr r5, [fp, #-32]
	add r5, r5, #8
	str r4, [r5]
	ldr r4, [fp, #-32]
	add r4, r4, #8
	ldr r4, [r4]
	mov r5, r4
	mov r4, #13
	str r4, [r5]
	ldr r4, [fp, #-32]
	add r4, r4, #8
	ldr r4, [r4]
	add r4, r4, #4
	str r7, [r4]
	b .LU142
.LU142:
	ldr r4, [fp, #-32]
	add r4, r4, #8
	ldr r4, [r4]
	mov r4, r4
	ldr r4, [r4]
	mov r5, #0
	cmp r4, #13
	moveq r5, #1
	cmp r5, #1
	beq .LU143
	b .LU144
.LU143:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN42
.JN42:
	b .LU145
.LU145:
	ldr r4, [fp, #-32]
	add r4, r4, #8
	ldr r4, [r4]
	add r4, r4, #4
	ldr r5, [r4]
	mov r4, #1
	eor r4, r5, r4
	cmp r4, #1
	beq .LU146
	b .LU147
.LU146:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN43
.JN43:
	b .LU148
.LU148:
	ldr r4, [fp, #-32]
	ldr r5, [fp, #-32]
	mov r6, #0
	cmp r4, r5
	moveq r6, #1
	cmp r6, #1
	beq .LU149
	b .LU150
.LU149:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN44
.JN44:
	b .LU151
.LU151:
	ldr r4, [fp, #-32]
	ldr r5, [fp, #-32]
	add r5, r5, #8
	ldr r5, [r5]
	mov r6, #0
	cmp r4, r5
	movne r6, #1
	cmp r6, #1
	beq .LU152
	b .LU153
.LU152:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN45
.JN45:
	ldr r4, [fp, #-32]
	add r4, r4, #8
	ldr r4, [r4]
	mov r4, r4
	mov r0, r4
	bl free
	ldr r4, [fp, #-32]
	mov r4, r4
	mov r0, r4
	bl free
	mov r0, #8
	bl printgroup
	mov r4, #7
	str r4, [r7]
	b .LU154
.LU154:
	ldr r4, [r7]
	mov r5, #0
	cmp r4, #7
	moveq r5, #1
	cmp r5, #1
	beq .LU155
	b .LU156
.LU155:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN46
.JN46:
	str r7, [r7]
	b .LU157
.LU157:
	ldr r4, [r7]
	cmp r4, #1
	beq .LU158
	b .LU159
.LU158:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN47
.JN47:
	movw r0, #12
	bl malloc
	mov r4, r0
	mov r4, r4
	str r4, [r7]
	ldr r4, [r7]
	mov r4, r4
	mov r5, #34
	str r5, [r4]
	ldr r4, [r7]
	add r4, r4, #4
	str r7, [r4]
	b .LU160
.LU160:
	ldr r4, [r7]
	mov r4, r4
	ldr r4, [r4]
	mov r5, #0
	cmp r4, #34
	moveq r5, #1
	cmp r5, #1
	beq .LU161
	b .LU162
.LU161:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN48
.JN48:
	b .LU163
.LU163:
	ldr r4, [r7]
	add r4, r4, #4
	ldr r4, [r4]
	mov r5, #1
	eor r4, r4, r5
	cmp r4, #1
	beq .LU164
	b .LU165
.LU164:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN49
.JN49:
	movw r0, #12
	bl malloc
	mov r4, r0
	mov r4, r4
	ldr r5, [r7]
	add r5, r5, #8
	str r4, [r5]
	ldr r4, [r7]
	add r4, r4, #8
	ldr r4, [r4]
	mov r4, r4
	mov r5, #16
	str r5, [r4]
	ldr r4, [r7]
	add r4, r4, #8
	ldr r4, [r4]
	add r4, r4, #4
	str r7, [r4]
	b .LU166
.LU166:
	ldr r4, [r7]
	add r4, r4, #8
	ldr r4, [r4]
	mov r4, r4
	ldr r4, [r4]
	mov r5, #0
	cmp r4, #16
	moveq r5, #1
	cmp r5, #1
	beq .LU167
	b .LU168
.LU167:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN50
.JN50:
	b .LU169
.LU169:
	ldr r4, [r7]
	add r4, r4, #8
	ldr r4, [r4]
	add r4, r4, #4
	ldr r4, [r4]
	cmp r4, #1
	beq .LU170
	b .LU171
.LU170:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN51
.JN51:
	ldr r4, [r7]
	add r4, r4, #8
	ldr r4, [r4]
	mov r4, r4
	mov r0, r4
	bl free
	ldr r4, [r7]
	mov r4, r4
	mov r0, r4
	bl free
	mov r0, #9
	bl printgroup
	movw r0, #12
	bl malloc
	mov r4, r0
	mov r4, r4
	str r4, [fp, #-32]
	ldr r4, [fp, #-32]
	add r4, r4, #4
	str r7, [r4]
	ldr r4, [fp, #-32]
	mov r0, #3
	mov r1, r7
	mov r2, r4
	bl takealltypes
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r0, #1
	mov r1, #2
	mov r2, #3
	mov r3, #4
	mov r4, #5
	mov r5, #6
	mov r6, #7
	mov r7, #8
	bl tonofargs
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r0, #3
	bl returnint
	mov r4, r0
	str r4, [fp, #-20]
	b .LU172
.LU172:
	ldr r4, [fp, #-20]
	mov r5, #0
	cmp r4, #3
	moveq r5, #1
	cmp r5, #1
	beq .LU173
	b .LU174
.LU173:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN52
.JN52:
	mov r0, r7
	bl returnbool
	mov r4, r0
	str r4, [fp, #-12]
	b .LU175
.LU175:
	ldr r4, [fp, #-12]
	cmp r4, #1
	beq .LU176
	b .LU177
.LU176:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN53
.JN53:
	movw r0, #12
	bl malloc
	mov r4, r0
	mov r4, r4
	str r4, [fp, #-32]
	ldr r4, [fp, #-32]
	mov r0, r4
	bl returnstruct
	mov r4, r0
	str r4, [fp, #-36]
	b .LU178
.LU178:
	ldr r4, [fp, #-32]
	ldr r5, [fp, #-36]
	mov r6, #0
	cmp r4, r5
	moveq r6, #1
	cmp r6, #1
	beq .LU179
	b .LU180
.LU179:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN54
.JN54:
	mov r0, #10
	bl printgroup
	mov r10, #0
	str r10, [fp, #-8]
	b .LU35
.LU180:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN54
.LU177:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN53
.LU174:
	mov r1, r7
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	ldr r4, [fp, #-20]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN52
.LU171:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN51
.LU168:
	mov r1, r7
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	ldr r4, [r7]
	add r4, r4, #8
	ldr r4, [r4]
	mov r4, r4
	ldr r4, [r4]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN50
.LU165:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN49
.LU162:
	mov r1, r7
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	ldr r4, [r7]
	mov r4, r4
	ldr r4, [r4]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN48
.LU159:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN47
.LU156:
	mov r1, r7
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	ldr r4, [r7]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN46
.LU153:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN45
.LU150:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN44
.LU147:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN43
.LU144:
	mov r1, r7
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	ldr r4, [fp, #-32]
	add r4, r4, #8
	ldr r4, [r4]
	mov r4, r4
	ldr r4, [r4]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN42
.LU141:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN41
.LU138:
	mov r1, r7
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	ldr r4, [fp, #-32]
	mov r4, r4
	ldr r4, [r4]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN40
.LU135:
	mov r1, r7
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	ldr r4, [fp, #-20]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN39
.LU129:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN37
.LU126:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN36
.LU123:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN35
.LU120:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN34
.LU117:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN33
.LU114:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN32
.LU111:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN31
.LU108:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN30
.LU105:
	mov r1, r7
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	mov r5, #6
	mov r4, #3
	mov r0, r5
	mov r1, r4
	bl __aeabi_idiv
	mov r4, r0
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN29
.LU102:
	mov r1, r7
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	mov r5, #3
	mov r4, #2
	sub r4, r5, r4
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN28
.LU99:
	mov r1, r7
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	mov r5, #2
	mov r4, #3
	mul r4, r5, r4
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN27
.LU96:
	mov r1, r7
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	mov r5, #2
	mov r4, #3
	add r4, r5, r4
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN26
.LU93:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN25
.LU90:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN24
.LU87:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN23
.LU84:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN22
.LU81:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN21
.LU78:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN20
.LU75:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN19
.LU72:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN18
.LU69:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN17
.LU66:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN16
.LU63:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN15
.LU60:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN14
.LU57:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN13
.LU54:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN12
.LU51:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN11
.LU48:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN10
.LU45:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN9
.LU42:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN8
.LU39:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN7
.LU35:
	ldr r10, [fp, #-8]
	mov r0, r10
	add sp, sp, #32
	pop {r4-r10, fp, pc}
	.size main, .-main
	.section	.rodata
	.align	2
.PRINTLN_FMT:
	.asciz	"%ld\n"
	.align	2
.PRINT_FMT:
	.asciz	"%ld "
	.align	2
.READ_FMT:
	.asciz	"%ld"
	.comm	.read_scratch,4,4
	.global __aeabi_idiv
