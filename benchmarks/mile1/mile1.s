	.arch armv7-a
	.text

	.align 2
	.global calcPower
calcPower:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #16
	str r0, [fp, #-8]
	str r1, [fp, #-12]
	mov r10, #1
	str r10, [fp, #-20]
	b .LU2
.LU2:
	ldr r5, [fp, #-12]
	mov r4, #0
	cmp r5, #0
	movgt r4, #1
	cmp r4, #1
	beq .LU3
	b .LU4
.LU3:
	ldr r5, [fp, #-20]
	ldr r4, [fp, #-8]
	mul r10, r5, r4
	str r10, [fp, #-20]
	ldr r4, [fp, #-12]
	sub r4, r4, #1
	str r4, [fp, #-12]
	ldr r5, [fp, #-12]
	mov r4, #0
	cmp r5, #0
	movgt r4, #1
	cmp r4, #1
	beq .LU3
	b .LU4
.LU4:
	ldr r4, [fp, #-20]
	str r4, [fp, #-16]
	b .LU0
.LU0:
	ldr r4, [fp, #-16]
	mov r0, r4
	add sp, sp, #16
	pop {r4-r10, fp, pc}
	.size calcPower, .-calcPower
	.align 2
	.global main
main:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #24
	mov r4, #0
	str r4, [fp, #-20]
	movw r0, #8
	bl malloc
	mov r4, r0
	mov r4, r4
	str r4, [fp, #-12]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r0, #:lower16:.read_scratch
	movt r0, #:upper16:.read_scratch
	ldr r0, [r0]
	str r0, [fp, #-16]
	ldr r5, [fp, #-16]
	ldr r4, [fp, #-12]
	mov r4, r4
	str r5, [r4]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r0, #:lower16:.read_scratch
	movt r0, #:upper16:.read_scratch
	ldr r0, [r0]
	str r0, [fp, #-16]
	b .LU7
.LU7:
	ldr r4, [fp, #-16]
	mov r5, #0
	cmp r4, #0
	movlt r5, #1
	cmp r5, #1
	beq .LU8
	b .JN0
.LU8:
	mov r4, #-1
	str r4, [fp, #-8]
	b .LU5
.JN0:
	ldr r5, [fp, #-16]
	ldr r4, [fp, #-12]
	add r4, r4, #4
	str r5, [r4]
	mov r4, #0
	str r4, [fp, #-28]
	b .LU9
.LU9:
	ldr r4, [fp, #-28]
	mov r5, #0
	cmp r4, #1000000
	movlt r5, #1
	cmp r5, #1
	beq .LU10
	b .LU11
.LU10:
	ldr r4, [fp, #-28]
	add r4, r4, #1
	str r4, [fp, #-28]
	ldr r4, [fp, #-12]
	mov r4, r4
	ldr r5, [r4]
	ldr r4, [fp, #-12]
	add r4, r4, #4
	ldr r4, [r4]
	mov r0, r5
	mov r1, r4
	bl calcPower
	mov r4, r0
	str r4, [fp, #-20]
	ldr r4, [fp, #-28]
	mov r5, #0
	cmp r4, #1000000
	movlt r5, #1
	cmp r5, #1
	beq .LU10
	b .LU11
.LU11:
	ldr r4, [fp, #-20]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r10, #1
	str r10, [fp, #-8]
	b .LU5
.LU5:
	ldr r10, [fp, #-8]
	mov r0, r10
	add sp, sp, #24
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
