	.arch armv7-a
	.comm	global1,4,4
	.comm	global2,4,4
	.comm	global3,4,4
	.text

	.align 2
	.global constantFolding
constantFolding:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #8
	mov r5, #8
	mov r4, #9
	mul r5, r5, r4
	mov r4, #4
	mov r0, r5
	mov r1, r4
	bl __aeabi_idiv
	mov r5, r0
	mov r4, #2
	add r6, r5, r4
	mov r5, #5
	mov r4, #8
	mul r4, r5, r4
	sub r5, r6, r4
	mov r4, #9
	add r5, r5, r4
	mov r4, #12
	sub r5, r5, r4
	mov r4, #6
	add r5, r5, r4
	mov r4, #9
	sub r5, r5, r4
	mov r4, #18
	sub r4, r5, r4
	mov r5, #23
	mov r6, #3
	mul r6, r5, r6
	mov r5, #23
	mov r0, r6
	mov r1, r5
	bl __aeabi_idiv
	mov r5, r0
	mov r6, #90
	mul r5, r5, r6
	add r10, r4, r5
	str r10, [fp, #-12]
	ldr r10, [fp, #-12]
	str r10, [fp, #-8]
	b .LU0
.LU0:
	ldr r4, [fp, #-8]
	mov r0, r4
	add sp, sp, #8
	pop {r4-r10, fp, pc}
	.size constantFolding, .-constantFolding
	.align 2
	.global constantPropagation
constantPropagation:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #108
	mov r4, #4
	str r4, [fp, #-12]
	mov r4, #7
	str r4, [fp, #-16]
	mov r4, #8
	str r4, [fp, #-20]
	mov r4, #5
	str r4, [fp, #-24]
	mov r4, #11
	str r4, [fp, #-28]
	mov r4, #21
	str r4, [fp, #-32]
	ldr r4, [fp, #-12]
	ldr r5, [fp, #-16]
	add r4, r4, r5
	str r4, [fp, #-36]
	ldr r5, [fp, #-20]
	ldr r4, [fp, #-24]
	add r4, r5, r4
	str r4, [fp, #-40]
	ldr r5, [fp, #-28]
	ldr r4, [fp, #-32]
	add r4, r5, r4
	str r4, [fp, #-44]
	ldr r5, [fp, #-36]
	ldr r4, [fp, #-40]
	add r4, r5, r4
	str r4, [fp, #-48]
	ldr r5, [fp, #-44]
	ldr r4, [fp, #-48]
	mul r4, r5, r4
	str r4, [fp, #-52]
	ldr r5, [fp, #-28]
	ldr r4, [fp, #-40]
	ldr r6, [fp, #-44]
	mul r4, r4, r6
	add r5, r5, r4
	ldr r4, [fp, #-52]
	sub r4, r5, r4
	str r4, [fp, #-56]
	ldr r5, [fp, #-40]
	ldr r6, [fp, #-44]
	ldr r4, [fp, #-48]
	mul r4, r6, r4
	sub r4, r5, r4
	ldr r6, [fp, #-52]
	ldr r5, [fp, #-56]
	mov r0, r6
	mov r1, r5
	bl __aeabi_idiv
	mov r5, r0
	add r4, r4, r5
	str r4, [fp, #-60]
	ldr r5, [fp, #-28]
	ldr r4, [fp, #-32]
	add r5, r5, r4
	ldr r4, [fp, #-36]
	add r5, r5, r4
	ldr r4, [fp, #-40]
	add r5, r5, r4
	ldr r4, [fp, #-44]
	add r5, r5, r4
	ldr r4, [fp, #-48]
	sub r4, r5, r4
	str r4, [fp, #-64]
	ldr r5, [fp, #-64]
	ldr r4, [fp, #-60]
	sub r5, r5, r4
	ldr r4, [fp, #-40]
	add r5, r5, r4
	ldr r4, [fp, #-12]
	sub r5, r5, r4
	ldr r4, [fp, #-16]
	sub r4, r5, r4
	str r4, [fp, #-68]
	ldr r4, [fp, #-52]
	ldr r5, [fp, #-56]
	add r5, r4, r5
	ldr r4, [fp, #-36]
	sub r5, r5, r4
	ldr r4, [fp, #-40]
	sub r4, r5, r4
	str r4, [fp, #-72]
	ldr r4, [fp, #-16]
	ldr r5, [fp, #-12]
	sub r4, r4, r5
	ldr r5, [fp, #-24]
	mul r4, r4, r5
	ldr r5, [fp, #-44]
	sub r4, r4, r5
	str r4, [fp, #-76]
	ldr r4, [fp, #-56]
	ldr r5, [fp, #-20]
	mul r5, r4, r5
	ldr r4, [fp, #-24]
	mul r4, r5, r4
	ldr r5, [fp, #-68]
	add r4, r4, r5
	str r4, [fp, #-80]
	ldr r5, [fp, #-16]
	ldr r4, [fp, #-12]
	mul r5, r5, r4
	ldr r4, [fp, #-20]
	mul r5, r5, r4
	ldr r4, [fp, #-28]
	mov r0, r5
	mov r1, r4
	bl __aeabi_idiv
	mov r5, r0
	ldr r4, [fp, #-68]
	sub r4, r5, r4
	str r4, [fp, #-84]
	ldr r5, [fp, #-44]
	ldr r4, [fp, #-52]
	add r5, r5, r4
	ldr r4, [fp, #-20]
	add r4, r5, r4
	ldr r5, [fp, #-72]
	sub r4, r4, r5
	str r4, [fp, #-88]
	ldr r4, [fp, #-64]
	ldr r5, [fp, #-68]
	add r4, r4, r5
	ldr r5, [fp, #-32]
	ldr r6, [fp, #-12]
	mul r5, r5, r6
	sub r10, r4, r5
	str r10, [fp, #-92]
	ldr r4, [fp, #-12]
	ldr r5, [fp, #-16]
	mul r4, r4, r5
	ldr r5, [fp, #-52]
	sub r4, r4, r5
	ldr r5, [fp, #-56]
	sub r10, r4, r5
	str r10, [fp, #-96]
	ldr r4, [fp, #-96]
	ldr r5, [fp, #-84]
	sub r6, r4, r5
	ldr r4, [fp, #-80]
	ldr r5, [fp, #-24]
	mul r4, r4, r5
	sub r4, r6, r4
	str r4, [fp, #-100]
	ldr r4, [fp, #-68]
	ldr r5, [fp, #-100]
	sub r4, r4, r5
	ldr r5, [fp, #-96]
	sub r4, r4, r5
	ldr r5, [fp, #-64]
	sub r4, r4, r5
	str r4, [fp, #-104]
	ldr r4, [fp, #-72]
	ldr r5, [fp, #-104]
	mul r4, r4, r5
	ldr r5, [fp, #-88]
	add r4, r4, r5
	ldr r5, [fp, #-100]
	sub r4, r4, r5
	str r4, [fp, #-108]
	ldr r4, [fp, #-100]
	ldr r5, [fp, #-104]
	sub r4, r4, r5
	ldr r5, [fp, #-108]
	add r4, r4, r5
	ldr r5, [fp, #-52]
	add r4, r4, r5
	str r4, [fp, #-112]
	ldr r4, [fp, #-112]
	str r4, [fp, #-8]
	b .LU2
.LU2:
	ldr r4, [fp, #-8]
	mov r0, r4
	add sp, sp, #108
	pop {r4-r10, fp, pc}
	.size constantPropagation, .-constantPropagation
	.align 2
	.global deadCodeElimination
deadCodeElimination:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #24
	mov r4, #4
	str r4, [fp, #-12]
	mov r4, #5
	str r4, [fp, #-12]
	mov r4, #7
	str r4, [fp, #-12]
	mov r4, #8
	str r4, [fp, #-12]
	mov r4, #6
	str r4, [fp, #-16]
	mov r4, #9
	str r4, [fp, #-16]
	mov r4, #12
	str r4, [fp, #-16]
	mov r4, #8
	str r4, [fp, #-16]
	mov r4, #10
	str r4, [fp, #-20]
	mov r4, #13
	str r4, [fp, #-20]
	mov r4, #9
	str r4, [fp, #-20]
	mov r4, #45
	str r4, [fp, #-24]
	mov r4, #12
	str r4, [fp, #-24]
	mov r4, #3
	str r4, [fp, #-24]
	mov r4, #23
	str r4, [fp, #-28]
	mov r4, #10
	str r4, [fp, #-28]
	mov r4, #11
	str r4, [r5]
	mov r4, #5
	str r4, [r5]
	mov r4, #9
	str r4, [r5]
	ldr r4, [fp, #-12]
	ldr r5, [fp, #-16]
	add r4, r4, r5
	ldr r5, [fp, #-20]
	add r4, r4, r5
	ldr r5, [fp, #-24]
	add r4, r4, r5
	ldr r5, [fp, #-28]
	add r10, r4, r5
	str r10, [fp, #-8]
	b .LU4
.LU4:
	ldr r10, [fp, #-8]
	mov r0, r10
	add sp, sp, #24
	pop {r4-r10, fp, pc}
	.size deadCodeElimination, .-deadCodeElimination
	.align 2
	.global sum
sum:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #12
	str r0, [fp, #-8]
	mov r4, #0
	str r4, [fp, #-16]
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
	ldr r4, [fp, #-16]
	ldr r5, [fp, #-8]
	add r10, r4, r5
	str r10, [fp, #-16]
	ldr r5, [fp, #-8]
	mov r4, #1
	sub r10, r5, r4
	str r10, [fp, #-8]
	ldr r4, [fp, #-8]
	mov r5, #0
	cmp r4, #0
	movgt r5, #1
	cmp r5, #1
	beq .LU9
	b .LU10
.LU10:
	ldr r4, [fp, #-16]
	str r4, [fp, #-12]
	b .LU6
.LU6:
	ldr r4, [fp, #-12]
	mov r0, r4
	add sp, sp, #12
	pop {r4-r10, fp, pc}
	.size sum, .-sum
	.align 2
	.global doesntModifyGlobals
doesntModifyGlobals:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #12
	mov r4, #1
	str r4, [fp, #-12]
	mov r4, #2
	str r4, [fp, #-16]
	ldr r4, [fp, #-12]
	ldr r5, [fp, #-16]
	add r10, r4, r5
	str r10, [fp, #-8]
	b .LU11
.LU11:
	ldr r10, [fp, #-8]
	mov r0, r10
	add sp, sp, #12
	pop {r4-r10, fp, pc}
	.size doesntModifyGlobals, .-doesntModifyGlobals
	.align 2
	.global interProceduralOptimization
interProceduralOptimization:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #8
	mov r5, #1
	str r5, [r4]
	mov r5, #0
	str r5, [r4]
	mov r5, #0
	str r5, [r4]
	mov r0, #100
	bl sum
	mov r5, r0
	str r5, [fp, #-12]
	b .LU15
.LU15:
	ldr r5, [r4]
	mov r6, #0
	cmp r5, #1
	moveq r6, #1
	cmp r6, #1
	beq .LU16
	b .LU17
.LU16:
	mov r0, #10000
	bl sum
	mov r4, r0
	str r4, [fp, #-12]
	b .JN2
.JN2:
	ldr r10, [fp, #-12]
	str r10, [fp, #-8]
	b .LU13
.LU17:
	ldr r5, [r4]
	mov r6, #0
	cmp r5, #2
	moveq r6, #1
	cmp r6, #1
	beq .LU18
	b .JN0
.LU18:
	mov r0, #20000
	bl sum
	mov r5, r0
	str r5, [fp, #-12]
	b .JN0
.JN0:
	b .LU19
.LU19:
	ldr r4, [r4]
	mov r5, #0
	cmp r4, #3
	moveq r5, #1
	cmp r5, #1
	beq .LU20
	b .JN1
.LU20:
	mov r0, #30000
	bl sum
	mov r4, r0
	str r4, [fp, #-12]
	b .JN1
.JN1:
	b .JN2
.LU13:
	ldr r10, [fp, #-8]
	mov r0, r10
	add sp, sp, #8
	pop {r4-r10, fp, pc}
	.size interProceduralOptimization, .-interProceduralOptimization
	.align 2
	.global commonSubexpressionElimination
commonSubexpressionElimination:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #108
	mov r4, #11
	str r4, [fp, #-12]
	mov r4, #22
	str r4, [fp, #-16]
	mov r4, #33
	str r4, [fp, #-20]
	mov r4, #44
	str r4, [fp, #-24]
	mov r4, #55
	str r4, [fp, #-28]
	mov r4, #66
	str r4, [fp, #-32]
	mov r4, #77
	str r4, [fp, #-36]
	ldr r4, [fp, #-12]
	ldr r5, [fp, #-16]
	mul r4, r4, r5
	str r4, [fp, #-40]
	ldr r5, [fp, #-20]
	ldr r4, [fp, #-24]
	mov r0, r5
	mov r1, r4
	bl __aeabi_idiv
	mov r4, r0
	str r4, [fp, #-44]
	ldr r4, [fp, #-28]
	ldr r5, [fp, #-32]
	mul r4, r4, r5
	str r4, [fp, #-48]
	ldr r4, [fp, #-12]
	ldr r5, [fp, #-16]
	mul r4, r4, r5
	ldr r6, [fp, #-20]
	ldr r5, [fp, #-24]
	mov r0, r6
	mov r1, r5
	bl __aeabi_idiv
	mov r5, r0
	add r4, r4, r5
	ldr r5, [fp, #-28]
	ldr r6, [fp, #-32]
	mul r5, r5, r6
	sub r4, r4, r5
	ldr r5, [fp, #-36]
	add r4, r4, r5
	str r4, [fp, #-52]
	ldr r4, [fp, #-12]
	ldr r5, [fp, #-16]
	mul r4, r4, r5
	ldr r6, [fp, #-20]
	ldr r5, [fp, #-24]
	mov r0, r6
	mov r1, r5
	bl __aeabi_idiv
	mov r5, r0
	add r4, r4, r5
	ldr r5, [fp, #-28]
	ldr r6, [fp, #-32]
	mul r5, r5, r6
	sub r4, r4, r5
	ldr r5, [fp, #-36]
	add r4, r4, r5
	str r4, [fp, #-56]
	ldr r4, [fp, #-12]
	ldr r5, [fp, #-16]
	mul r4, r4, r5
	ldr r6, [fp, #-20]
	ldr r5, [fp, #-24]
	mov r0, r6
	mov r1, r5
	bl __aeabi_idiv
	mov r5, r0
	add r4, r4, r5
	ldr r5, [fp, #-28]
	ldr r6, [fp, #-32]
	mul r5, r5, r6
	sub r4, r4, r5
	ldr r5, [fp, #-36]
	add r4, r4, r5
	str r4, [fp, #-60]
	ldr r4, [fp, #-12]
	ldr r5, [fp, #-16]
	mul r4, r4, r5
	ldr r6, [fp, #-20]
	ldr r5, [fp, #-24]
	mov r0, r6
	mov r1, r5
	bl __aeabi_idiv
	mov r5, r0
	add r4, r4, r5
	ldr r5, [fp, #-28]
	ldr r6, [fp, #-32]
	mul r5, r5, r6
	sub r4, r4, r5
	ldr r5, [fp, #-36]
	add r4, r4, r5
	str r4, [fp, #-64]
	ldr r4, [fp, #-12]
	ldr r5, [fp, #-16]
	mul r4, r4, r5
	ldr r6, [fp, #-20]
	ldr r5, [fp, #-24]
	mov r0, r6
	mov r1, r5
	bl __aeabi_idiv
	mov r5, r0
	add r4, r4, r5
	ldr r5, [fp, #-28]
	ldr r6, [fp, #-32]
	mul r5, r5, r6
	sub r4, r4, r5
	ldr r5, [fp, #-36]
	add r4, r4, r5
	str r4, [fp, #-68]
	ldr r4, [fp, #-12]
	ldr r5, [fp, #-16]
	mul r4, r4, r5
	ldr r6, [fp, #-20]
	ldr r5, [fp, #-24]
	mov r0, r6
	mov r1, r5
	bl __aeabi_idiv
	mov r5, r0
	add r4, r4, r5
	ldr r5, [fp, #-28]
	ldr r6, [fp, #-32]
	mul r5, r5, r6
	sub r4, r4, r5
	ldr r5, [fp, #-36]
	add r4, r4, r5
	str r4, [fp, #-72]
	ldr r4, [fp, #-12]
	ldr r5, [fp, #-16]
	mul r4, r4, r5
	ldr r6, [fp, #-20]
	ldr r5, [fp, #-24]
	mov r0, r6
	mov r1, r5
	bl __aeabi_idiv
	mov r5, r0
	add r4, r4, r5
	ldr r5, [fp, #-28]
	ldr r6, [fp, #-32]
	mul r5, r5, r6
	sub r4, r4, r5
	ldr r5, [fp, #-36]
	add r4, r4, r5
	str r4, [fp, #-76]
	ldr r5, [fp, #-12]
	ldr r4, [fp, #-16]
	mul r4, r5, r4
	ldr r6, [fp, #-20]
	ldr r5, [fp, #-24]
	mov r0, r6
	mov r1, r5
	bl __aeabi_idiv
	mov r5, r0
	add r4, r4, r5
	ldr r5, [fp, #-28]
	ldr r6, [fp, #-32]
	mul r5, r5, r6
	sub r4, r4, r5
	ldr r5, [fp, #-36]
	add r4, r4, r5
	str r4, [fp, #-80]
	ldr r4, [fp, #-12]
	ldr r5, [fp, #-16]
	mul r4, r4, r5
	ldr r6, [fp, #-20]
	ldr r5, [fp, #-24]
	mov r0, r6
	mov r1, r5
	bl __aeabi_idiv
	mov r5, r0
	add r4, r4, r5
	ldr r5, [fp, #-28]
	ldr r6, [fp, #-32]
	mul r5, r5, r6
	sub r4, r4, r5
	ldr r5, [fp, #-36]
	add r4, r4, r5
	str r4, [fp, #-84]
	ldr r4, [fp, #-12]
	ldr r5, [fp, #-16]
	mul r4, r4, r5
	ldr r6, [fp, #-20]
	ldr r5, [fp, #-24]
	mov r0, r6
	mov r1, r5
	bl __aeabi_idiv
	mov r5, r0
	add r4, r4, r5
	ldr r5, [fp, #-28]
	ldr r6, [fp, #-32]
	mul r5, r5, r6
	sub r4, r4, r5
	ldr r5, [fp, #-36]
	add r4, r4, r5
	str r4, [fp, #-88]
	ldr r4, [fp, #-12]
	ldr r5, [fp, #-16]
	mul r4, r4, r5
	ldr r6, [fp, #-20]
	ldr r5, [fp, #-24]
	mov r0, r6
	mov r1, r5
	bl __aeabi_idiv
	mov r5, r0
	add r4, r4, r5
	ldr r5, [fp, #-28]
	ldr r6, [fp, #-32]
	mul r5, r5, r6
	sub r4, r4, r5
	ldr r5, [fp, #-36]
	add r4, r4, r5
	str r4, [fp, #-92]
	ldr r4, [fp, #-16]
	ldr r5, [fp, #-12]
	mul r4, r4, r5
	ldr r6, [fp, #-20]
	ldr r5, [fp, #-24]
	mov r0, r6
	mov r1, r5
	bl __aeabi_idiv
	mov r5, r0
	add r4, r4, r5
	ldr r5, [fp, #-28]
	ldr r6, [fp, #-32]
	mul r5, r5, r6
	sub r4, r4, r5
	ldr r5, [fp, #-36]
	add r4, r4, r5
	str r4, [fp, #-96]
	ldr r4, [fp, #-12]
	ldr r5, [fp, #-16]
	mul r4, r4, r5
	ldr r6, [fp, #-20]
	ldr r5, [fp, #-24]
	mov r0, r6
	mov r1, r5
	bl __aeabi_idiv
	mov r5, r0
	add r4, r4, r5
	ldr r5, [fp, #-32]
	ldr r6, [fp, #-28]
	mul r5, r5, r6
	sub r4, r4, r5
	ldr r5, [fp, #-36]
	add r4, r4, r5
	str r4, [fp, #-100]
	ldr r4, [fp, #-36]
	ldr r5, [fp, #-12]
	ldr r6, [fp, #-16]
	mul r5, r5, r6
	add r4, r4, r5
	ldr r6, [fp, #-20]
	ldr r5, [fp, #-24]
	mov r0, r6
	mov r1, r5
	bl __aeabi_idiv
	mov r5, r0
	add r4, r4, r5
	ldr r5, [fp, #-28]
	ldr r6, [fp, #-32]
	mul r5, r5, r6
	sub r4, r4, r5
	str r4, [fp, #-104]
	ldr r4, [fp, #-12]
	ldr r5, [fp, #-16]
	mul r4, r4, r5
	ldr r6, [fp, #-20]
	ldr r5, [fp, #-24]
	mov r0, r6
	mov r1, r5
	bl __aeabi_idiv
	mov r5, r0
	add r4, r4, r5
	ldr r5, [fp, #-28]
	ldr r6, [fp, #-32]
	mul r5, r5, r6
	sub r4, r4, r5
	ldr r5, [fp, #-36]
	add r4, r4, r5
	str r4, [fp, #-108]
	ldr r5, [fp, #-20]
	ldr r4, [fp, #-24]
	mov r0, r5
	mov r1, r4
	bl __aeabi_idiv
	mov r4, r0
	ldr r5, [fp, #-12]
	ldr r6, [fp, #-16]
	mul r5, r5, r6
	add r4, r4, r5
	ldr r5, [fp, #-28]
	ldr r6, [fp, #-32]
	mul r5, r5, r6
	sub r4, r4, r5
	ldr r5, [fp, #-36]
	add r10, r4, r5
	str r10, [fp, #-112]
	ldr r4, [fp, #-12]
	ldr r5, [fp, #-16]
	add r4, r4, r5
	ldr r5, [fp, #-20]
	add r4, r4, r5
	ldr r5, [fp, #-24]
	add r4, r4, r5
	ldr r5, [fp, #-28]
	add r4, r4, r5
	ldr r5, [fp, #-32]
	add r4, r4, r5
	ldr r5, [fp, #-36]
	add r4, r4, r5
	ldr r5, [fp, #-40]
	add r4, r4, r5
	ldr r5, [fp, #-44]
	add r4, r4, r5
	ldr r5, [fp, #-48]
	add r4, r4, r5
	ldr r5, [fp, #-52]
	add r4, r4, r5
	ldr r5, [fp, #-56]
	add r4, r4, r5
	ldr r5, [fp, #-60]
	add r4, r4, r5
	ldr r5, [fp, #-64]
	add r4, r4, r5
	ldr r5, [fp, #-68]
	add r4, r4, r5
	ldr r5, [fp, #-72]
	add r4, r4, r5
	ldr r5, [fp, #-76]
	add r4, r4, r5
	ldr r5, [fp, #-80]
	add r4, r4, r5
	ldr r5, [fp, #-84]
	add r4, r4, r5
	ldr r5, [fp, #-88]
	add r4, r4, r5
	ldr r5, [fp, #-92]
	add r4, r4, r5
	ldr r5, [fp, #-96]
	add r4, r4, r5
	ldr r5, [fp, #-100]
	add r4, r4, r5
	ldr r5, [fp, #-104]
	add r4, r4, r5
	ldr r5, [fp, #-108]
	add r4, r4, r5
	ldr r5, [fp, #-112]
	add r4, r4, r5
	str r4, [fp, #-8]
	b .LU21
.LU21:
	ldr r10, [fp, #-8]
	mov r0, r10
	add sp, sp, #108
	pop {r4-r10, fp, pc}
	.size commonSubexpressionElimination, .-commonSubexpressionElimination
	.align 2
	.global hoisting
hoisting:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #40
	mov r4, #1
	str r4, [fp, #-12]
	mov r4, #2
	str r4, [fp, #-16]
	mov r4, #3
	str r4, [fp, #-20]
	mov r4, #4
	str r4, [fp, #-24]
	mov r10, #0
	str r10, [fp, #-44]
	b .LU25
.LU25:
	ldr r4, [fp, #-44]
	mov r5, #0
	cmp r4, #1000000
	movlt r5, #1
	cmp r5, #1
	beq .LU26
	b .LU27
.LU26:
	mov r4, #5
	str r4, [fp, #-28]
	ldr r4, [fp, #-12]
	ldr r5, [fp, #-16]
	add r4, r4, r5
	ldr r5, [fp, #-20]
	add r10, r4, r5
	str r10, [fp, #-36]
	ldr r5, [fp, #-20]
	ldr r4, [fp, #-24]
	add r4, r5, r4
	ldr r5, [fp, #-36]
	add r4, r4, r5
	str r4, [fp, #-40]
	ldr r4, [fp, #-44]
	mov r5, #1
	add r4, r4, r5
	str r4, [fp, #-44]
	ldr r4, [fp, #-44]
	mov r5, #0
	cmp r4, #1000000
	movlt r5, #1
	cmp r5, #1
	beq .LU26
	b .LU27
.LU27:
	ldr r4, [fp, #-16]
	str r4, [fp, #-8]
	b .LU23
.LU23:
	ldr r4, [fp, #-8]
	mov r0, r4
	add sp, sp, #40
	pop {r4-r10, fp, pc}
	.size hoisting, .-hoisting
	.align 2
	.global doubleIf
doubleIf:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #20
	mov r4, #1
	str r4, [fp, #-12]
	mov r4, #2
	str r4, [fp, #-16]
	mov r4, #3
	str r4, [fp, #-20]
	mov r4, #0
	str r4, [fp, #-24]
	b .LU30
.LU30:
	ldr r5, [fp, #-12]
	mov r4, #0
	cmp r5, #1
	moveq r4, #1
	cmp r4, #1
	beq .LU31
	b .JN4
.LU31:
	mov r4, #20
	str r4, [fp, #-16]
	b .LU32
.LU32:
	ldr r4, [fp, #-12]
	mov r5, #0
	cmp r4, #1
	moveq r5, #1
	cmp r5, #1
	beq .LU33
	b .LU34
.LU33:
	mov r4, #200
	str r4, [fp, #-16]
	mov r10, #300
	str r10, [fp, #-20]
	b .JN3
.JN3:
	mov r4, #50
	str r4, [fp, #-24]
	b .JN4
.JN4:
	ldr r4, [fp, #-24]
	str r4, [fp, #-8]
	b .LU28
.LU34:
	mov r4, #1
	str r4, [fp, #-12]
	mov r10, #2
	str r10, [fp, #-16]
	mov r4, #3
	str r4, [fp, #-20]
	b .JN3
.LU28:
	ldr r4, [fp, #-8]
	mov r0, r4
	add sp, sp, #20
	pop {r4-r10, fp, pc}
	.size doubleIf, .-doubleIf
	.align 2
	.global integerDivide
integerDivide:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #8
	mov r4, #3000
	str r4, [fp, #-12]
	ldr r5, [fp, #-12]
	mov r4, #2
	mov r0, r5
	mov r1, r4
	bl __aeabi_idiv
	mov r4, r0
	str r4, [fp, #-12]
	ldr r5, [fp, #-12]
	mov r4, #4
	mul r4, r5, r4
	str r4, [fp, #-12]
	ldr r5, [fp, #-12]
	mov r4, #8
	mov r0, r5
	mov r1, r4
	bl __aeabi_idiv
	mov r4, r0
	str r4, [fp, #-12]
	ldr r4, [fp, #-12]
	mov r5, #16
	mov r0, r4
	mov r1, r5
	bl __aeabi_idiv
	mov r4, r0
	str r4, [fp, #-12]
	ldr r4, [fp, #-12]
	mov r5, #32
	mul r4, r4, r5
	str r4, [fp, #-12]
	ldr r5, [fp, #-12]
	mov r4, #64
	mov r0, r5
	mov r1, r4
	bl __aeabi_idiv
	mov r4, r0
	str r4, [fp, #-12]
	ldr r4, [fp, #-12]
	mov r5, #128
	mul r4, r4, r5
	str r4, [fp, #-12]
	ldr r5, [fp, #-12]
	mov r4, #4
	mov r0, r5
	mov r1, r4
	bl __aeabi_idiv
	mov r4, r0
	str r4, [fp, #-12]
	ldr r10, [fp, #-12]
	str r10, [fp, #-8]
	b .LU35
.LU35:
	ldr r10, [fp, #-8]
	mov r0, r10
	add sp, sp, #8
	pop {r4-r10, fp, pc}
	.size integerDivide, .-integerDivide
	.align 2
	.global association
association:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #8
	mov r4, #10
	str r4, [fp, #-12]
	ldr r5, [fp, #-12]
	mov r4, #2
	mul r4, r5, r4
	str r4, [fp, #-12]
	ldr r5, [fp, #-12]
	mov r4, #2
	mov r0, r5
	mov r1, r4
	bl __aeabi_idiv
	mov r4, r0
	str r4, [fp, #-12]
	ldr r4, [fp, #-12]
	mov r5, #3
	mul r4, r5, r4
	str r4, [fp, #-12]
	ldr r5, [fp, #-12]
	mov r4, #3
	mov r0, r5
	mov r1, r4
	bl __aeabi_idiv
	mov r4, r0
	str r4, [fp, #-12]
	ldr r5, [fp, #-12]
	mov r4, #4
	mul r4, r5, r4
	str r4, [fp, #-12]
	ldr r5, [fp, #-12]
	mov r4, #4
	mov r0, r5
	mov r1, r4
	bl __aeabi_idiv
	mov r4, r0
	str r4, [fp, #-12]
	ldr r5, [fp, #-12]
	mov r4, #4
	add r4, r5, r4
	str r4, [fp, #-12]
	ldr r5, [fp, #-12]
	mov r4, #4
	sub r4, r5, r4
	str r4, [fp, #-12]
	ldr r4, [fp, #-12]
	mov r5, #50
	mul r4, r4, r5
	str r4, [fp, #-12]
	ldr r5, [fp, #-12]
	mov r4, #50
	mov r0, r5
	mov r1, r4
	bl __aeabi_idiv
	mov r4, r0
	str r4, [fp, #-12]
	ldr r10, [fp, #-12]
	str r10, [fp, #-8]
	b .LU37
.LU37:
	ldr r10, [fp, #-8]
	mov r0, r10
	add sp, sp, #8
	pop {r4-r10, fp, pc}
	.size association, .-association
	.align 2
	.global tailRecursionHelper
tailRecursionHelper:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #12
	str r0, [fp, #-8]
	str r1, [fp, #-12]
	b .LU41
.LU41:
	ldr r4, [fp, #-8]
	mov r5, #0
	cmp r4, #0
	moveq r5, #1
	cmp r5, #1
	beq .LU42
	b .LU43
.LU42:
	ldr r4, [fp, #-12]
	str r4, [fp, #-16]
	b .LU39
.JN5:
	b .LU39
.LU43:
	ldr r4, [fp, #-8]
	mov r5, #1
	sub r4, r4, r5
	ldr r5, [fp, #-12]
	ldr r6, [fp, #-8]
	add r5, r5, r6
	mov r0, r4
	mov r1, r5
	bl tailRecursionHelper
	mov r10, r0
	str r10, [fp, #-16]
	b .LU39
.LU39:
	ldr r10, [fp, #-16]
	mov r0, r10
	add sp, sp, #12
	pop {r4-r10, fp, pc}
	.size tailRecursionHelper, .-tailRecursionHelper
	.align 2
	.global tailRecursion
tailRecursion:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #8
	str r0, [fp, #-8]
	ldr r4, [fp, #-8]
	mov r0, r4
	mov r1, #0
	bl tailRecursionHelper
	mov r10, r0
	str r10, [fp, #-12]
	b .LU44
.LU44:
	ldr r10, [fp, #-12]
	mov r0, r10
	add sp, sp, #8
	pop {r4-r10, fp, pc}
	.size tailRecursion, .-tailRecursion
	.align 2
	.global unswitching
unswitching:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #12
	mov r4, #1
	str r4, [fp, #-12]
	mov r4, #2
	str r4, [fp, #-16]
	b .LU48
.LU48:
	ldr r4, [fp, #-12]
	mov r5, #0
	cmp r4, #1000000
	movlt r5, #1
	cmp r5, #1
	beq .LU49
	b .LU52
.LU49:
	ldr r4, [fp, #-16]
	mov r5, #0
	cmp r4, #2
	moveq r5, #1
	cmp r5, #1
	beq .LU50
	b .LU51
.LU50:
	ldr r5, [fp, #-12]
	mov r4, #1
	add r10, r5, r4
	str r10, [fp, #-12]
	b .JN6
.JN6:
	ldr r5, [fp, #-12]
	mov r4, #0
	cmp r5, #1000000
	movlt r4, #1
	cmp r4, #1
	beq .LU49
	b .LU52
.LU51:
	ldr r5, [fp, #-12]
	mov r4, #2
	add r10, r5, r4
	str r10, [fp, #-12]
	b .JN6
.LU52:
	ldr r4, [fp, #-12]
	str r4, [fp, #-8]
	b .LU46
.LU46:
	ldr r4, [fp, #-8]
	mov r0, r4
	add sp, sp, #12
	pop {r4-r10, fp, pc}
	.size unswitching, .-unswitching
	.align 2
	.global randomCalculation
randomCalculation:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #36
	str r0, [fp, #-8]
	mov r4, #0
	str r4, [fp, #-36]
	mov r4, #0
	str r4, [fp, #-40]
	b .LU55
.LU55:
	ldr r4, [fp, #-36]
	ldr r5, [fp, #-8]
	mov r6, #0
	cmp r4, r5
	movlt r6, #1
	cmp r6, #1
	beq .LU56
	b .LU57
.LU56:
	mov r4, #4
	str r4, [fp, #-16]
	mov r4, #7
	str r4, [fp, #-20]
	mov r4, #8
	str r4, [fp, #-24]
	ldr r4, [fp, #-16]
	ldr r5, [fp, #-20]
	add r4, r4, r5
	str r4, [fp, #-28]
	ldr r4, [fp, #-28]
	ldr r5, [fp, #-24]
	add r4, r4, r5
	str r4, [fp, #-32]
	ldr r4, [fp, #-40]
	ldr r5, [fp, #-32]
	add r4, r4, r5
	str r4, [fp, #-40]
	ldr r4, [fp, #-36]
	mov r5, #2
	mul r4, r4, r5
	str r4, [fp, #-36]
	ldr r5, [fp, #-36]
	mov r4, #2
	mov r0, r5
	mov r1, r4
	bl __aeabi_idiv
	mov r4, r0
	str r4, [fp, #-36]
	ldr r5, [fp, #-36]
	mov r4, #3
	mul r4, r4, r5
	str r4, [fp, #-36]
	ldr r4, [fp, #-36]
	mov r5, #3
	mov r0, r4
	mov r1, r5
	bl __aeabi_idiv
	mov r4, r0
	str r4, [fp, #-36]
	ldr r4, [fp, #-36]
	mov r5, #4
	mul r4, r4, r5
	str r4, [fp, #-36]
	ldr r5, [fp, #-36]
	mov r4, #4
	mov r0, r5
	mov r1, r4
	bl __aeabi_idiv
	mov r4, r0
	str r4, [fp, #-36]
	ldr r4, [fp, #-36]
	mov r5, #1
	add r4, r4, r5
	str r4, [fp, #-36]
	ldr r4, [fp, #-36]
	ldr r5, [fp, #-8]
	mov r6, #0
	cmp r4, r5
	movlt r6, #1
	cmp r6, #1
	beq .LU56
	b .LU57
.LU57:
	ldr r10, [fp, #-40]
	str r10, [fp, #-12]
	b .LU53
.LU53:
	ldr r10, [fp, #-12]
	mov r0, r10
	add sp, sp, #36
	pop {r4-r10, fp, pc}
	.size randomCalculation, .-randomCalculation
	.align 2
	.global iterativeFibonacci
iterativeFibonacci:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #28
	str r0, [fp, #-8]
	mov r4, #-1
	str r4, [fp, #-16]
	mov r4, #1
	str r4, [fp, #-20]
	mov r4, #0
	str r4, [fp, #-28]
	b .LU60
.LU60:
	ldr r4, [fp, #-28]
	ldr r5, [fp, #-8]
	mov r6, #0
	cmp r4, r5
	movlt r6, #1
	cmp r6, #1
	beq .LU61
	b .LU62
.LU61:
	ldr r4, [fp, #-20]
	ldr r5, [fp, #-16]
	add r4, r4, r5
	str r4, [fp, #-32]
	ldr r10, [fp, #-20]
	str r10, [fp, #-16]
	ldr r10, [fp, #-32]
	str r10, [fp, #-20]
	ldr r5, [fp, #-28]
	mov r4, #1
	add r4, r5, r4
	str r4, [fp, #-28]
	ldr r4, [fp, #-28]
	ldr r5, [fp, #-8]
	mov r6, #0
	cmp r4, r5
	movlt r6, #1
	cmp r6, #1
	beq .LU61
	b .LU62
.LU62:
	ldr r4, [fp, #-20]
	str r4, [fp, #-12]
	b .LU58
.LU58:
	ldr r4, [fp, #-12]
	mov r0, r4
	add sp, sp, #28
	pop {r4-r10, fp, pc}
	.size iterativeFibonacci, .-iterativeFibonacci
	.align 2
	.global recursiveFibonacci
recursiveFibonacci:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #8
	str r0, [fp, #-8]
	b .LU65
.LU65:
	ldr r5, [fp, #-8]
	mov r4, #0
	cmp r5, #0
	movle r4, #1
	ldr r5, [fp, #-8]
	mov r6, #0
	cmp r5, #1
	moveq r6, #1
	orr r4, r4, r6
	cmp r4, #1
	beq .LU66
	b .LU67
.LU66:
	ldr r4, [fp, #-8]
	str r4, [fp, #-12]
	b .LU63
.JN7:
	b .LU63
.LU67:
	ldr r4, [fp, #-8]
	mov r5, #1
	sub r4, r4, r5
	mov r0, r4
	bl recursiveFibonacci
	mov r4, r0
	ldr r5, [fp, #-8]
	mov r6, #2
	sub r5, r5, r6
	mov r0, r5
	bl recursiveFibonacci
	mov r5, r0
	add r10, r4, r5
	str r10, [fp, #-12]
	b .LU63
.LU63:
	ldr r10, [fp, #-12]
	mov r0, r10
	add sp, sp, #8
	pop {r4-r10, fp, pc}
	.size recursiveFibonacci, .-recursiveFibonacci
	.align 2
	.global main
main:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #16
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r0, #:lower16:.read_scratch
	movt r0, #:upper16:.read_scratch
	ldr r0, [r0]
	str r0, [fp, #-12]
	mov r4, #1
	str r4, [fp, #-20]
	b .LU70
.LU70:
	ldr r4, [fp, #-20]
	ldr r5, [fp, #-12]
	mov r6, #0
	cmp r4, r5
	movlt r6, #1
	cmp r6, #1
	beq .LU71
	b .LU72
.LU71:
	bl constantFolding
	mov r4, r0
	str r4, [fp, #-16]
	ldr r4, [fp, #-16]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	bl constantPropagation
	mov r4, r0
	str r4, [fp, #-16]
	ldr r4, [fp, #-16]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	bl deadCodeElimination
	mov r4, r0
	str r4, [fp, #-16]
	ldr r4, [fp, #-16]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	bl interProceduralOptimization
	mov r4, r0
	str r4, [fp, #-16]
	ldr r4, [fp, #-16]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	bl commonSubexpressionElimination
	mov r4, r0
	str r4, [fp, #-16]
	ldr r4, [fp, #-16]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	bl hoisting
	mov r4, r0
	str r4, [fp, #-16]
	ldr r4, [fp, #-16]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	bl doubleIf
	mov r4, r0
	str r4, [fp, #-16]
	ldr r4, [fp, #-16]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	bl integerDivide
	mov r4, r0
	str r4, [fp, #-16]
	ldr r4, [fp, #-16]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	bl association
	mov r4, r0
	str r4, [fp, #-16]
	ldr r4, [fp, #-16]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r5, [fp, #-12]
	movw r4, #lower16:1000
	movt r4, #upper16:1000
	mov r0, r5
	mov r1, r4
	bl __aeabi_idiv
	mov r4, r0
	mov r0, r4
	bl tailRecursion
	mov r4, r0
	str r4, [fp, #-16]
	ldr r4, [fp, #-16]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	bl unswitching
	mov r4, r0
	str r4, [fp, #-16]
	ldr r4, [fp, #-16]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r4, [fp, #-12]
	mov r0, r4
	bl randomCalculation
	mov r4, r0
	str r4, [fp, #-16]
	ldr r4, [fp, #-16]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r5, [fp, #-12]
	mov r4, #5
	mov r0, r5
	mov r1, r4
	bl __aeabi_idiv
	mov r4, r0
	mov r0, r4
	bl iterativeFibonacci
	mov r4, r0
	str r4, [fp, #-16]
	ldr r4, [fp, #-16]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r5, [fp, #-12]
	movw r4, #lower16:1000
	movt r4, #upper16:1000
	mov r0, r5
	mov r1, r4
	bl __aeabi_idiv
	mov r4, r0
	mov r0, r4
	bl recursiveFibonacci
	mov r4, r0
	str r4, [fp, #-16]
	ldr r4, [fp, #-16]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r4, [fp, #-20]
	mov r5, #1
	add r4, r4, r5
	str r4, [fp, #-20]
	ldr r4, [fp, #-20]
	ldr r5, [fp, #-12]
	mov r6, #0
	cmp r4, r5
	movlt r6, #1
	cmp r6, #1
	beq .LU71
	b .LU72
.LU72:
	mov r1, r7
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r10, #0
	str r10, [fp, #-8]
	b .LU68
.LU68:
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
