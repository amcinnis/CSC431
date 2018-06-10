	.arch armv7-a
	.text

	.align 2
	.global main
main:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #8
	mov r4, #5
	str r4, [fp, #-12]
	b .LU2
.LU2:
	ldr r5, [fp, #-12]
	mov r4, #0
	cmp r5, #0
	movge r4, #1
	cmp r4, #1
	beq .LU3
	b .LU4
.LU3:
	ldr r4, [fp, #-12]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r4, [fp, #-12]
	sub r4, r4, #1
	str r4, [fp, #-12]
	ldr r5, [fp, #-12]
	mov r4, #0
	cmp r5, #0
	movge r4, #1
	cmp r4, #1
	beq .LU3
	b .LU4
.LU4:
	ldr r10, [fp, #-12]
	str r10, [fp, #-8]
	b .LU0
.LU0:
	ldr r10, [fp, #-8]
	mov r0, r10
	add sp, sp, #8
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
