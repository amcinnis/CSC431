	.arch armv7-a
	.text

	.align 2
	.global getIntList
getIntList:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #12
	movw r0, #8
	bl malloc
	mov r5, r0
	mov r5, r5
	str r5, [fp, #-12]
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r0, #:lower16:.read_scratch
	movt r0, #:upper16:.read_scratch
	ldr r0, [r0]
	str r0, [fp, #-16]
	b .LU2
.LU2:
	ldr r6, [fp, #-16]
	mov r5, #0
	cmp r6, #-1
	moveq r5, #1
	cmp r5, #1
	beq .LU3
	b .LU4
.LU3:
	ldr r6, [fp, #-16]
	ldr r5, [fp, #-12]
	mov r5, r5
	str r6, [r5]
	ldr r5, [fp, #-12]
	add r5, r5, #4
	str r4, [r5]
	ldr r4, [fp, #-12]
	str r4, [fp, #-8]
	b .LU0
.LU4:
	ldr r4, [fp, #-16]
	ldr r5, [fp, #-12]
	mov r5, r5
	str r4, [r5]
	bl getIntList
	mov r5, r0
	ldr r4, [fp, #-12]
	add r4, r4, #4
	str r5, [r4]
	ldr r10, [fp, #-12]
	str r10, [fp, #-8]
	b .LU0
.LU0:
	ldr r10, [fp, #-8]
	mov r0, r10
	add sp, sp, #12
	pop {r4-r10, fp, pc}
	.size getIntList, .-getIntList
	.align 2
	.global biggest
biggest:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #12
	str r0, [fp, #-8]
	str r1, [fp, #-12]
	b .LU7
.LU7:
	ldr r6, [fp, #-8]
	ldr r5, [fp, #-12]
	mov r4, #0
	cmp r6, r5
	movgt r4, #1
	cmp r4, #1
	beq .LU8
	b .LU9
.LU8:
	ldr r4, [fp, #-8]
	str r4, [fp, #-16]
	b .LU5
.LU9:
	ldr r10, [fp, #-12]
	str r10, [fp, #-16]
	b .LU5
.LU5:
	ldr r10, [fp, #-16]
	mov r0, r10
	add sp, sp, #12
	pop {r4-r10, fp, pc}
	.size biggest, .-biggest
	.align 2
	.global biggestInList
biggestInList:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #12
	str r0, [fp, #-8]
	ldr r5, [fp, #-8]
	mov r5, r5
	ldr r5, [r5]
	str r5, [fp, #-16]
	b .LU12
.LU12:
	ldr r5, [fp, #-8]
	add r5, r5, #4
	ldr r5, [r5]
	mov r6, #0
	cmp r5, r4
	movne r6, #1
	cmp r6, #1
	beq .LU13
	b .LU14
.LU13:
	ldr r6, [fp, #-16]
	ldr r5, [fp, #-8]
	mov r5, r5
	ldr r5, [r5]
	mov r0, r6
	mov r1, r5
	bl biggest
	mov r5, r0
	str r5, [fp, #-16]
	ldr r5, [fp, #-8]
	add r5, r5, #4
	ldr r5, [r5]
	str r5, [fp, #-8]
	ldr r5, [fp, #-8]
	add r5, r5, #4
	ldr r5, [r5]
	mov r6, #0
	cmp r5, r4
	movne r6, #1
	cmp r6, #1
	beq .LU13
	b .LU14
.LU14:
	ldr r10, [fp, #-16]
	str r10, [fp, #-12]
	b .LU10
.LU10:
	ldr r10, [fp, #-12]
	mov r0, r10
	add sp, sp, #12
	pop {r4-r10, fp, pc}
	.size biggestInList, .-biggestInList
	.align 2
	.global main
main:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #8
	bl getIntList
	mov r4, r0
	str r4, [fp, #-12]
	ldr r4, [fp, #-12]
	mov r0, r4
	bl biggestInList
	mov r4, r0
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r10, #0
	str r10, [fp, #-8]
	b .LU15
.LU15:
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
