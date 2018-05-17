	.arch armv7-a
	.comm	globalfoo,4,4

	.text
	.align 2
	.global tailrecursive
tailrecursive:
.LU1:
	push {fp, lr}
	add fp, sp, #4
	mov %num, r0
	mov %_u0, #0
	cmp %num, #0
	movle %_u0, #1
	cmp %_u0, #1
	beq .LU2
	b .LU3
.LU2:
	b .LU0
.LU3:
	b .LU4
.LU4:
	movw r0, #12
	bl malloc
	mov %_u1, r0
	mov %_u2, %_u1
	sub %_u3, %num, #1
	mov r0, %_u3
	bl tailrecursive
	b .LU0
.LU0:
	pop {fp, pc}
	.size tailrecursive, .-tailrecursive
	.align 2
	.global add
add:
.LU6:
	push {fp, lr}
	add fp, sp, #4
	mov %x, r0
	mov %y, r1
	add %_u5, %x, %y
	b .LU5
.LU5:
	mov r0, %_u5
	pop {fp, pc}
	.size add, .-add
	.align 2
	.global domath
domath:
.LU8:
	push {fp, lr}
	add fp, sp, #4
	mov %num, r0
	movw r0, #12
	bl malloc
	mov %_u6, r0
	mov %_u7, %_u6
	movw r0, #4
	bl malloc
	mov %_u8, r0
	mov %_u9, %_u8
	add %_u10, %_u7, #8
	str %_u9, [%_u10]
	movw r0, #12
	bl malloc
	mov %_u11, r0
	mov %_u12, %_u11
	movw r0, #4
	bl malloc
	mov %_u13, r0
	mov %_u14, %_u13
	add %_u15, %_u12, #8
	str %_u14, [%_u15]
	mov %_u16, %_u7
	str %num, [%_u16]
	mov %_u17, %_u12
	movw %t0, #3
	str %t0, [%_u17]
	mov %_u18, %_u7
	ldr %_u19, [%_u18]
	add %_u20, %_u7, #8
	ldr %_u21, [%_u20]
	mov %_u22, %_u21
	str %_u19, [%_u22]
	mov %_u23, %_u12
	ldr %_u24, [%_u23]
	add %_u25, %_u12, #8
	ldr %_u26, [%_u25]
	mov %_u27, %_u26
	str %_u24, [%_u27]
	mov %_phi0, %num
	mov %_phi1, %_u12
	mov %_phi2, %_u7
	mov %_phi3, %_u12
	mov %_phi4, %_u7
	mov %_u28, #0
	cmp %num, #0
	movgt %_u28, #1
	cmp %_u28, #1
	beq .LU9
	b .LU10
.LU9:
	mov %num0, %_phi0
	mov %math20, %_phi1
	mov %math10, %_phi2
	mov %_u29, %math10
	ldr %_u30, [%_u29]
	mov %_u31, %math20
	ldr %_u32, [%_u31]
	mul %_u33, %_u30, %_u32
	add %_u34, %math10, #8
	ldr %_u35, [%_u34]
	mov %_u36, %_u35
	ldr %_u37, [%_u36]
	mul %_u38, %_u33, %_u37
	mov %_u39, %math20
	ldr %_u40, [%_u39]
	mov r1, %_u40
	mov r0, %_u38
	bl __aeabi_idiv
	mov %_u41, r0
	add %_u42, %math20, #8
	ldr %_u43, [%_u42]
	mov %_u44, %_u43
	ldr %_u45, [%_u44]
	mov %_u46, %math10
	ldr %_u47, [%_u46]
	mov r1, %_u47
	mov r0, %_u45
	bl add
	mov %_u48, r0
	mov %_u49, %math20
	ldr %_u50, [%_u49]
	mov %_u51, %math10
	ldr %_u52, [%_u51]
	sub %_u53, %_u50, %_u52
	sub %_u54, %num0, #1
	mov %_phi0, %_u54
	mov %_phi1, %math20
	mov %_phi2, %math10
	mov %_phi3, %math20
	mov %_phi4, %math10
	mov %_u55, #0
	cmp %_u54, #0
	movgt %_u55, #1
	cmp %_u55, #1
	beq .LU9
	b .LU10
