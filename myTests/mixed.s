	.arch armv7-a
	.comm	globalfoo,4,4
	.text

	.align 2
	.global tailrecursive
tailrecursive:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #8
	str r0, [fp, #-8]
	b .LU2
.LU2:
	ldr r5, [fp, #-8]
	mov r4, #0
	cmp r5, #0
	movle r4, #1
	cmp r4, #1
	beq .LU3
	b .JN0
.LU3:
	b .LU0
.JN0:
	movw r0, #12
	bl malloc
	mov r10, r0
	mov r10, r10
	str r10, [fp, #-12]
	ldr r4, [fp, #-8]
	sub r4, r4, #1
	mov r0, r4
	bl tailrecursive
	b .LU0
.LU0:
	add sp, sp, #8
	pop {r4-r10, fp, pc}
	.size tailrecursive, .-tailrecursive
	.align 2
	.global add
add:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #12
	str r0, [fp, #-8]
	str r1, [fp, #-12]
	ldr r5, [fp, #-8]
	ldr r4, [fp, #-12]
	add r10, r5, r4
	str r10, [fp, #-16]
	b .LU4
.LU4:
	ldr r10, [fp, #-16]
	mov r0, r10
	add sp, sp, #12
	pop {r4-r10, fp, pc}
	.size add, .-add
	.align 2
	.global domath
domath:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #16
	str r0, [fp, #-8]
	movw r0, #12
	bl malloc
	mov r4, r0
	mov r4, r4
	str r4, [fp, #-12]
	movw r0, #4
	bl malloc
	mov r4, r0
	mov r5, r4
	ldr r4, [fp, #-12]
	add r4, r4, #8
	str r5, [r4]
	movw r0, #12
	bl malloc
	mov r4, r0
	mov r4, r4
	str r4, [fp, #-16]
	movw r0, #4
	bl malloc
	mov r4, r0
	mov r5, r4
	ldr r4, [fp, #-16]
	add r4, r4, #8
	str r5, [r4]
	ldr r5, [fp, #-8]
	ldr r4, [fp, #-12]
	mov r4, r4
	str r5, [r4]
	ldr r4, [fp, #-16]
	mov r4, r4
	mov r5, #3
	str r5, [r4]
	ldr r4, [fp, #-12]
	mov r4, r4
	ldr r5, [r4]
	ldr r4, [fp, #-12]
	add r4, r4, #8
	ldr r4, [r4]
	mov r4, r4
	str r5, [r4]
	ldr r4, [fp, #-16]
	mov r4, r4
	ldr r5, [r4]
	ldr r4, [fp, #-16]
	add r4, r4, #8
	ldr r4, [r4]
	mov r4, r4
	str r5, [r4]
	b .LU8
.LU8:
	ldr r4, [fp, #-8]
	mov r5, #0
	cmp r4, #0
	movgt r5, #1
	cmp r5, #1
	beq .LU9
	b .LU10
.LU9:
	ldr r4, [fp, #-12]
	mov r4, r4
	ldr r5, [r4]
	ldr r4, [fp, #-16]
	mov r4, r4
	ldr r4, [r4]
	mul r4, r5, r4
	str r4, [fp, #-20]
	ldr r5, [fp, #-20]
	ldr r4, [fp, #-12]
	add r4, r4, #8
	ldr r4, [r4]
	mov r4, r4
	ldr r4, [r4]
	mul r5, r5, r4
	ldr r4, [fp, #-16]
	mov r4, r4
	ldr r4, [r4]
	mov r0, r5
	mov r1, r4
	bl __aeabi_idiv
	mov r10, r0
	str r10, [fp, #-20]
	ldr r10, [fp, #-16]
	add r4, r10, #8
	ldr r4, [r4]
	mov r4, r4
	ldr r5, [r4]
	ldr r4, [fp, #-12]
	mov r4, r4
	ldr r4, [r4]
	mov r0, r5
	mov r1, r4
	bl add
	mov r4, r0
	str r4, [fp, #-20]
	ldr r4, [fp, #-16]
	mov r4, r4
	ldr r5, [r4]
	ldr r4, [fp, #-12]
	mov r4, r4
	ldr r4, [r4]
	sub r4, r5, r4
	str r4, [fp, #-20]
	ldr r4, [fp, #-8]
	sub r4, r4, #1
	str r4, [fp, #-8]
	ldr r5, [fp, #-8]
	mov r4, #0
	cmp r5, #0
	movgt r4, #1
	cmp r4, #1
	beq .LU9
	b .LU10
.LU10:
	ldr r4, [fp, #-12]
	mov r4, r4
	mov r0, r4
	bl free
	ldr r4, [fp, #-16]
	mov r4, r4
	mov r0, r4
	bl free
	b .LU6
.LU6:
	add sp, sp, #16
	pop {r4-r10, fp, pc}
	.size domath, .-domath
	.align 2
	.global objinstantiation
objinstantiation:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #8
	str r0, [fp, #-8]
	b .LU13
.LU13:
	ldr r4, [fp, #-8]
	mov r5, #0
	cmp r4, #0
	movgt r5, #1
	cmp r5, #1
	beq .LU14
	b .LU11
.LU14:
	movw r0, #12
	bl malloc
	mov r4, r0
	mov r10, r4
	str r10, [fp, #-12]
	ldr r10, [fp, #-12]
	mov r4, r10
	mov r0, r4
	bl free
	ldr r4, [fp, #-8]
	sub r4, r4, #1
	str r4, [fp, #-8]
	ldr r5, [fp, #-8]
	mov r4, #0
	cmp r5, #0
	movgt r4, #1
	cmp r4, #1
	beq .LU14
	b .LU11
.LU11:
	add sp, sp, #8
	pop {r4-r10, fp, pc}
	.size objinstantiation, .-objinstantiation
	.align 2
	.global ackermann
ackermann:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #12
	str r0, [fp, #-8]
	str r1, [fp, #-12]
	b .LU17
.LU17:
	ldr r5, [fp, #-8]
	mov r4, #0
	cmp r5, #0
	moveq r4, #1
	cmp r4, #1
	beq .LU18
	b .JN1
.LU18:
	ldr r4, [fp, #-12]
	add r4, r4, #1
	str r4, [fp, #-16]
	b .LU15
.JN1:
	b .LU19
.LU19:
	ldr r5, [fp, #-12]
	mov r4, #0
	cmp r5, #0
	moveq r4, #1
	cmp r4, #1
	beq .LU20
	b .LU21
.LU20:
	ldr r4, [fp, #-8]
	sub r4, r4, #1
	mov r0, r4
	mov r1, #1
	bl ackermann
	mov r10, r0
	str r10, [fp, #-16]
	b .LU15
.LU21:
	ldr r4, [fp, #-8]
	sub r4, r4, #1
	ldr r6, [fp, #-8]
	ldr r5, [fp, #-12]
	sub r5, r5, #1
	mov r0, r6
	mov r1, r5
	bl ackermann
	mov r5, r0
	mov r0, r4
	mov r1, r5
	bl ackermann
	mov r4, r0
	str r4, [fp, #-16]
	b .LU15
.LU15:
	ldr r10, [fp, #-16]
	mov r0, r10
	add sp, sp, #12
	pop {r4-r10, fp, pc}
	.size ackermann, .-ackermann
	.align 2
	.global main
main:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #24
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r0, #:lower16:.read_scratch
	movt r0, #:upper16:.read_scratch
	ldr r0, [r0]
	str r0, [fp, #-12]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r0, #:lower16:.read_scratch
	movt r0, #:upper16:.read_scratch
	ldr r0, [r0]
	str r0, [fp, #-16]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r0, #:lower16:.read_scratch
	movt r0, #:upper16:.read_scratch
	ldr r0, [r0]
	str r0, [fp, #-20]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r0, #:lower16:.read_scratch
	movt r0, #:upper16:.read_scratch
	ldr r0, [r0]
	str r0, [fp, #-24]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r0, #:lower16:.read_scratch
	movt r0, #:upper16:.read_scratch
	ldr r0, [r0]
	str r0, [fp, #-28]
	ldr r4, [fp, #-12]
	mov r0, r4
	bl tailrecursive
	ldr r4, [fp, #-12]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r4, [fp, #-16]
	mov r0, r4
	bl domath
	ldr r4, [fp, #-16]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r4, [fp, #-20]
	mov r0, r4
	bl objinstantiation
	ldr r4, [fp, #-20]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r5, [fp, #-24]
	ldr r4, [fp, #-28]
	mov r0, r5
	mov r1, r4
	bl ackermann
	mov r4, r0
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r10, #0
	str r10, [fp, #-8]
	b .LU22
.LU22:
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
