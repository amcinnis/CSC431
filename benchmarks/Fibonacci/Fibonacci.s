	.arch armv7-a
	.text

	.align 2
	.global computeFib
computeFib:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #8
	str r0, [fp, #-8]
	b .LU2
.LU2:
	ldr r5, [fp, #-8]
	mov r4, #0
	cmp r5, #0
	moveq r4, #1
	cmp r4, #1
	beq .LU3
	b .LU4
.LU3:
	mov r10, #0
	str r10, [fp, #-12]
	b .LU0
.LU4:
	ldr r5, [fp, #-8]
	mov r4, #0
	cmp r5, #2
	movle r4, #1
	cmp r4, #1
	beq .LU5
	b .LU6
.LU5:
	mov r4, #1
	str r4, [fp, #-12]
	b .LU0
.LU6:
	ldr r4, [fp, #-8]
	sub r4, r4, #1
	mov r0, r4
	bl computeFib
	mov r4, r0
	ldr r5, [fp, #-8]
	sub r5, r5, #2
	mov r0, r5
	bl computeFib
	mov r5, r0
	add r4, r4, r5
	str r4, [fp, #-12]
	b .LU0
.LU0:
	ldr r10, [fp, #-12]
	mov r0, r10
	add sp, sp, #8
	pop {r4-r10, fp, pc}
	.size computeFib, .-computeFib
	.align 2
	.global main
main:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #8
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r0, #:lower16:.read_scratch
	movt r0, #:upper16:.read_scratch
	ldr r0, [r0]
	str r0, [fp, #-12]
	ldr r4, [fp, #-12]
	mov r0, r4
	bl computeFib
	mov r4, r0
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r10, #0
	str r10, [fp, #-8]
	b .LU7
.LU7:
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
