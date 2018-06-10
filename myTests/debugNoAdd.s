	.arch armv7-a
	.text

	.align 2
	.global testRecursive
testRecursive:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #8
	str r0, [fp, #-8]
	b .LU2
.LU2:
	ldr r2, [fp, #-8]
	mov r0, #0
	cmp r2, #0
	moveq r0, #1
	cmp r0, #1
	beq .LU3
	b .LU4
.LU3:
	ldr r10, [fp, #-8]
	str r10, [fp, #-12]
	b .LU0
.LU4:
	ldr r10, [fp, #-8]
	sub r0, r10, #1
	mov r0, r0
	bl testRecursive
	mov r0, r0
	str r0, [fp, #-12]
	b .LU0
.LU0:
	ldr r0, [fp, #-12]
	mov r0, r0
	add sp, sp, #8
	pop {r4-r10, fp, pc}
	.size testRecursive, .-testRecursive
	.align 2
	.global main
main:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #12
	mov r10, #2
	str r10, [fp, #-12]
	ldr r0, [fp, #-12]
	mov r0, r0
	bl testRecursive
	mov r0, r0
	str r0, [fp, #-16]
	ldr r0, [fp, #-16]
	mov r1, r0
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r0, [fp, #-16]
	str r0, [fp, #-8]
	b .LU5
.LU5:
	ldr r10, [fp, #-8]
	mov r0, r10
	add sp, sp, #12
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
