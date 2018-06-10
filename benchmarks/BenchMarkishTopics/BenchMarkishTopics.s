	.arch armv7-a
	.comm	intList,4,4
	.text

	.align 2
	.global length
length:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #8
	str r0, [fp, #-8]
	b .LU2
.LU2:
	ldr r5, [fp, #-8]
	mov r4, #0
	cmp r5, r6
	moveq r4, #1
	cmp r4, #1
	beq .LU3
	b .JN0
.LU3:
	mov r4, #0
	str r4, [fp, #-12]
	b .LU0
.JN0:
	ldr r4, [fp, #-8]
	add r4, r4, #4
	ldr r4, [r4]
	mov r0, r4
	bl length
	mov r4, r0
	mov r5, #1
	add r10, r5, r4
	str r10, [fp, #-12]
	b .LU0
.LU0:
	ldr r10, [fp, #-12]
	mov r0, r10
	add sp, sp, #8
	pop {r4-r10, fp, pc}
	.size length, .-length
	.align 2
	.global addToFront
addToFront:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #16
	str r0, [fp, #-8]
	str r1, [fp, #-12]
	b .LU6
.LU6:
	ldr r6, [fp, #-8]
	mov r5, #0
	cmp r6, r4
	moveq r5, #1
	cmp r5, #1
	beq .LU7
	b .JN1
.LU7:
	movw r0, #8
	bl malloc
	mov r5, r0
	mov r5, r5
	str r5, [fp, #-8]
	ldr r5, [fp, #-12]
	ldr r6, [fp, #-8]
	mov r6, r6
	str r5, [r6]
	ldr r5, [fp, #-8]
	add r5, r5, #4
	str r4, [r5]
	ldr r4, [fp, #-8]
	str r4, [fp, #-16]
	b .LU4
.JN1:
	movw r0, #8
	bl malloc
	mov r10, r0
	mov r10, r10
	str r10, [fp, #-20]
	ldr r5, [fp, #-12]
	ldr r4, [fp, #-20]
	mov r4, r4
	str r5, [r4]
	ldr r4, [fp, #-8]
	ldr r5, [fp, #-20]
	add r5, r5, #4
	str r4, [r5]
	ldr r4, [fp, #-20]
	str r4, [fp, #-16]
	b .LU4
.LU4:
	ldr r4, [fp, #-16]
	mov r0, r4
	add sp, sp, #16
	pop {r4-r10, fp, pc}
	.size addToFront, .-addToFront
	.align 2
	.global deleteFirst
deleteFirst:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #12
	str r0, [fp, #-8]
	b .LU10
.LU10:
	ldr r5, [fp, #-8]
	mov r4, #0
	cmp r5, r6
	moveq r4, #1
	cmp r4, #1
	beq .LU11
	b .JN2
.LU11:
	str r6, [fp, #-12]
	b .LU8
.JN2:
	ldr r4, [fp, #-8]
	str r4, [fp, #-16]
	ldr r4, [fp, #-8]
	add r4, r4, #4
	ldr r4, [r4]
	str r4, [fp, #-8]
	ldr r4, [fp, #-16]
	mov r4, r4
	mov r0, r4
	bl free
	ldr r10, [fp, #-8]
	str r10, [fp, #-12]
	b .LU8
.LU8:
	ldr r10, [fp, #-12]
	mov r0, r10
	add sp, sp, #12
	pop {r4-r10, fp, pc}
	.size deleteFirst, .-deleteFirst
	.align 2
	.global main
main:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #12
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r0, #:lower16:.read_scratch
	movt r0, #:upper16:.read_scratch
	ldr r5, [r0]
	mov r6, #0
	str r6, [fp, #-16]
	str r4, [fp, #-12]
	b .LU14
.LU14:
	ldr r4, [r5]
	mov r6, #0
	cmp r4, #0
	movgt r6, #1
	cmp r6, #1
	beq .LU15
	b .LU16
.LU15:
	ldr r6, [fp, #-12]
	ldr r4, [r5]
	mov r0, r6
	mov r1, r4
	bl addToFront
	mov r4, r0
	str r4, [fp, #-12]
	ldr r4, [fp, #-12]
	mov r4, r4
	ldr r4, [r4]
	mov r1, r4
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	ldr r6, [r5]
	mov r4, #1
	sub r4, r6, r4
	str r4, [r5]
	ldr r6, [r5]
	mov r4, #0
	cmp r6, #0
	movgt r4, #1
	cmp r4, #1
	beq .LU15
	b .LU16
.LU16:
	ldr r4, [fp, #-12]
	mov r0, r4
	bl length
	mov r4, r0
	mov r1, r4
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	b .LU17
.LU17:
	ldr r4, [fp, #-12]
	mov r0, r4
	bl length
	mov r5, r0
	mov r4, #0
	cmp r5, #0
	movgt r4, #1
	cmp r4, #1
	beq .LU18
	b .LU19
.LU18:
	ldr r5, [fp, #-16]
	ldr r4, [fp, #-12]
	mov r4, r4
	ldr r4, [r4]
	add r4, r5, r4
	str r4, [fp, #-16]
	ldr r4, [fp, #-12]
	mov r0, r4
	bl length
	mov r4, r0
	mov r1, r4
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	ldr r4, [fp, #-12]
	mov r0, r4
	bl deleteFirst
	mov r4, r0
	str r4, [fp, #-12]
	ldr r4, [fp, #-12]
	mov r0, r4
	bl length
	mov r4, r0
	mov r5, #0
	cmp r4, #0
	movgt r5, #1
	cmp r5, #1
	beq .LU18
	b .LU19
.LU19:
	ldr r4, [fp, #-16]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r10, #0
	str r10, [fp, #-8]
	b .LU12
.LU12:
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
