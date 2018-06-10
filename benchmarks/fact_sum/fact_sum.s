	.arch armv7-a
	.text

	.align 2
	.global sum
sum:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #12
	str r0, [fp, #-8]
	str r1, [fp, #-12]
	ldr r5, [fp, #-8]
	ldr r4, [fp, #-12]
	add r10, r5, r4
	str r10, [fp, #-16]
	b .LU0
.LU0:
	ldr r10, [fp, #-16]
	mov r0, r10
	add sp, sp, #12
	pop {r4-r10, fp, pc}
	.size sum, .-sum
	.align 2
	.global fact
fact:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #12
	str r0, [fp, #-8]
	b .LU4
.LU4:
	ldr r4, [fp, #-8]
	mov r6, #0
	cmp r4, #1
	moveq r6, #1
	ldr r5, [fp, #-8]
	mov r4, #0
	cmp r5, #0
	moveq r4, #1
	orr r4, r6, r4
	cmp r4, #1
	beq .LU5
	b .JN0
.LU5:
	mov r4, #1
	str r4, [fp, #-12]
	b .LU2
.JN0:
	b .LU6
.LU6:
	ldr r5, [fp, #-8]
	mov r4, #0
	cmp r5, #1
	movle r4, #1
	cmp r4, #1
	beq .LU7
	b .JN1
.LU7:
	ldr r4, [fp, #-8]
	mul r4, #-1, r4
	mov r0, r4
	bl fact
	mov r4, r0
	str r4, [fp, #-12]
	b .LU2
.JN1:
	ldr r4, [fp, #-8]
	ldr r5, [fp, #-8]
	sub r5, r5, #1
	mov r0, r5
	bl fact
	mov r5, r0
	mul r10, r4, r5
	str r10, [fp, #-16]
	ldr r10, [fp, #-16]
	str r10, [fp, #-12]
	b .LU2
.LU2:
	ldr r4, [fp, #-12]
	mov r0, r4
	add sp, sp, #12
	pop {r4-r10, fp, pc}
	.size fact, .-fact
	.align 2
	.global main
main:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #16
	mov r4, #0
	str r4, [fp, #-20]
	b .LU10
.LU10:
	ldr r4, [fp, #-20]
	mov r5, #0
	cmp r4, #-1
	movne r5, #1
	cmp r5, #1
	beq .LU11
	b .LU12
.LU11:
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
	ldr r4, [fp, #-12]
	mov r0, r4
	bl fact
	mov r4, r0
	str r4, [fp, #-12]
	ldr r4, [fp, #-16]
	mov r0, r4
	bl fact
	mov r4, r0
	str r4, [fp, #-16]
	ldr r5, [fp, #-12]
	ldr r4, [fp, #-16]
	mov r0, r5
	mov r1, r4
	bl sum
	mov r4, r0
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r0, #:lower16:.read_scratch
	movt r0, #:upper16:.read_scratch
	ldr r0, [r0]
	str r0, [fp, #-20]
	ldr r4, [fp, #-20]
	mov r5, #0
	cmp r4, #-1
	movne r5, #1
	cmp r5, #1
	beq .LU11
	b .LU12
.LU12:
	mov r10, #0
	str r10, [fp, #-8]
	b .LU8
.LU8:
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
