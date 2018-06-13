	.arch armv7-a
	.comm	swapped,4,4
	.text

	.align 2
	.global compare
compare:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #12
	str r0, [fp, #-8]
	str r1, [fp, #-12]
	ldr r10, [fp, #-8]
	mov r10, r10
	ldr r5, [r10]
	ldr r4, [fp, #-12]
	mov r4, r4
	ldr r4, [r4]
	sub r4, r5, r4
	str r4, [fp, #-16]
	b .LU0
.LU0:
	ldr r4, [fp, #-16]
	mov r0, r4
	add sp, sp, #12
	pop {r4-r10, fp, pc}
	.size compare, .-compare
	.align 2
	.global deathSort
deathSort:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #16
	str r0, [fp, #-8]
	mov r4, #1
	str r4, [fp, #-12]
	b .LU4
.LU4:
	ldr r5, [fp, #-12]
	mov r4, #0
	cmp r5, #1
	moveq r4, #1
	cmp r4, #1
	beq .LU5
	b .LU2
.LU5:
	mov r4, #0
	str r4, [fp, #-12]
	ldr r4, [fp, #-8]
	str r4, [fp, #-20]
	b .LU6
.LU6:
	ldr r10, [fp, #-20]
	add r10, r10, #8
	ldr r6, [r10]
	ldr r5, [fp, #-8]
	mov r4, #0
	cmp r6, r5
	movne r4, #1
	cmp r4, #1
	beq .LU7
	b .LU4
.LU7:
	ldr r5, [fp, #-20]
	ldr r4, [fp, #-20]
	add r4, r4, #8
	ldr r4, [r4]
	mov r0, r5
	mov r1, r4
	bl compare
	mov r5, r0
	mov r4, #0
	cmp r5, #0
	movgt r4, #1
	cmp r4, #1
	beq .LU8
	b .JN0
.LU8:
	ldr r4, [fp, #-20]
	mov r4, r4
	ldr r4, [r4]
	str r4, [fp, #-16]
	ldr r4, [fp, #-20]
	add r4, r4, #8
	ldr r4, [r4]
	mov r4, r4
	ldr r4, [r4]
	ldr r5, [fp, #-20]
	mov r5, r5
	str r4, [r5]
	ldr r4, [fp, #-16]
	ldr r5, [fp, #-20]
	add r5, r5, #8
	ldr r5, [r5]
	mov r5, r5
	str r4, [r5]
	mov r4, #1
	str r4, [fp, #-12]
	b .JN0
.JN0:
	ldr r4, [fp, #-20]
	add r4, r4, #8
	ldr r4, [r4]
	str r4, [fp, #-20]
	ldr r4, [fp, #-20]
	add r4, r4, #8
	ldr r5, [r4]
	ldr r4, [fp, #-8]
	mov r6, #0
	cmp r5, r4
	movne r6, #1
	cmp r6, #1
	beq .LU7
	b .LU4
.LU2:
	add sp, sp, #16
	pop {r4-r10, fp, pc}
	.size deathSort, .-deathSort
	.align 2
	.global printEVILList
printEVILList:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #12
	str r0, [fp, #-8]
	ldr r4, [fp, #-8]
	add r4, r4, #8
	ldr r4, [r4]
	str r4, [fp, #-12]
	ldr r4, [fp, #-8]
	mov r4, r4
	ldr r4, [r4]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r4, [fp, #-8]
	mov r4, r4
	mov r0, r4
	bl free
	b .LU11
.LU11:
	ldr r5, [fp, #-12]
	ldr r4, [fp, #-8]
	mov r6, #0
	cmp r5, r4
	movne r6, #1
	cmp r6, #1
	beq .LU12
	b .LU9
.LU12:
	ldr r10, [fp, #-12]
	str r10, [fp, #-16]
	ldr r10, [fp, #-12]
	mov r4, r10
	ldr r4, [r4]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r4, [fp, #-12]
	add r4, r4, #8
	ldr r4, [r4]
	str r4, [fp, #-12]
	ldr r4, [fp, #-16]
	mov r4, r4
	mov r0, r4
	bl free
	ldr r4, [fp, #-12]
	ldr r6, [fp, #-8]
	mov r5, #0
	cmp r4, r6
	movne r5, #1
	cmp r5, #1
	beq .LU12
	b .LU9
.LU9:
	add sp, sp, #12
	pop {r4-r10, fp, pc}
	.size printEVILList, .-printEVILList
	.align 2
	.global main
main:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #24
	mov r4, #666
	str r4, [r5]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r0, #:lower16:.read_scratch
	movt r0, #:upper16:.read_scratch
	ldr r0, [r0]
	str r0, [fp, #-12]
	b .LU15
.LU15:
	ldr r4, [fp, #-12]
	mov r5, #0
	cmp r4, #0
	movle r5, #1
	cmp r5, #1
	beq .LU16
	b .JN1
.LU16:
	mov r1, r6
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r4, #-1
	str r4, [fp, #-8]
	b .LU13
.JN1:
	ldr r4, [fp, #-12]
	movw r5, #lower16:1000
	movt r5, #upper16:1000
	mul r4, r4, r5
	str r4, [fp, #-12]
	ldr r4, [fp, #-12]
	str r4, [fp, #-16]
	movw r0, #12
	bl malloc
	mov r4, r0
	mov r4, r4
	str r4, [fp, #-24]
	ldr r5, [fp, #-16]
	ldr r4, [fp, #-24]
	mov r4, r4
	str r5, [r4]
	ldr r5, [fp, #-24]
	ldr r4, [fp, #-24]
	add r4, r4, #4
	str r5, [r4]
	ldr r5, [fp, #-24]
	ldr r4, [fp, #-24]
	add r4, r4, #8
	str r5, [r4]
	ldr r4, [fp, #-16]
	mov r5, #1
	sub r4, r4, r5
	str r4, [fp, #-16]
	ldr r4, [fp, #-24]
	str r4, [fp, #-28]
	b .LU17
.LU17:
	ldr r4, [fp, #-16]
	mov r5, #0
	cmp r4, #0
	movgt r5, #1
	cmp r5, #1
	beq .LU18
	b .LU19
.LU18:
	movw r0, #12
	bl malloc
	mov r4, r0
	mov r4, r4
	str r4, [fp, #-20]
	ldr r5, [fp, #-16]
	ldr r4, [fp, #-20]
	mov r4, r4
	str r5, [r4]
	ldr r4, [fp, #-28]
	ldr r5, [fp, #-20]
	add r5, r5, #4
	str r4, [r5]
	ldr r5, [fp, #-24]
	ldr r4, [fp, #-20]
	add r4, r4, #8
	str r5, [r4]
	ldr r4, [fp, #-20]
	ldr r5, [fp, #-28]
	add r5, r5, #8
	str r4, [r5]
	ldr r4, [fp, #-20]
	str r4, [fp, #-28]
	ldr r4, [fp, #-16]
	mov r5, #1
	sub r4, r4, r5
	str r4, [fp, #-16]
	ldr r4, [fp, #-16]
	mov r5, #0
	cmp r4, #0
	movgt r5, #1
	cmp r5, #1
	beq .LU18
	b .LU19
.LU19:
	ldr r4, [fp, #-24]
	mov r0, r4
	bl deathSort
	ldr r4, [fp, #-24]
	mov r0, r4
	bl printEVILList
	mov r10, #0
	str r10, [fp, #-8]
	b .LU13
.LU13:
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
