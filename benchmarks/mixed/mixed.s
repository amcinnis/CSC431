	.arch armv6
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"mixed.c"
	.comm	EV_globalfoo,4,4
	.text
	.align	2
	.global	_tailrecursive
	.syntax unified
	.arm
	.fpu vfp
	.type	_tailrecursive, %function
_tailrecursive:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	str	r0, [fp, #-8]
	ldr	r3, [fp, #-8]
	cmp	r3, #0
	ble	.L4
	ldr	r3, [fp, #-8]
	sub	r3, r3, #1
	mov	r0, r3
	bl	_tailrecursive
	b	.L1
.L4:
	nop
.L1:
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
	.size	_tailrecursive, .-_tailrecursive
	.align	2
	.global	_add
	.syntax unified
	.arm
	.fpu vfp
	.type	_add, %function
_add:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	str	r0, [fp, #-8]
	str	r1, [fp, #-12]
	ldr	r2, [fp, #-8]
	ldr	r3, [fp, #-12]
	add	r3, r2, r3
	mov	r0, r3
	add	sp, fp, #0
	@ sp needed
	ldr	fp, [sp], #4
	bx	lr
	.size	_add, .-_add
	.global	__aeabi_idiv
	.align	2
	.global	_domath
	.syntax unified
	.arm
	.fpu vfp
	.type	_domath, %function
_domath:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #24
	str	r0, [fp, #-24]
	mov	r0, #12
	bl	malloc
	mov	r3, r0
	str	r3, [fp, #-8]
	mov	r0, #4
	bl	malloc
	mov	r3, r0
	mov	r2, r3
	ldr	r3, [fp, #-8]
	str	r2, [r3, #8]
	mov	r0, #12
	bl	malloc
	mov	r3, r0
	str	r3, [fp, #-12]
	mov	r0, #4
	bl	malloc
	mov	r3, r0
	mov	r2, r3
	ldr	r3, [fp, #-12]
	str	r2, [r3, #8]
	ldr	r3, [fp, #-8]
	ldr	r2, [fp, #-24]
	str	r2, [r3]
	ldr	r3, [fp, #-12]
	mov	r2, #3
	str	r2, [r3]
	ldr	r3, [fp, #-8]
	ldr	r3, [r3, #8]
	ldr	r2, [fp, #-8]
	ldr	r2, [r2]
	str	r2, [r3]
	ldr	r3, [fp, #-12]
	ldr	r3, [r3, #8]
	ldr	r2, [fp, #-12]
	ldr	r2, [r2]
	str	r2, [r3]
	b	.L8
.L9:
	ldr	r3, [fp, #-8]
	ldr	r3, [r3]
	ldr	r2, [fp, #-12]
	ldr	r2, [r2]
	mul	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-8]
	ldr	r3, [r3, #8]
	ldr	r3, [r3]
	ldr	r2, [fp, #-16]
	mul	r2, r2, r3
	ldr	r3, [fp, #-12]
	ldr	r3, [r3]
	mov	r1, r3
	mov	r0, r2
	bl	__aeabi_idiv
	mov	r3, r0
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-12]
	ldr	r3, [r3, #8]
	ldr	r2, [r3]
	ldr	r3, [fp, #-8]
	ldr	r3, [r3]
	mov	r1, r3
	mov	r0, r2
	bl	_add
	str	r0, [fp, #-16]
	ldr	r3, [fp, #-12]
	ldr	r2, [r3]
	ldr	r3, [fp, #-8]
	ldr	r3, [r3]
	sub	r3, r2, r3
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-24]
	sub	r3, r3, #1
	str	r3, [fp, #-24]
.L8:
	ldr	r3, [fp, #-24]
	cmp	r3, #0
	bgt	.L9
	ldr	r0, [fp, #-8]
	bl	free
	ldr	r0, [fp, #-12]
	bl	free
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
	.size	_domath, .-_domath
	.align	2
	.global	_objinstantiation
	.syntax unified
	.arm
	.fpu vfp
	.type	_objinstantiation, %function
_objinstantiation:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	str	r0, [fp, #-16]
	b	.L11
.L12:
	mov	r0, #12
	bl	malloc
	mov	r3, r0
	str	r3, [fp, #-8]
	ldr	r0, [fp, #-8]
	bl	free
	ldr	r3, [fp, #-16]
	sub	r3, r3, #1
	str	r3, [fp, #-16]
.L11:
	ldr	r3, [fp, #-16]
	cmp	r3, #0
	bgt	.L12
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
	.size	_objinstantiation, .-_objinstantiation
	.align	2
	.global	_ackermann
	.syntax unified
	.arm
	.fpu vfp
	.type	_ackermann, %function
_ackermann:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{r4, fp, lr}
	add	fp, sp, #8
	sub	sp, sp, #12
	str	r0, [fp, #-16]
	str	r1, [fp, #-20]
	ldr	r3, [fp, #-16]
	cmp	r3, #0
	bne	.L14
	ldr	r3, [fp, #-20]
	add	r3, r3, #1
	b	.L15
.L14:
	ldr	r3, [fp, #-20]
	cmp	r3, #0
	bne	.L16
	ldr	r3, [fp, #-16]
	sub	r3, r3, #1
	mov	r1, #1
	mov	r0, r3
	bl	_ackermann
	mov	r3, r0
	b	.L15
.L16:
	ldr	r3, [fp, #-16]
	sub	r4, r3, #1
	ldr	r3, [fp, #-20]
	sub	r3, r3, #1
	mov	r1, r3
	ldr	r0, [fp, #-16]
	bl	_ackermann
	mov	r3, r0
	mov	r1, r3
	mov	r0, r4
	bl	_ackermann
	mov	r3, r0
.L15:
	mov	r0, r3
	sub	sp, fp, #8
	@ sp needed
	pop	{r4, fp, pc}
	.size	_ackermann, .-_ackermann
	.section	.rodata
	.align	2
.LC0:
	.ascii	"%d\000"
	.align	2
.LC1:
	.ascii	"%d\012\000"
	.text
	.align	2
	.global	_main
	.syntax unified
	.arm
	.fpu vfp
	.type	_main, %function
_main:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #24
	sub	r3, fp, #8
	mov	r1, r3
	ldr	r0, .L19
	bl	__isoc99_scanf
	sub	r3, fp, #12
	mov	r1, r3
	ldr	r0, .L19
	bl	__isoc99_scanf
	sub	r3, fp, #16
	mov	r1, r3
	ldr	r0, .L19
	bl	__isoc99_scanf
	sub	r3, fp, #20
	mov	r1, r3
	ldr	r0, .L19
	bl	__isoc99_scanf
	sub	r3, fp, #24
	mov	r1, r3
	ldr	r0, .L19
	bl	__isoc99_scanf
	ldr	r3, [fp, #-8]
	mov	r0, r3
	bl	_tailrecursive
	ldr	r3, [fp, #-8]
	mov	r1, r3
	ldr	r0, .L19+4
	bl	printf
	ldr	r3, [fp, #-12]
	mov	r0, r3
	bl	_domath
	ldr	r3, [fp, #-12]
	mov	r1, r3
	ldr	r0, .L19+4
	bl	printf
	ldr	r3, [fp, #-16]
	mov	r0, r3
	bl	_objinstantiation
	ldr	r3, [fp, #-16]
	mov	r1, r3
	ldr	r0, .L19+4
	bl	printf
	ldr	r3, [fp, #-20]
	ldr	r2, [fp, #-24]
	mov	r1, r2
	mov	r0, r3
	bl	_ackermann
	mov	r3, r0
	mov	r1, r3
	ldr	r0, .L19+4
	bl	printf
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L20:
	.align	2
.L19:
	.word	.LC0
	.word	.LC1
	.size	_main, .-_main
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu vfp
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	bl	_main
	mov	r3, r0
	mov	r0, r3
	pop	{fp, pc}
	.size	main, .-main
	.ident	"GCC: (Raspbian 6.3.0-18+rpi1+deb9u1) 6.3.0 20170516"
	.section	.note.GNU-stack,"",%progbits
