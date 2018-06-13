	.arch armv7-a
	.text

	.align 2
	.global getRands
getRands:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #28
	str r0, [fp, #-8]
	str r1, [fp, #-12]
	str r6, [fp, #-28]
	ldr r5, [fp, #-8]
	ldr r4, [fp, #-8]
	mul r4, r5, r4
	str r4, [fp, #-20]
	movw r0, #8
	bl malloc
	mov r4, r0
	mov r4, r4
	str r4, [fp, #-32]
	ldr r5, [fp, #-20]
	ldr r4, [fp, #-32]
	mov r4, r4
	str r5, [r4]
	ldr r4, [fp, #-32]
	add r4, r4, #4
	str r6, [r4]
	ldr r5, [fp, #-12]
	mov r4, #1
	sub r4, r5, r4
	str r4, [fp, #-12]
	ldr r4, [fp, #-20]
	str r4, [fp, #-24]
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
	ldr r5, [fp, #-24]
	ldr r4, [fp, #-24]
	mul r5, r5, r4
	ldr r4, [fp, #-8]
	mov r0, r5
	mov r1, r4
	bl __aeabi_idiv
	mov r4, r0
	ldr r6, [fp, #-8]
	mov r5, #2
	mov r0, r6
	mov r1, r5
	bl __aeabi_idiv
	mov r5, r0
	mul r5, r4, r5
	mov r4, #1
	add r4, r5, r4
	str r4, [fp, #-20]
	movw r0, #8
	bl malloc
	mov r4, r0
	mov r4, r4
	str r4, [fp, #-28]
	ldr r5, [fp, #-20]
	ldr r4, [fp, #-28]
	mov r4, r4
	str r5, [r4]
	ldr r5, [fp, #-32]
	ldr r4, [fp, #-28]
	add r4, r4, #4
	str r5, [r4]
	ldr r4, [fp, #-28]
	str r4, [fp, #-32]
	ldr r4, [fp, #-12]
	mov r5, #1
	sub r4, r4, r5
	str r4, [fp, #-12]
	ldr r4, [fp, #-20]
	str r4, [fp, #-24]
	ldr r5, [fp, #-12]
	mov r4, #0
	cmp r5, #0
	movgt r4, #1
	cmp r4, #1
	beq .LU3
	b .LU4
.LU4:
	ldr r10, [fp, #-28]
	str r10, [fp, #-16]
	b .LU0
.LU0:
	ldr r10, [fp, #-16]
	mov r0, r10
	add sp, sp, #28
	pop {r4-r10, fp, pc}
	.size getRands, .-getRands
	.align 2
	.global calcMean
calcMean:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #20
	str r0, [fp, #-8]
	mov r4, #0
	str r4, [fp, #-16]
	mov r4, #0
	str r4, [fp, #-20]
	mov r4, #0
	str r4, [fp, #-24]
	b .LU7
.LU7:
	ldr r5, [fp, #-8]
	mov r4, #0
	cmp r5, r6
	movne r4, #1
	cmp r4, #1
	beq .LU8
	b .LU9
.LU8:
	ldr r4, [fp, #-20]
	mov r5, #1
	add r4, r4, r5
	str r4, [fp, #-20]
	ldr r5, [fp, #-16]
	ldr r4, [fp, #-8]
	mov r4, r4
	ldr r4, [r4]
	add r4, r5, r4
	str r4, [fp, #-16]
	ldr r4, [fp, #-8]
	add r4, r4, #4
	ldr r4, [r4]
	str r4, [fp, #-8]
	ldr r4, [fp, #-8]
	mov r5, #0
	cmp r4, r6
	movne r5, #1
	cmp r5, #1
	beq .LU8
	b .LU9
.LU9:
	ldr r4, [fp, #-20]
	mov r5, #0
	cmp r4, #0
	movne r5, #1
	cmp r5, #1
	beq .LU10
	b .JN0
.LU10:
	ldr r5, [fp, #-16]
	ldr r4, [fp, #-20]
	mov r0, r5
	mov r1, r4
	bl __aeabi_idiv
	mov r10, r0
	str r10, [fp, #-24]
	b .JN0
.JN0:
	ldr r10, [fp, #-24]
	str r10, [fp, #-12]
	b .LU5
.LU5:
	ldr r4, [fp, #-12]
	mov r0, r4
	add sp, sp, #20
	pop {r4-r10, fp, pc}
	.size calcMean, .-calcMean
	.align 2
	.global approxSqrt
approxSqrt:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #20
	str r0, [fp, #-8]
	mov r4, #1
	str r4, [fp, #-16]
	ldr r4, [fp, #-16]
	str r4, [fp, #-24]
	mov r4, #0
	str r4, [fp, #-20]
	b .LU13
.LU13:
	ldr r5, [fp, #-20]
	ldr r4, [fp, #-8]
	mov r6, #0
	cmp r5, r4
	movlt r6, #1
	cmp r6, #1
	beq .LU14
	b .LU15
.LU14:
	ldr r4, [fp, #-16]
	ldr r5, [fp, #-16]
	mul r10, r4, r5
	str r10, [fp, #-20]
	ldr r10, [fp, #-16]
	str r10, [fp, #-24]
	ldr r5, [fp, #-16]
	mov r4, #1
	add r4, r5, r4
	str r4, [fp, #-16]
	ldr r6, [fp, #-20]
	ldr r5, [fp, #-8]
	mov r4, #0
	cmp r6, r5
	movlt r4, #1
	cmp r4, #1
	beq .LU14
	b .LU15
.LU15:
	ldr r4, [fp, #-24]
	str r4, [fp, #-12]
	b .LU11
.LU11:
	ldr r4, [fp, #-12]
	mov r0, r4
	add sp, sp, #20
	pop {r4-r10, fp, pc}
	.size approxSqrt, .-approxSqrt
	.align 2
	.global approxSqrtAll
approxSqrtAll:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #4
	str r0, [fp, #-8]
	b .LU18
.LU18:
	ldr r4, [fp, #-8]
	mov r5, #0
	cmp r4, r6
	movne r5, #1
	cmp r5, #1
	beq .LU19
	b .LU16
.LU19:
	ldr r4, [fp, #-8]
	mov r10, r4
	ldr r4, [r10]
	mov r0, r4
	bl approxSqrt
	mov r10, r0
	mov r1, r10
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r4, [fp, #-8]
	add r4, r4, #4
	ldr r4, [r4]
	str r4, [fp, #-8]
	ldr r4, [fp, #-8]
	mov r5, #0
	cmp r4, r6
	movne r5, #1
	cmp r5, #1
	beq .LU19
	b .LU16
.LU16:
	add sp, sp, #4
	pop {r4-r10, fp, pc}
	.size approxSqrtAll, .-approxSqrtAll
	.align 2
	.global range
range:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #16
	str r0, [fp, #-8]
	mov r4, #0
	str r4, [fp, #-12]
	mov r4, #0
	str r4, [fp, #-16]
	str r5, [fp, #-20]
	b .LU22
.LU22:
	ldr r4, [fp, #-8]
	mov r5, #0
	cmp r4, r7
	movne r5, #1
	cmp r5, #1
	beq .LU23
	b .LU29
.LU23:
	ldr r4, [fp, #-20]
	cmp r4, #1
	beq .LU24
	b .LU25
.LU24:
	ldr r4, [fp, #-8]
	mov r4, r4
	ldr r4, [r4]
	str r4, [fp, #-12]
	ldr r4, [fp, #-8]
	mov r4, r4
	ldr r4, [r4]
	str r4, [fp, #-16]
	str r7, [fp, #-20]
	b .JN3
.JN3:
	ldr r4, [fp, #-8]
	add r4, r4, #4
	ldr r4, [r4]
	str r4, [fp, #-8]
	ldr r4, [fp, #-8]
	mov r5, #0
	cmp r4, r7
	movne r5, #1
	cmp r5, #1
	beq .LU23
	b .LU29
.LU25:
	ldr r4, [fp, #-8]
	mov r4, r4
	ldr r5, [r4]
	ldr r6, [fp, #-12]
	mov r4, #0
	cmp r5, r6
	movlt r4, #1
	cmp r4, #1
	beq .LU26
	b .LU27
.LU26:
	ldr r4, [fp, #-8]
	mov r4, r4
	ldr r4, [r4]
	str r4, [fp, #-12]
	b .JN2
.JN2:
	b .JN3
.LU27:
	ldr r4, [fp, #-8]
	mov r4, r4
	ldr r4, [r4]
	ldr r5, [fp, #-16]
	mov r6, #0
	cmp r4, r5
	movgt r6, #1
	cmp r6, #1
	beq .LU28
	b .JN1
.LU28:
	ldr r4, [fp, #-8]
	mov r4, r4
	ldr r4, [r4]
	str r4, [fp, #-16]
	b .JN1
.JN1:
	b .JN2
.LU29:
	ldr r10, [fp, #-12]
	mov r1, r10
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r10, [fp, #-16]
	mov r1, r10
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU20
.LU20:
	add sp, sp, #16
	pop {r4-r10, fp, pc}
	.size range, .-range
	.align 2
	.global main
main:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #20
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
	ldr r5, [fp, #-12]
	ldr r4, [fp, #-16]
	mov r0, r5
	mov r1, r4
	bl getRands
	mov r4, r0
	str r4, [fp, #-24]
	ldr r4, [fp, #-24]
	mov r0, r4
	bl calcMean
	mov r4, r0
	str r4, [fp, #-20]
	ldr r4, [fp, #-20]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r4, [fp, #-24]
	mov r0, r4
	bl range
	ldr r4, [fp, #-24]
	mov r0, r4
	bl approxSqrtAll
	mov r10, #0
	str r10, [fp, #-8]
	b .LU30
.LU30:
	ldr r10, [fp, #-8]
	mov r0, r10
	add sp, sp, #20
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
