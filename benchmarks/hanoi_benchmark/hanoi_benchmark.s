	.arch armv7-a
	.comm	peg1,4,4
	.comm	peg2,4,4
	.comm	peg3,4,4
	.comm	numMoves,4,4
	.text

	.align 2
	.global move
move:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #12
	str r0, [fp, #-8]
	str r1, [fp, #-12]
	b .LU2
.LU2:
	ldr r6, [fp, #-8]
	mov r5, #0
	cmp r6, #1
	moveq r5, #1
	cmp r5, #1
	beq .LU3
	b .LU4
.LU3:
	ldr r5, [r4]
	str r5, [fp, #-16]
	ldr r5, [r4]
	add r5, r5, #4
	ldr r5, [r5]
	str r5, [r4]
	b .JN1
.JN1:
	b .LU7
.LU7:
	ldr r5, [fp, #-12]
	mov r6, #0
	cmp r5, #1
	moveq r6, #1
	cmp r6, #1
	beq .LU8
	b .LU9
.LU8:
	ldr r6, [r4]
	ldr r5, [fp, #-16]
	add r5, r5, #4
	str r6, [r5]
	ldr r5, [fp, #-16]
	str r5, [r4]
	b .JN3
.JN3:
	ldr r6, [r4]
	mov r5, #1
	add r10, r6, r5
	str r10, [r4]
	b .LU0
.LU9:
	ldr r6, [fp, #-12]
	mov r5, #0
	cmp r6, #2
	moveq r5, #1
	cmp r5, #1
	beq .LU10
	b .LU11
.LU10:
	ldr r6, [r4]
	ldr r5, [fp, #-16]
	add r5, r5, #4
	str r6, [r5]
	ldr r5, [fp, #-16]
	str r5, [r4]
	b .JN2
.JN2:
	b .JN3
.LU11:
	ldr r6, [r4]
	ldr r5, [fp, #-16]
	add r5, r5, #4
	str r6, [r5]
	ldr r10, [fp, #-16]
	str r10, [r4]
	b .JN2
.LU4:
	ldr r6, [fp, #-8]
	mov r5, #0
	cmp r6, #2
	moveq r5, #1
	cmp r5, #1
	beq .LU5
	b .LU6
.LU5:
	ldr r5, [r4]
	str r5, [fp, #-16]
	ldr r5, [r4]
	add r5, r5, #4
	ldr r5, [r5]
	str r5, [r4]
	b .JN0
.JN0:
	b .JN1
.LU6:
	ldr r5, [r4]
	str r5, [fp, #-16]
	ldr r5, [r4]
	add r5, r5, #4
	ldr r5, [r5]
	str r5, [r4]
	b .JN0
.LU0:
	add sp, sp, #12
	pop {r4-r10, fp, pc}
	.size move, .-move
	.align 2
	.global hanoi
hanoi:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #16
	str r0, [fp, #-8]
	str r1, [fp, #-12]
	str r2, [fp, #-16]
	str r3, [fp, #-20]
	b .LU14
.LU14:
	ldr r4, [fp, #-8]
	mov r5, #0
	cmp r4, #1
	moveq r5, #1
	cmp r5, #1
	beq .LU15
	b .LU16
.LU15:
	ldr r5, [fp, #-12]
	ldr r4, [fp, #-16]
	mov r0, r5
	mov r1, r4
	bl move
	b .JN4
.JN4:
	b .LU12
.LU16:
	ldr r10, [fp, #-8]
	mov r10, #1
	sub r7, r10, r10
	ldr r6, [fp, #-12]
	ldr r4, [fp, #-20]
	ldr r5, [fp, #-16]
	mov r0, r7
	mov r1, r6
	mov r2, r4
	mov r3, r5
	bl hanoi
	ldr r5, [fp, #-12]
	ldr r4, [fp, #-16]
	mov r0, r5
	mov r1, r4
	bl move
	ldr r4, [fp, #-8]
	mov r5, #1
	sub r7, r4, r5
	ldr r6, [fp, #-20]
	ldr r5, [fp, #-16]
	ldr r4, [fp, #-12]
	mov r0, r7
	mov r1, r6
	mov r2, r5
	mov r3, r4
	bl hanoi
	b .JN4
.LU12:
	add sp, sp, #16
	pop {r4-r10, fp, pc}
	.size hanoi, .-hanoi
	.align 2
	.global printPeg
printPeg:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #8
	str r0, [fp, #-8]
	ldr r5, [fp, #-8]
	str r5, [fp, #-12]
	b .LU19
.LU19:
	ldr r6, [fp, #-12]
	mov r5, #0
	cmp r6, r4
	movne r5, #1
	cmp r5, #1
	beq .LU20
	b .LU17
.LU20:
	ldr r5, [fp, #-12]
	mov r5, r5
	ldr r5, [r5]
	mov r1, r5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r5, [fp, #-12]
	add r10, r5, #4
	ldr r10, [r10]
	str r10, [fp, #-12]
	ldr r6, [fp, #-12]
	mov r5, #0
	cmp r6, r4
	movne r5, #1
	cmp r5, #1
	beq .LU20
	b .LU17
.LU17:
	add sp, sp, #8
	pop {r4-r10, fp, pc}
	.size printPeg, .-printPeg
	.align 2
	.global main
main:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #16
	str r6, [r6]
	str r6, [r6]
	str r6, [r6]
	mov r4, #0
	str r4, [r6]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r0, #:lower16:.read_scratch
	movt r0, #:upper16:.read_scratch
	ldr r0, [r0]
	str r0, [fp, #-16]
	b .LU23
.LU23:
	ldr r5, [fp, #-16]
	mov r4, #0
	cmp r5, #1
	movge r4, #1
	cmp r4, #1
	beq .LU24
	b .JN5
.LU24:
	ldr r4, [fp, #-16]
	str r4, [fp, #-12]
	b .LU25
.LU25:
	ldr r5, [fp, #-12]
	mov r4, #0
	cmp r5, #0
	movne r4, #1
	cmp r4, #1
	beq .LU26
	b .LU27
.LU26:
	movw r0, #8
	bl malloc
	mov r4, r0
	mov r4, r4
	str r4, [fp, #-20]
	ldr r5, [fp, #-12]
	ldr r4, [fp, #-20]
	mov r4, r4
	str r5, [r4]
	ldr r5, [r6]
	ldr r4, [fp, #-20]
	add r4, r4, #4
	str r5, [r4]
	ldr r4, [fp, #-20]
	str r4, [r6]
	ldr r4, [fp, #-12]
	mov r5, #1
	sub r4, r4, r5
	str r4, [fp, #-12]
	ldr r5, [fp, #-12]
	mov r4, #0
	cmp r5, #0
	movne r4, #1
	cmp r4, #1
	beq .LU26
	b .LU27
.LU27:
	mov r1, r6
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r4, [r6]
	mov r0, r4
	bl printPeg
	mov r1, r6
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r4, [r6]
	mov r0, r4
	bl printPeg
	mov r1, r6
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r4, [r6]
	mov r0, r4
	bl printPeg
	ldr r4, [fp, #-16]
	mov r0, r4
	mov r1, #1
	mov r2, #3
	mov r3, #2
	bl hanoi
	mov r1, r6
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r4, [r6]
	mov r0, r4
	bl printPeg
	mov r1, r6
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r4, [r6]
	mov r0, r4
	bl printPeg
	mov r1, r6
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r4, [r6]
	mov r0, r4
	bl printPeg
	ldr r4, [r6]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU28
.LU28:
	ldr r4, [r6]
	mov r5, #0
	cmp r4, r6
	movne r5, #1
	cmp r5, #1
	beq .LU29
	b .JN5
.LU29:
	ldr r4, [r6]
	str r4, [fp, #-20]
	ldr r4, [r6]
	add r4, r4, #4
	ldr r4, [r4]
	str r4, [r6]
	ldr r4, [fp, #-20]
	mov r4, r4
	mov r0, r4
	bl free
	ldr r5, [r6]
	mov r4, #0
	cmp r5, r6
	movne r4, #1
	cmp r4, #1
	beq .LU29
	b .JN5
.JN5:
	mov r10, #0
	str r10, [fp, #-8]
	b .LU21
.LU21:
	ldr r10, [fp, #-8]
	mov r0, r10
	add sp, sp, #16
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
