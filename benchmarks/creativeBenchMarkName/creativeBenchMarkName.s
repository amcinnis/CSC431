	.arch armv7-a
	.text

	.align 2
	.global buildList
buildList:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #36
	movw r0, #8
	bl malloc
	mov r5, r0
	mov r5, r5
	str r5, [fp, #-20]
	movw r0, #8
	bl malloc
	mov r5, r0
	mov r5, r5
	str r5, [fp, #-24]
	movw r0, #8
	bl malloc
	mov r5, r0
	mov r5, r5
	str r5, [fp, #-28]
	movw r0, #8
	bl malloc
	mov r5, r0
	mov r5, r5
	str r5, [fp, #-32]
	movw r0, #8
	bl malloc
	mov r5, r0
	mov r5, r5
	str r5, [fp, #-36]
	movw r0, #8
	bl malloc
	mov r5, r0
	mov r5, r5
	str r5, [fp, #-40]
	ldr r5, [fp, #-20]
	mov r5, r5
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r0, #:lower16:.read_scratch
	movt r0, #:upper16:.read_scratch
	ldr r5, [r0]
	ldr r5, [fp, #-24]
	mov r5, r5
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r0, #:lower16:.read_scratch
	movt r0, #:upper16:.read_scratch
	ldr r5, [r0]
	ldr r5, [fp, #-28]
	mov r5, r5
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r0, #:lower16:.read_scratch
	movt r0, #:upper16:.read_scratch
	ldr r5, [r0]
	ldr r5, [fp, #-32]
	mov r5, r5
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r0, #:lower16:.read_scratch
	movt r0, #:upper16:.read_scratch
	ldr r5, [r0]
	ldr r5, [fp, #-36]
	mov r5, r5
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r0, #:lower16:.read_scratch
	movt r0, #:upper16:.read_scratch
	ldr r5, [r0]
	ldr r5, [fp, #-40]
	mov r5, r5
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r0, #:lower16:.read_scratch
	movt r0, #:upper16:.read_scratch
	ldr r5, [r0]
	ldr r6, [fp, #-24]
	ldr r5, [fp, #-20]
	add r5, r5, #4
	str r6, [r5]
	ldr r5, [fp, #-28]
	ldr r6, [fp, #-24]
	add r6, r6, #4
	str r5, [r6]
	ldr r5, [fp, #-32]
	ldr r6, [fp, #-28]
	add r6, r6, #4
	str r5, [r6]
	ldr r6, [fp, #-36]
	ldr r5, [fp, #-32]
	add r5, r5, #4
	str r6, [r5]
	ldr r6, [fp, #-40]
	ldr r5, [fp, #-36]
	add r5, r5, #4
	str r6, [r5]
	ldr r5, [fp, #-40]
	add r5, r5, #4
	str r4, [r5]
	ldr r10, [fp, #-20]
	str r10, [fp, #-8]
	b .LU0
.LU0:
	ldr r10, [fp, #-8]
	mov r0, r10
	add sp, sp, #36
	pop {r4-r10, fp, pc}
	.size buildList, .-buildList
	.align 2
	.global multiple
multiple:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #20
	str r0, [fp, #-8]
	mov r4, #0
	str r4, [fp, #-16]
	ldr r4, [fp, #-8]
	str r4, [fp, #-24]
	ldr r4, [fp, #-24]
	mov r4, r4
	ldr r4, [r4]
	str r4, [fp, #-20]
	ldr r4, [fp, #-24]
	add r4, r4, #4
	ldr r4, [r4]
	str r4, [fp, #-24]
	b .LU4
.LU4:
	ldr r5, [fp, #-16]
	mov r4, #0
	cmp r5, #5
	movlt r4, #1
	cmp r4, #1
	beq .LU5
	b .LU6
.LU5:
	ldr r4, [fp, #-20]
	ldr r5, [fp, #-24]
	mov r5, r5
	ldr r5, [r5]
	mul r4, r4, r5
	str r4, [fp, #-20]
	ldr r4, [fp, #-24]
	add r4, r4, #4
	ldr r4, [r4]
	str r4, [fp, #-24]
	ldr r4, [fp, #-20]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r4, [fp, #-16]
	mov r5, #1
	add r4, r4, r5
	str r4, [fp, #-16]
	ldr r4, [fp, #-16]
	mov r5, #0
	cmp r4, #5
	movlt r5, #1
	cmp r5, #1
	beq .LU5
	b .LU6
.LU6:
	ldr r10, [fp, #-20]
	str r10, [fp, #-12]
	b .LU2
.LU2:
	ldr r10, [fp, #-12]
	mov r0, r10
	add sp, sp, #20
	pop {r4-r10, fp, pc}
	.size multiple, .-multiple
	.align 2
	.global add
add:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #20
	str r0, [fp, #-8]
	mov r4, #0
	str r4, [fp, #-16]
	ldr r4, [fp, #-8]
	str r4, [fp, #-24]
	ldr r4, [fp, #-24]
	mov r4, r4
	ldr r4, [r4]
	str r4, [fp, #-20]
	ldr r4, [fp, #-24]
	add r4, r4, #4
	ldr r4, [r4]
	str r4, [fp, #-24]
	b .LU9
.LU9:
	ldr r4, [fp, #-16]
	mov r5, #0
	cmp r4, #5
	movlt r5, #1
	cmp r5, #1
	beq .LU10
	b .LU11
.LU10:
	ldr r4, [fp, #-20]
	ldr r5, [fp, #-24]
	mov r5, r5
	ldr r5, [r5]
	add r4, r4, r5
	str r4, [fp, #-20]
	ldr r4, [fp, #-24]
	add r4, r4, #4
	ldr r4, [r4]
	str r4, [fp, #-24]
	ldr r4, [fp, #-20]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r4, [fp, #-16]
	mov r5, #1
	add r4, r4, r5
	str r4, [fp, #-16]
	ldr r4, [fp, #-16]
	mov r5, #0
	cmp r4, #5
	movlt r5, #1
	cmp r5, #1
	beq .LU10
	b .LU11
.LU11:
	ldr r10, [fp, #-20]
	str r10, [fp, #-12]
	b .LU7
.LU7:
	ldr r10, [fp, #-12]
	mov r0, r10
	add sp, sp, #20
	pop {r4-r10, fp, pc}
	.size add, .-add
	.align 2
	.global recurseList
recurseList:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #8
	str r0, [fp, #-8]
	b .LU14
.LU14:
	ldr r4, [fp, #-8]
	add r4, r4, #4
	ldr r5, [r4]
	mov r4, #0
	cmp r5, r6
	moveq r4, #1
	cmp r4, #1
	beq .LU15
	b .LU16
.LU15:
	ldr r4, [fp, #-8]
	mov r4, r4
	ldr r4, [r4]
	str r4, [fp, #-12]
	b .LU12
.JN0:
	b .LU12
.LU16:
	ldr r4, [fp, #-8]
	mov r4, r4
	ldr r4, [r4]
	ldr r5, [fp, #-8]
	add r5, r5, #4
	ldr r5, [r5]
	mov r0, r5
	bl recurseList
	mov r5, r0
	mul r10, r4, r5
	str r10, [fp, #-12]
	b .LU12
.LU12:
	ldr r10, [fp, #-12]
	mov r0, r10
	add sp, sp, #8
	pop {r4-r10, fp, pc}
	.size recurseList, .-recurseList
	.align 2
	.global main
main:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #28
	mov r4, #0
	str r4, [fp, #-32]
	mov r4, #0
	str r4, [fp, #-28]
	bl buildList
	mov r4, r0
	str r4, [fp, #-12]
	ldr r4, [fp, #-12]
	mov r0, r4
	bl multiple
	mov r4, r0
	str r4, [fp, #-16]
	ldr r4, [fp, #-12]
	mov r0, r4
	bl add
	mov r4, r0
	str r4, [fp, #-20]
	ldr r4, [fp, #-16]
	ldr r6, [fp, #-20]
	mov r5, #2
	mov r0, r6
	mov r1, r5
	bl __aeabi_idiv
	mov r5, r0
	sub r4, r4, r5
	str r4, [fp, #-24]
	b .LU19
.LU19:
	ldr r4, [fp, #-32]
	mov r5, #0
	cmp r4, #2
	movlt r5, #1
	cmp r5, #1
	beq .LU20
	b .LU21
.LU20:
	ldr r4, [fp, #-28]
	ldr r5, [fp, #-12]
	mov r0, r5
	bl recurseList
	mov r5, r0
	add r4, r4, r5
	str r4, [fp, #-28]
	ldr r4, [fp, #-32]
	mov r5, #1
	add r4, r4, r5
	str r4, [fp, #-32]
	ldr r4, [fp, #-32]
	mov r5, #0
	cmp r4, #2
	movlt r5, #1
	cmp r5, #1
	beq .LU20
	b .LU21
.LU21:
	ldr r4, [fp, #-28]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU22
.LU22:
	ldr r4, [fp, #-28]
	mov r5, #0
	cmp r4, #0
	movne r5, #1
	cmp r5, #1
	beq .LU23
	b .LU24
.LU23:
	ldr r4, [fp, #-28]
	mov r5, #1
	sub r4, r4, r5
	str r4, [fp, #-28]
	ldr r4, [fp, #-28]
	mov r5, #0
	cmp r4, #0
	movne r5, #1
	cmp r5, #1
	beq .LU23
	b .LU24
.LU24:
	ldr r4, [fp, #-24]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r4, [fp, #-28]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r10, #0
	str r10, [fp, #-8]
	b .LU17
.LU17:
	ldr r10, [fp, #-8]
	mov r0, r10
	add sp, sp, #28
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
