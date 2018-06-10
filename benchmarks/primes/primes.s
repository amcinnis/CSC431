	.arch armv7-a
	.text

	.align 2
	.global isqrt
isqrt:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #16
	str r0, [fp, #-8]
	mov r4, #1
	str r4, [fp, #-16]
	mov r4, #3
	str r4, [fp, #-20]
	b .LU2
.LU2:
	ldr r6, [fp, #-16]
	ldr r5, [fp, #-8]
	mov r4, #0
	cmp r6, r5
	movle r4, #1
	cmp r4, #1
	beq .LU3
	b .LU4
.LU3:
	ldr r5, [fp, #-16]
	ldr r4, [fp, #-20]
	add r4, r5, r4
	str r4, [fp, #-16]
	ldr r4, [fp, #-20]
	mov r5, #2
	add r4, r4, r5
	str r4, [fp, #-20]
	ldr r6, [fp, #-16]
	ldr r5, [fp, #-8]
	mov r4, #0
	cmp r6, r5
	movle r4, #1
	cmp r4, #1
	beq .LU3
	b .LU4
.LU4:
	ldr r5, [fp, #-20]
	mov r4, #2
	mov r0, r5
	mov r1, r4
	bl __aeabi_idiv
	mov r5, r0
	mov r4, #1
	sub r10, r5, r4
	str r10, [fp, #-12]
	b .LU0
.LU0:
	ldr r10, [fp, #-12]
	mov r0, r10
	add sp, sp, #16
	pop {r4-r10, fp, pc}
	.size isqrt, .-isqrt
	.align 2
	.global prime
prime:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #20
	str r0, [fp, #-8]
	b .LU7
.LU7:
	ldr r6, [fp, #-8]
	mov r5, #0
	cmp r6, #2
	movlt r5, #1
	cmp r5, #1
	beq .LU8
	b .LU9
.LU8:
	str r4, [fp, #-12]
	b .LU5
.LU9:
	ldr r5, [fp, #-8]
	mov r0, r5
	bl isqrt
	mov r10, r0
	str r10, [fp, #-16]
	mov r5, #2
	str r5, [fp, #-20]
	b .LU10
.LU10:
	ldr r7, [fp, #-20]
	ldr r6, [fp, #-16]
	mov r5, #0
	cmp r7, r6
	movle r5, #1
	cmp r5, #1
	beq .LU11
	b .LU14
.LU11:
	ldr r5, [fp, #-8]
	ldr r7, [fp, #-8]
	ldr r6, [fp, #-20]
	mov r0, r7
	mov r1, r6
	bl __aeabi_idiv
	mov r7, r0
	ldr r6, [fp, #-20]
	mul r6, r7, r6
	sub r5, r5, r6
	str r5, [fp, #-24]
	b .LU12
.LU12:
	ldr r5, [fp, #-24]
	mov r6, #0
	cmp r5, #0
	moveq r6, #1
	cmp r6, #1
	beq .LU13
	b .JN0
.LU13:
	str r4, [fp, #-12]
	b .LU5
.JN0:
	ldr r6, [fp, #-20]
	mov r5, #1
	add r5, r6, r5
	str r5, [fp, #-20]
	ldr r6, [fp, #-20]
	ldr r5, [fp, #-16]
	mov r7, #0
	cmp r6, r5
	movle r7, #1
	cmp r7, #1
	beq .LU11
	b .LU14
.LU14:
	str r4, [fp, #-12]
	b .LU5
.LU5:
	ldr r10, [fp, #-12]
	mov r0, r10
	add sp, sp, #20
	pop {r4-r10, fp, pc}
	.size prime, .-prime
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
	ldr r0, [r0]
	str r0, [fp, #-12]
	mov r4, #0
	str r4, [fp, #-16]
	b .LU17
.LU17:
	ldr r5, [fp, #-16]
	ldr r4, [fp, #-12]
	mov r6, #0
	cmp r5, r4
	movle r6, #1
	cmp r6, #1
	beq .LU18
	b .LU20
.LU18:
	ldr r4, [fp, #-16]
	mov r0, r4
	bl prime
	mov r4, r0
	cmp r4, #1
	beq .LU19
	b .JN2
.LU19:
	ldr r4, [fp, #-16]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .JN2
.JN2:
	ldr r4, [fp, #-16]
	mov r5, #1
	add r4, r4, r5
	str r4, [fp, #-16]
	ldr r4, [fp, #-16]
	ldr r6, [fp, #-12]
	mov r5, #0
	cmp r4, r6
	movle r5, #1
	cmp r5, #1
	beq .LU18
	b .LU20
.LU20:
	mov r10, #0
	str r10, [fp, #-8]
	b .LU15
.LU15:
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
