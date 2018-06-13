	.arch armv7-a
	.comm	a,4,4
	.comm	b,4,4
	.comm	i,4,4
	.text

	.align 2
	.global concatLists
concatLists:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #16
	str r0, [fp, #-8]
	str r1, [fp, #-12]
	ldr r5, [fp, #-8]
	str r5, [fp, #-20]
	b .LU2
.LU2:
	ldr r6, [fp, #-8]
	mov r5, #0
	cmp r6, r4
	moveq r5, #1
	cmp r5, #1
	beq .LU3
	b .JN0
.LU3:
	ldr r5, [fp, #-12]
	str r5, [fp, #-16]
	b .LU0
.JN0:
	b .LU4
.LU4:
	ldr r5, [fp, #-20]
	add r5, r5, #4
	ldr r6, [r5]
	mov r5, #0
	cmp r6, r4
	movne r5, #1
	cmp r5, #1
	beq .LU5
	b .LU6
.LU5:
	ldr r5, [fp, #-20]
	add r5, r5, #4
	ldr r5, [r5]
	str r5, [fp, #-20]
	ldr r5, [fp, #-20]
	add r5, r5, #4
	ldr r6, [r5]
	mov r5, #0
	cmp r6, r4
	movne r5, #1
	cmp r5, #1
	beq .LU5
	b .LU6
.LU6:
	ldr r5, [fp, #-12]
	ldr r4, [fp, #-20]
	add r4, r4, #4
	str r5, [r4]
	ldr r10, [fp, #-8]
	str r10, [fp, #-16]
	b .LU0
.LU0:
	ldr r10, [fp, #-16]
	mov r0, r10
	add sp, sp, #16
	pop {r4-r10, fp, pc}
	.size concatLists, .-concatLists
	.align 2
	.global add
add:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #16
	str r0, [fp, #-8]
	str r1, [fp, #-12]
	movw r0, #8
	bl malloc
	mov r4, r0
	mov r4, r4
	str r4, [fp, #-20]
	ldr r5, [fp, #-12]
	ldr r4, [fp, #-20]
	mov r4, r4
	str r5, [r4]
	ldr r5, [fp, #-8]
	ldr r4, [fp, #-20]
	add r4, r4, #4
	str r5, [r4]
	ldr r10, [fp, #-20]
	str r10, [fp, #-16]
	b .LU7
.LU7:
	ldr r10, [fp, #-16]
	mov r0, r10
	add sp, sp, #16
	pop {r4-r10, fp, pc}
	.size add, .-add
	.align 2
	.global size
size:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #8
	str r0, [fp, #-8]
	b .LU11
.LU11:
	ldr r4, [fp, #-8]
	mov r5, #0
	cmp r4, r6
	moveq r5, #1
	cmp r5, #1
	beq .LU12
	b .JN1
.LU12:
	mov r4, #0
	str r4, [fp, #-12]
	b .LU9
.JN1:
	ldr r4, [fp, #-8]
	add r4, r4, #4
	ldr r4, [r4]
	mov r0, r4
	bl size
	mov r5, r0
	mov r4, #1
	add r10, r4, r5
	str r10, [fp, #-12]
	b .LU9
.LU9:
	ldr r10, [fp, #-12]
	mov r0, r10
	add sp, sp, #8
	pop {r4-r10, fp, pc}
	.size size, .-size
	.align 2
	.global get
get:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #12
	str r0, [fp, #-8]
	str r1, [fp, #-12]
	b .LU15
.LU15:
	ldr r4, [fp, #-12]
	mov r5, #0
	cmp r4, #0
	moveq r5, #1
	cmp r5, #1
	beq .LU16
	b .JN2
.LU16:
	ldr r4, [fp, #-8]
	mov r4, r4
	ldr r4, [r4]
	str r4, [fp, #-16]
	b .LU13
.JN2:
	ldr r4, [fp, #-8]
	add r4, r4, #4
	ldr r5, [r4]
	ldr r6, [fp, #-12]
	mov r4, #1
	sub r4, r6, r4
	mov r0, r5
	mov r1, r4
	bl get
	mov r10, r0
	str r10, [fp, #-16]
	b .LU13
.LU13:
	ldr r10, [fp, #-16]
	mov r0, r10
	add sp, sp, #12
	pop {r4-r10, fp, pc}
	.size get, .-get
	.align 2
	.global pop
pop:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #8
	str r0, [fp, #-8]
	ldr r10, [fp, #-8]
	add r4, r10, #4
	ldr r4, [r4]
	str r4, [fp, #-8]
	ldr r10, [fp, #-8]
	str r10, [fp, #-12]
	b .LU17
.LU17:
	ldr r4, [fp, #-12]
	mov r0, r4
	add sp, sp, #8
	pop {r4-r10, fp, pc}
	.size pop, .-pop
	.align 2
	.global printList
printList:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #4
	str r0, [fp, #-8]
	b .LU21
.LU21:
	ldr r5, [fp, #-8]
	mov r4, #0
	cmp r5, r6
	movne r4, #1
	cmp r4, #1
	beq .LU22
	b .JN3
.LU22:
	ldr r10, [fp, #-8]
	mov r10, r10
	ldr r4, [r10]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r4, [fp, #-8]
	add r4, r4, #4
	ldr r4, [r4]
	mov r0, r4
	bl printList
	b .JN3
.JN3:
	b .LU19
.LU19:
	add sp, sp, #4
	pop {r4-r10, fp, pc}
	.size printList, .-printList
	.align 2
	.global treeprint
treeprint:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #4
	str r0, [fp, #-8]
	b .LU25
.LU25:
	ldr r4, [fp, #-8]
	mov r5, #0
	cmp r4, r6
	movne r5, #1
	cmp r5, #1
	beq .LU26
	b .JN4
.LU26:
	ldr r4, [fp, #-8]
	add r4, r4, #4
	ldr r4, [r4]
	mov r0, r4
	bl treeprint
	ldr r10, [fp, #-8]
	mov r10, r10
	ldr r4, [r10]
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r4, [fp, #-8]
	add r4, r4, #8
	ldr r4, [r4]
	mov r0, r4
	bl treeprint
	b .JN4
.JN4:
	b .LU23
.LU23:
	add sp, sp, #4
	pop {r4-r10, fp, pc}
	.size treeprint, .-treeprint
	.align 2
	.global freeList
freeList:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #4
	str r0, [fp, #-8]
	b .LU29
.LU29:
	ldr r4, [fp, #-8]
	mov r5, #0
	cmp r4, r10
	movne r5, #1
	cmp r5, #1
	beq .LU30
	b .JN5
.LU30:
	ldr r4, [fp, #-8]
	add r4, r4, #4
	ldr r4, [r4]
	mov r0, r4
	bl freeList
	ldr r10, [fp, #-8]
	mov r4, r10
	mov r0, r4
	bl free
	b .JN5
.JN5:
	b .LU27
.LU27:
	add sp, sp, #4
	pop {r4-r10, fp, pc}
	.size freeList, .-freeList
	.align 2
	.global freeTree
freeTree:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #4
	str r0, [fp, #-8]
	b .LU33
.LU33:
	ldr r4, [fp, #-8]
	mov r5, #0
	cmp r4, r10
	moveq r5, #1
	mov r4, #1
	eor r4, r5, r4
	cmp r4, #1
	beq .LU34
	b .JN6
.LU34:
	ldr r4, [fp, #-8]
	add r4, r4, #4
	ldr r4, [r4]
	mov r0, r4
	bl freeTree
	ldr r4, [fp, #-8]
	add r10, r4, #8
	ldr r4, [r10]
	mov r0, r4
	bl freeTree
	ldr r4, [fp, #-8]
	mov r4, r4
	mov r0, r4
	bl free
	b .JN6
.JN6:
	b .LU31
.LU31:
	add sp, sp, #4
	pop {r4-r10, fp, pc}
	.size freeTree, .-freeTree
	.align 2
	.global postOrder
postOrder:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #12
	str r0, [fp, #-8]
	b .LU37
.LU37:
	ldr r4, [fp, #-8]
	mov r6, #0
	cmp r4, r5
	movne r6, #1
	cmp r6, #1
	beq .LU38
	b .JN7
.LU38:
	movw r0, #8
	bl malloc
	mov r4, r0
	mov r4, r4
	str r4, [fp, #-16]
	ldr r4, [fp, #-8]
	mov r4, r4
	ldr r6, [r4]
	ldr r4, [fp, #-16]
	mov r4, r4
	str r6, [r4]
	ldr r4, [fp, #-16]
	add r4, r4, #4
	str r5, [r4]
	ldr r4, [fp, #-8]
	add r4, r4, #4
	ldr r4, [r4]
	mov r0, r4
	bl postOrder
	mov r4, r0
	ldr r6, [fp, #-8]
	add r6, r6, #8
	ldr r6, [r6]
	mov r0, r6
	bl postOrder
	mov r6, r0
	mov r0, r4
	mov r1, r6
	bl concatLists
	mov r6, r0
	ldr r4, [fp, #-16]
	mov r0, r6
	mov r1, r4
	bl concatLists
	mov r10, r0
	str r10, [fp, #-12]
	b .LU35
.JN7:
	str r5, [fp, #-12]
	b .LU35
.LU35:
	ldr r10, [fp, #-12]
	mov r0, r10
	add sp, sp, #12
	pop {r4-r10, fp, pc}
	.size postOrder, .-postOrder
	.align 2
	.global treeadd
treeadd:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #16
	str r0, [fp, #-8]
	str r1, [fp, #-12]
	b .LU41
.LU41:
	ldr r5, [fp, #-8]
	mov r6, #0
	cmp r5, r4
	moveq r6, #1
	cmp r6, #1
	beq .LU42
	b .JN8
.LU42:
	movw r0, #12
	bl malloc
	mov r5, r0
	mov r5, r5
	str r5, [fp, #-20]
	ldr r6, [fp, #-12]
	ldr r5, [fp, #-20]
	mov r5, r5
	str r6, [r5]
	ldr r5, [fp, #-20]
	add r5, r5, #4
	str r4, [r5]
	ldr r5, [fp, #-20]
	add r5, r5, #8
	str r4, [r5]
	ldr r4, [fp, #-20]
	str r4, [fp, #-16]
	b .LU39
.JN8:
	b .LU43
.LU43:
	ldr r4, [fp, #-12]
	ldr r5, [fp, #-8]
	mov r5, r5
	ldr r5, [r5]
	mov r6, #0
	cmp r4, r5
	movlt r6, #1
	cmp r6, #1
	beq .LU44
	b .LU45
.LU44:
	ldr r4, [fp, #-8]
	add r4, r4, #4
	ldr r5, [r4]
	ldr r4, [fp, #-12]
	mov r0, r5
	mov r1, r4
	bl treeadd
	mov r4, r0
	ldr r5, [fp, #-8]
	add r5, r5, #4
	str r4, [r5]
	b .JN9
.JN9:
	ldr r10, [fp, #-8]
	str r10, [fp, #-16]
	b .LU39
.LU45:
	ldr r4, [fp, #-8]
	add r4, r4, #8
	ldr r5, [r4]
	ldr r4, [fp, #-12]
	mov r0, r5
	mov r1, r4
	bl treeadd
	mov r4, r0
	ldr r5, [fp, #-8]
	add r5, r5, #8
	str r4, [r5]
	b .JN9
.LU39:
	ldr r10, [fp, #-16]
	mov r0, r10
	add sp, sp, #16
	pop {r4-r10, fp, pc}
	.size treeadd, .-treeadd
	.align 2
	.global quickSort
quickSort:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #28
	str r0, [fp, #-8]
	str r4, [fp, #-24]
	str r4, [fp, #-28]
	b .LU48
.LU48:
	ldr r5, [fp, #-8]
	mov r0, r5
	bl size
	mov r5, r0
	mov r6, #0
	cmp r5, #1
	movle r6, #1
	cmp r6, #1
	beq .LU49
	b .JN10
.LU49:
	ldr r5, [fp, #-8]
	str r5, [fp, #-12]
	b .LU46
.JN10:
	ldr r5, [fp, #-8]
	mov r0, r5
	mov r1, #0
	bl get
	mov r5, r0
	ldr r6, [fp, #-8]
	ldr r7, [fp, #-8]
	mov r0, r7
	bl size
	mov r8, r0
	mov r7, #1
	sub r7, r8, r7
	mov r0, r6
	mov r1, r7
	bl get
	mov r6, r0
	add r6, r5, r6
	mov r5, #2
	mov r0, r6
	mov r1, r5
	bl __aeabi_idiv
	mov r5, r0
	str r5, [fp, #-16]
	ldr r5, [fp, #-8]
	str r5, [fp, #-32]
	mov r5, #0
	str r5, [fp, #-20]
	b .LU50
.LU50:
	ldr r5, [fp, #-32]
	mov r6, #0
	cmp r5, r4
	movne r6, #1
	cmp r6, #1
	beq .LU51
	b .LU54
.LU51:
	ldr r6, [fp, #-8]
	ldr r5, [fp, #-20]
	mov r0, r6
	mov r1, r5
	bl get
	mov r5, r0
	ldr r6, [fp, #-16]
	mov r7, #0
	cmp r5, r6
	movgt r7, #1
	cmp r7, #1
	beq .LU52
	b .LU53
.LU52:
	ldr r5, [fp, #-28]
	ldr r7, [fp, #-8]
	ldr r6, [fp, #-20]
	mov r0, r7
	mov r1, r6
	bl get
	mov r6, r0
	mov r0, r5
	mov r1, r6
	bl add
	mov r5, r0
	str r5, [fp, #-28]
	b .JN11
.JN11:
	ldr r5, [fp, #-32]
	add r5, r5, #4
	ldr r5, [r5]
	str r5, [fp, #-32]
	ldr r5, [fp, #-20]
	mov r6, #1
	add r5, r5, r6
	str r5, [fp, #-20]
	ldr r5, [fp, #-32]
	mov r6, #0
	cmp r5, r4
	movne r6, #1
	cmp r6, #1
	beq .LU51
	b .LU54
.LU53:
	ldr r5, [fp, #-24]
	ldr r7, [fp, #-8]
	ldr r6, [fp, #-20]
	mov r0, r7
	mov r1, r6
	bl get
	mov r6, r0
	mov r0, r5
	mov r1, r6
	bl add
	mov r5, r0
	str r5, [fp, #-24]
	b .JN11
.LU54:
	ldr r4, [fp, #-8]
	mov r0, r4
	bl freeList
	ldr r4, [fp, #-24]
	mov r0, r4
	bl quickSort
	mov r4, r0
	ldr r5, [fp, #-28]
	mov r0, r5
	bl quickSort
	mov r5, r0
	mov r0, r4
	mov r1, r5
	bl concatLists
	mov r10, r0
	str r10, [fp, #-12]
	b .LU46
.LU46:
	ldr r10, [fp, #-12]
	mov r0, r10
	add sp, sp, #28
	pop {r4-r10, fp, pc}
	.size quickSort, .-quickSort
	.align 2
	.global quickSortMain
quickSortMain:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #8
	str r0, [fp, #-8]
	ldr r5, [fp, #-8]
	mov r0, r5
	bl printList
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r5, [fp, #-8]
	mov r0, r5
	bl printList
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r10, [fp, #-8]
	mov r0, r10
	bl printList
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	str r4, [fp, #-12]
	b .LU55
.LU55:
	ldr r10, [fp, #-12]
	mov r0, r10
	add sp, sp, #8
	pop {r4-r10, fp, pc}
	.size quickSortMain, .-quickSortMain
	.align 2
	.global treesearch
treesearch:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #12
	str r0, [fp, #-8]
	str r1, [fp, #-12]
	mov r1, -1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU59
.LU59:
	ldr r5, [fp, #-8]
	mov r6, #0
	cmp r5, r4
	movne r6, #1
	cmp r6, #1
	beq .LU60
	b .JN15
.LU60:
	ldr r4, [fp, #-8]
	mov r4, r4
	ldr r4, [r4]
	ldr r5, [fp, #-12]
	mov r6, #0
	cmp r4, r5
	moveq r6, #1
	cmp r6, #1
	beq .LU61
	b .JN12
.LU61:
	mov r4, #1
	str r4, [fp, #-16]
	b .LU57
.JN12:
	b .LU62
.LU62:
	ldr r4, [fp, #-8]
	add r4, r4, #4
	ldr r5, [r4]
	ldr r4, [fp, #-12]
	mov r0, r5
	mov r1, r4
	bl treesearch
	mov r4, r0
	mov r5, #0
	cmp r4, #1
	moveq r5, #1
	cmp r5, #1
	beq .LU63
	b .JN13
.LU63:
	mov r4, #1
	str r4, [fp, #-16]
	b .LU57
.JN13:
	b .LU64
.LU64:
	ldr r4, [fp, #-8]
	add r4, r4, #8
	ldr r5, [r4]
	ldr r4, [fp, #-12]
	mov r0, r5
	mov r1, r4
	bl treesearch
	mov r4, r0
	mov r5, #0
	cmp r4, #1
	moveq r5, #1
	cmp r5, #1
	beq .LU65
	b .LU66
.LU65:
	mov r4, #1
	str r4, [fp, #-16]
	b .LU57
.JN14:
	b .JN15
.JN15:
	mov r10, #0
	str r10, [fp, #-16]
	b .LU57
.LU66:
	mov r4, #0
	str r4, [fp, #-16]
	b .LU57
.LU57:
	ldr r10, [fp, #-16]
	mov r0, r10
	add sp, sp, #12
	pop {r4-r10, fp, pc}
	.size treesearch, .-treesearch
	.align 2
	.global inOrder
inOrder:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #12
	str r0, [fp, #-8]
	b .LU69
.LU69:
	ldr r4, [fp, #-8]
	mov r5, #0
	cmp r4, r6
	movne r5, #1
	cmp r5, #1
	beq .LU70
	b .LU71
.LU70:
	movw r0, #8
	bl malloc
	mov r4, r0
	mov r4, r4
	str r4, [fp, #-16]
	ldr r4, [fp, #-8]
	mov r4, r4
	ldr r4, [r4]
	ldr r5, [fp, #-16]
	mov r5, r5
	str r4, [r5]
	ldr r4, [fp, #-16]
	add r4, r4, #4
	str r6, [r4]
	ldr r4, [fp, #-8]
	add r4, r4, #4
	ldr r4, [r4]
	mov r0, r4
	bl inOrder
	mov r4, r0
	ldr r5, [fp, #-16]
	ldr r6, [fp, #-8]
	add r6, r6, #8
	ldr r6, [r6]
	mov r0, r6
	bl inOrder
	mov r6, r0
	mov r0, r5
	mov r1, r6
	bl concatLists
	mov r5, r0
	mov r0, r4
	mov r1, r5
	bl concatLists
	mov r10, r0
	str r10, [fp, #-12]
	b .LU67
.JN16:
	b .LU67
.LU71:
	str r6, [fp, #-12]
	b .LU67
.LU67:
	ldr r10, [fp, #-12]
	mov r0, r10
	add sp, sp, #12
	pop {r4-r10, fp, pc}
	.size inOrder, .-inOrder
	.align 2
	.global bintreesearch
bintreesearch:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #12
	str r0, [fp, #-8]
	str r1, [fp, #-12]
	mov r1, -1
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	b .LU74
.LU74:
	ldr r5, [fp, #-8]
	mov r6, #0
	cmp r5, r4
	movne r6, #1
	cmp r6, #1
	beq .LU75
	b .JN19
.LU75:
	ldr r4, [fp, #-8]
	mov r4, r4
	ldr r4, [r4]
	ldr r5, [fp, #-12]
	mov r6, #0
	cmp r4, r5
	moveq r6, #1
	cmp r6, #1
	beq .LU76
	b .JN17
.LU76:
	mov r4, #1
	str r4, [fp, #-16]
	b .LU72
.JN17:
	b .LU77
.LU77:
	ldr r4, [fp, #-12]
	ldr r5, [fp, #-8]
	mov r5, r5
	ldr r5, [r5]
	mov r6, #0
	cmp r4, r5
	movlt r6, #1
	cmp r6, #1
	beq .LU78
	b .LU79
.LU78:
	ldr r4, [fp, #-8]
	add r4, r4, #4
	ldr r5, [r4]
	ldr r4, [fp, #-12]
	mov r0, r5
	mov r1, r4
	bl bintreesearch
	mov r4, r0
	str r4, [fp, #-16]
	b .LU72
.JN18:
	b .JN19
.JN19:
	mov r10, #0
	str r10, [fp, #-16]
	b .LU72
.LU79:
	ldr r4, [fp, #-8]
	add r4, r4, #8
	ldr r5, [r4]
	ldr r4, [fp, #-12]
	mov r0, r5
	mov r1, r4
	bl bintreesearch
	mov r4, r0
	str r4, [fp, #-16]
	b .LU72
.LU72:
	ldr r10, [fp, #-16]
	mov r0, r10
	add sp, sp, #12
	pop {r4-r10, fp, pc}
	.size bintreesearch, .-bintreesearch
	.align 2
	.global buildTree
buildTree:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #16
	str r0, [fp, #-8]
	str null, [fp, #-20]
	mov r4, #0
	str r4, [fp, #-16]
	b .LU82
.LU82:
	ldr r4, [fp, #-16]
	ldr r5, [fp, #-8]
	mov r0, r5
	bl size
	mov r5, r0
	mov r6, #0
	cmp r4, r5
	movlt r6, #1
	cmp r6, #1
	beq .LU83
	b .LU84
.LU83:
	ldr r4, [fp, #-20]
	ldr r6, [fp, #-8]
	ldr r5, [fp, #-16]
	mov r0, r6
	mov r1, r5
	bl get
	mov r5, r0
	mov r0, r4
	mov r1, r5
	bl treeadd
	mov r4, r0
	str r4, [fp, #-20]
	ldr r5, [fp, #-16]
	mov r4, #1
	add r4, r5, r4
	str r4, [fp, #-16]
	ldr r6, [fp, #-16]
	ldr r4, [fp, #-8]
	mov r0, r4
	bl size
	mov r4, r0
	mov r5, #0
	cmp r6, r4
	movlt r5, #1
	cmp r5, #1
	beq .LU83
	b .LU84
.LU84:
	ldr r10, [fp, #-20]
	str r10, [fp, #-12]
	b .LU80
.LU80:
	ldr r10, [fp, #-12]
	mov r0, r10
	add sp, sp, #16
	pop {r4-r10, fp, pc}
	.size buildTree, .-buildTree
	.align 2
	.global treeMain
treeMain:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #16
	str r0, [fp, #-8]
	ldr r4, [fp, #-8]
	mov r0, r4
	bl buildTree
	mov r4, r0
	str r4, [fp, #-12]
	ldr r4, [fp, #-12]
	mov r0, r4
	bl treeprint
	mov r1, r5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r4, [fp, #-12]
	mov r0, r4
	bl inOrder
	mov r4, r0
	str r4, [fp, #-16]
	ldr r4, [fp, #-16]
	mov r0, r4
	bl printList
	mov r1, r5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r4, [fp, #-16]
	mov r0, r4
	bl freeList
	ldr r4, [fp, #-12]
	mov r0, r4
	bl postOrder
	mov r4, r0
	str r4, [fp, #-20]
	ldr r4, [fp, #-20]
	mov r0, r4
	bl printList
	mov r1, r5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r4, [fp, #-20]
	mov r0, r4
	bl freeList
	ldr r4, [fp, #-12]
	mov r0, r4
	mov r1, #0
	bl treesearch
	mov r4, r0
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r1, r5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r4, [fp, #-12]
	mov r0, r4
	mov r1, #10
	bl treesearch
	mov r4, r0
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r1, r5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r4, [fp, #-12]
	mov r0, r4
	mov r1, #-2
	bl treesearch
	mov r4, r0
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r1, r5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r4, [fp, #-12]
	mov r0, r4
	mov r1, #2
	bl treesearch
	mov r4, r0
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r1, r5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r4, [fp, #-12]
	mov r0, r4
	mov r1, #3
	bl treesearch
	mov r4, r0
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r1, r5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r4, [fp, #-12]
	mov r0, r4
	mov r1, #9
	bl treesearch
	mov r4, r0
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r1, r5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r4, [fp, #-12]
	mov r0, r4
	mov r1, #1
	bl treesearch
	mov r4, r0
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r1, r5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r4, [fp, #-12]
	mov r0, r4
	mov r1, #0
	bl bintreesearch
	mov r4, r0
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r1, r5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r4, [fp, #-12]
	mov r0, r4
	mov r1, #10
	bl bintreesearch
	mov r4, r0
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r1, r5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r4, [fp, #-12]
	mov r0, r4
	mov r1, #-2
	bl bintreesearch
	mov r4, r0
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r1, r5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r4, [fp, #-12]
	mov r0, r4
	mov r1, #2
	bl bintreesearch
	mov r4, r0
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r1, r5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r4, [fp, #-12]
	mov r0, r4
	mov r1, #3
	bl bintreesearch
	mov r4, r0
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r1, r5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r4, [fp, #-12]
	mov r0, r4
	mov r1, #9
	bl bintreesearch
	mov r4, r0
	mov r1, r4
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r1, r5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r4, [fp, #-12]
	mov r0, r4
	mov r1, #1
	bl bintreesearch
	mov r10, r0
	mov r1, r10
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	mov r1, r5
	movw r0, #:lower16:.PRINTLN_FMT
	movt r0, #:upper16:.PRINTLN_FMT
	bl printf
	ldr r10, [fp, #-12]
	mov r0, r10
	bl freeTree
	b .LU85
.LU85:
	add sp, sp, #16
	pop {r4-r10, fp, pc}
	.size treeMain, .-treeMain
	.align 2
	.global myCopy
myCopy:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #8
	str r0, [fp, #-8]
	b .LU89
.LU89:
	ldr r4, [fp, #-8]
	mov r5, #0
	cmp r4, r6
	moveq r5, #1
	cmp r5, #1
	beq .LU90
	b .JN20
.LU90:
	str r6, [fp, #-12]
	b .LU87
.JN20:
	ldr r4, [fp, #-8]
	mov r4, r4
	ldr r4, [r4]
	mov r0, r6
	mov r1, r4
	bl add
	mov r4, r0
	ldr r5, [fp, #-8]
	add r5, r5, #4
	ldr r5, [r5]
	mov r0, r5
	bl myCopy
	mov r5, r0
	mov r0, r4
	mov r1, r5
	bl concatLists
	mov r10, r0
	str r10, [fp, #-12]
	b .LU87
.LU87:
	ldr r10, [fp, #-12]
	mov r0, r10
	add sp, sp, #8
	pop {r4-r10, fp, pc}
	.size myCopy, .-myCopy
	.align 2
	.global main
main:
	push {r4-r10, fp, lr}
	add fp, sp, #4
	sub sp, sp, #28
	str null, [fp, #-20]
	str null, [fp, #-24]
	str null, [fp, #-28]
	mov r4, #0
	str r4, [fp, #-12]
	b .LU93
.LU93:
	ldr r4, [fp, #-12]
	mov r5, #0
	cmp r4, #10
	movlt r5, #1
	cmp r5, #1
	beq .LU94
	b .LU95
.LU94:
	movw r1, #:lower16:.read_scratch
	movt r1, #:upper16:.read_scratch
	movw r0, #:lower16:.READ_FMT
	movt r0, #:upper16:.READ_FMT
	bl scanf
	movw r0, #:lower16:.read_scratch
	movt r0, #:upper16:.read_scratch
	ldr r0, [r0]
	str r0, [fp, #-16]
	ldr r5, [fp, #-20]
	ldr r4, [fp, #-16]
	mov r0, r5
	mov r1, r4
	bl add
	mov r4, r0
	str r4, [fp, #-20]
	ldr r4, [fp, #-20]
	mov r0, r4
	bl myCopy
	mov r4, r0
	str r4, [fp, #-24]
	ldr r4, [fp, #-20]
	mov r0, r4
	bl myCopy
	mov r4, r0
	str r4, [fp, #-28]
	ldr r4, [fp, #-24]
	mov r0, r4
	bl quickSortMain
	mov r4, r0
	str r4, [fp, #-32]
	ldr r4, [fp, #-32]
	mov r0, r4
	bl freeList
	ldr r4, [fp, #-28]
	mov r0, r4
	bl treeMain
	ldr r4, [fp, #-12]
	mov r5, #1
	add r4, r4, r5
	str r4, [fp, #-12]
	ldr r4, [fp, #-12]
	mov r5, #0
	cmp r4, #10
	movlt r5, #1
	cmp r5, #1
	beq .LU94
	b .LU95
.LU95:
	ldr r4, [fp, #-20]
	mov r0, r4
	bl freeList
	ldr r4, [fp, #-24]
	mov r0, r4
	bl freeList
	ldr r4, [fp, #-28]
	mov r0, r4
	bl freeList
	mov r10, #0
	str r10, [fp, #-8]
	b .LU91
.LU91:
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
