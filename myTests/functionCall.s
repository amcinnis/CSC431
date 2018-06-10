	.arch armv7-a
	.text

	.align 2
	.global test
test:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #8
	str r0, [fp, #-8]
	ldr %u0, [fp, #-8]
	add %u1, %u0, #1
	str %u1, [fp, #-12]
	b .LU0
.LU0:
	ldr %u2, [fp, #-12]
	mov r0, %u2
	add sp, sp, #8
	pop {r4-r10, fp, pc}
	.size test, .-test
	.align 2
	.global main
main:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #8
	mov r0, 3
	bl test
	mov %u3, r0
	str %u3, [fp, #-12]
	ldr %u4, [fp, #-12]
	mov r1, %u4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov %t0, #0
	str %t0, [fp, #-8]
	b .LU2
.LU2:
	ldr %u5, [fp, #-8]
	mov r0, %u5
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
