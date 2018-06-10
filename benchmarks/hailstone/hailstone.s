	.arch armv7-a
	.text

	.align 2
	.global mod
mod:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #12
	str r0, [fp, #-8]
	str r1, [fp, #-12]
	ldr r4, [fp, #-8]
	ldr r6, [fp, #-8]
	ldr r5, [fp, #-12]
	mov r0, r6
	mov r1, r5
	bl __aeabi_idiv
	mov r6, r0
	ldr r5, [fp, #-12]
	mul r5, r6, r5
	sub r10, r4, r5
	str r10, [fp, #-16]
	b .LU0
.LU0:
	ldr r10, [fp, #-16]
	mov r0, r10
	add sp, sp, #12
	pop {r4-r10, fp, pc}
	.size mod, .-mod
	.align 2
	.global hailstone
hailstone:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #4
	str r0, [fp, #-8]
	b .LU4
.LU4:
	b .LU5
.LU5:
	ldr r4, [fp, #-8]
	mov r1, r4
	movw r0, #:lower16:.PRINT_FMT
	movt r0, #:upper16:.PRINT_FMT
	bl printf
	b .LU6
.LU6:
	ldr r4, [fp, #-8]
	mov r0, r4
	mov r1, #2
	bl mod
	mov r4, r0
	mov r5, #0
	cmp r4, #1
	moveq r5, #1
	cmp r5, #1
	beq .LU7
	b .LU8
.LU7:
	ldr r4, [fp, #-8]
	mov r5, #3
	mul r5, r5, r4
	mov r4, #1
	add r10, r5, r4
	str r10, [fp, #-8]
	b .JN0
.JN0:
	b .LU9
.LU9:
	ldr r5, [fp, #-8]
	mov r4, #0
	cmp r5, #1
	movle r4, #1
	cmp r4, #1
	beq .LU10
	b .JN1
.LU10:
	ldr r4, [fp, #-8]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU2
.JN1:
	b .LU4
.LU8:
	ldr r5, [fp, #-8]
	mov r4, #2
	mov r0, r5
	mov r1, r4
	bl __aeabi_idiv
	mov r10, r0
	str r10, [fp, #-8]
	b .JN0
.LU2:
	add sp, sp, #4
	pop {r4-r10, fp, pc}
	.size hailstone, .-hailstone
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
	bl hailstone
	mov r10, #0
	str r10, [fp, #-8]
	b .LU11
.LU11:
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