.LU10:
	mov %math21, %_phi3
	mov %math11, %_phi4
	mov %_u56, %math11
	mov r0, %_u56
	bl free
	mov %_u57, %math21
	mov r0, %_u57
	bl free
	b .LU7
.LU7:
	pop {fp, pc}
	.size domath, .-domath
	.align 2
	.global objinstantiation
objinstantiation:
.LU12:
	push {fp, lr}
	add fp, sp, #4
	mov %num, r0
	mov %_phi5, %num
	mov %_u58, #0
	cmp %num, #0
	movgt %_u58, #1
	cmp %_u58, #1
	beq .LU13
	b .LU14
.LU13:
	mov %num0, %_phi5
	movw r0, #12
	bl malloc
	mov %_u59, r0
	mov %_u60, %_u59
	mov %_u61, %_u60
	mov r0, %_u61
	bl free
	sub %_u62, %num0, #1
	mov %_phi5, %_u62
	mov %_u63, #0
	cmp %_u62, #0
	movgt %_u63, #1
	cmp %_u63, #1
	beq .LU13
	b .LU14
.LU14:
	b .LU11
.LU11:
	pop {fp, pc}
	.size objinstantiation, .-objinstantiation
	.align 2
	.global ackermann
ackermann:
.LU16:
	push {fp, lr}
	add fp, sp, #4
	mov %m, r0
	mov %n, r1
	mov %_u64, #0
	cmp %m, #0
	moveq %_u64, #1
	cmp %_u64, #1
	beq .LU17
	b .LU18
.LU17:
	add %_u65, %n, #1
	mov %_phi6, %_u65
	b .LU15
.LU18:
	b .LU19
.LU19:
	mov %_u66, #0
	cmp %n, #0
	moveq %_u66, #1
	cmp %_u66, #1
	beq .LU20
	b .LU21
.LU20:
	sub %_u67, %m, #1
	movw r1, #1
	mov r0, %_u67
	bl ackermann
	mov %_u68, r0
	mov %_phi6, %_u68
	b .LU15
.LU21:
	sub %_u69, %m, #1
	sub %_u70, %n, #1
	mov r1, %_u70
	mov r0, %m
	bl ackermann
	mov %_u71, r0
	mov r1, %_u71
	mov r0, %_u69
	bl ackermann
	mov %_u72, r0
	mov %_phi6, %_u72
	b .LU15
.LU15:
	mov %_retval_0, %_phi6
	mov r0, %_retval_0
	pop {fp, pc}
	.size ackermann, .-ackermann
	.align 2
	.global main
main:
.LU23:
	push {fp, lr}
	add fp, sp, #4
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw %_u73, #:lower16:.read_scratch
	movt %_u73, #:upper16:.read_scratch
	ldr %_u73, [%_u73]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw %_u74, #:lower16:.read_scratch
	movt %_u74, #:upper16:.read_scratch
	ldr %_u74, [%_u74]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw %_u75, #:lower16:.read_scratch
	movt %_u75, #:upper16:.read_scratch
	ldr %_u75, [%_u75]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw %_u76, #:lower16:.read_scratch
	movt %_u76, #:upper16:.read_scratch
	ldr %_u76, [%_u76]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw %_u77, #:lower16:.read_scratch
	movt %_u77, #:upper16:.read_scratch
	ldr %_u77, [%_u77]
	mov r0, %_u73
	bl tailrecursive
	mov r1, %_u73
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r0, %_u74
	bl domath
	mov r1, %_u74
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r0, %_u75
	bl objinstantiation
	mov r1, %_u75
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r1, %_u77
	mov r0, %_u76
	bl ackermann
	mov %_u81, r0
	mov r1, %_u81
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU22
.LU22:
	movw r0, #0
	pop {fp, pc}
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
	.global	__aeabi_idiv
