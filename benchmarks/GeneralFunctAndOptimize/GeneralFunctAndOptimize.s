	.arch armv7-a
	.comm	interval,4,4
	.comm	end,4,4
	.text

	.align 2
	.global multBy4xTimes
multBy4xTimes:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #12
	str r0, [fp, #-8]
	str r1, [fp, #-12]
	b .LU2
.LU2:
	ldr r5, [fp, #-12]
	mov r4, #0
	cmp r5, #0
	movle r4, #1
	cmp r4, #1
	beq .LU3
	b .JN0
.LU3:
	ldr r4, [fp, #-8]
	mov r4, r4
	ldr r4, [r4]
	str r4, [fp, #-16]
	b .LU0
.JN0:
	ldr r4, [fp, #-8]
	mov r4, r4
	ldr r5, [r4]
	mov r4, #4
	mul r5, r4, r5
	ldr r4, [fp, #-8]
	mov r4, r4
	str r5, [r4]
	ldr r6, [fp, #-8]
	ldr r5, [fp, #-12]
	mov r4, #1
	sub r4, r5, r4
	mov r0, r6
	mov r1, r4
	bl multBy4xTimes
	mov r10, r0
	ldr r4, [fp, #-8]
	mov r4, r4
	ldr r10, [r4]
	str r10, [fp, #-16]
	b .LU0
.LU0:
	ldr r4, [fp, #-16]
	mov r0, r4
	add sp, sp, #12
	pop {r4-r10, fp, pc}
	.size multBy4xTimes, .-multBy4xTimes
	.align 2
	.global divideBy8
divideBy8:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #4
	str r0, [fp, #-8]
	ldr r4, [fp, #-8]
	mov r4, r4
	ldr r5, [r4]
	mov r4, #2
	mov r0, r5
	mov r1, r4
	bl __aeabi_idiv
	mov r5, r0
	ldr r4, [fp, #-8]
	mov r4, r4
	str r5, [r4]
	ldr r4, [fp, #-8]
	mov r4, r4
	ldr r5, [r4]
	mov r4, #2
	mov r0, r5
	mov r1, r4
	bl __aeabi_idiv
	mov r5, r0
	ldr r4, [fp, #-8]
	mov r4, r4
	str r5, [r4]
	ldr r4, [fp, #-8]
	mov r4, r4
	ldr r5, [r4]
	mov r4, #2
	mov r0, r5
	mov r1, r4
	bl __aeabi_idiv
	mov r4, r0
	ldr r10, [fp, #-8]
	mov r10, r10
	str r4, [r10]
	b .LU4
.LU4:
	add sp, sp, #4
	pop {r4-r10, fp, pc}
	.size divideBy8, .-divideBy8
	.align 2
	.global main
main:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #40
	movw r0, #4
	bl malloc
	mov r4, r0
	mov r4, r4
	str r4, [fp, #-36]
	mov r4, #1000000
	str r4, [r8]
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
	ldr r7, [r0]
	ldr r4, [fp, #-12]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r4, [r7]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r4, #0
	str r4, [fp, #-16]
	mov r4, #0
	str r4, [fp, #-20]
	mov r4, #0
	str r4, [fp, #-24]
	b .LU8
.LU8:
	ldr r4, [fp, #-16]
	mov r5, #0
	cmp r4, #50
	movlt r5, #1
	cmp r5, #1
	beq .LU9
	b .LU15
.LU9:
	mov r4, #0
	str r4, [fp, #-20]
	b .LU10
.LU10:
	ldr r4, [fp, #-20]
	ldr r6, [r8]
	mov r5, #0
	cmp r4, r6
	movle r5, #1
	cmp r5, #1
	beq .LU11
	b .LU14
.LU11:
	mov r5, #1
	mov r4, #2
	mul r4, r5, r4
	mov r5, #3
	mul r4, r4, r5
	mov r5, #4
	mul r4, r4, r5
	mov r5, #5
	mul r4, r4, r5
	mov r5, #6
	mul r5, r4, r5
	mov r4, #7
	mul r5, r5, r4
	mov r4, #8
	mul r5, r5, r4
	mov r4, #9
	mul r5, r5, r4
	mov r4, #10
	mul r5, r5, r4
	mov r4, #11
	mul r4, r5, r4
	str r4, [fp, #-24]
	ldr r5, [fp, #-20]
	mov r4, #1
	add r4, r5, r4
	str r4, [fp, #-20]
	ldr r5, [fp, #-20]
	ldr r4, [fp, #-36]
	mov r4, r4
	str r5, [r4]
	ldr r4, [fp, #-36]
	mov r4, r4
	ldr r4, [r4]
	str r4, [fp, #-28]
	ldr r4, [fp, #-36]
	mov r0, r4
	mov r1, #2
	bl multBy4xTimes
	mov r4, r0
	ldr r4, [fp, #-36]
	mov r0, r4
	bl divideBy8
	ldr r5, [r7]
	mov r4, #1
	sub r4, r5, r4
	str r4, [fp, #-32]
	ldr r5, [fp, #-32]
	mov r4, #0
	cmp r5, #0
	movle r4, #1
	str r4, [fp, #-40]
	b .LU12
.LU12:
	ldr r5, [fp, #-32]
	mov r4, #0
	cmp r5, #0
	movle r4, #1
	cmp r4, #1
	beq .LU13
	b .JN1
.LU13:
	mov r4, #1
	str r4, [fp, #-32]
	b .JN1
.JN1:
	ldr r5, [fp, #-20]
	ldr r4, [fp, #-32]
	add r4, r5, r4
	str r4, [fp, #-20]
	ldr r4, [fp, #-20]
	ldr r6, [r8]
	mov r5, #0
	cmp r4, r6
	movle r5, #1
	cmp r5, #1
	beq .LU11
	b .LU14
.LU14:
	ldr r5, [fp, #-16]
	mov r4, #1
	add r4, r5, r4
	str r4, [fp, #-16]
	ldr r4, [fp, #-16]
	mov r5, #0
	cmp r4, #50
	movlt r5, #1
	cmp r5, #1
	beq .LU9
	b .LU15
.LU15:
	ldr r4, [fp, #-20]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r4, [fp, #-24]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r10, #0
	str r10, [fp, #-8]
	b .LU6
.LU6:
	ldr r10, [fp, #-8]
	mov r0, r10
	add sp, sp, #40
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
