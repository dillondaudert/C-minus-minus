	.section	.rodata
.int_wformat: .string "%d\n"
.str_wformat: .string "%s\n"
.int_rformat: .string "%d"
	.comm _gp, 16, 4

	.globl a1
	.type a1 @function
	.globl a2
	.type a2 @function
	.globl a3
	.type a3 @function
	.globl a4
	.type a4 @function
	.globl main
	.type main @function

a1:	nop
	pushq	%rbp
	movq	%rsp, %rbp
a2:	nop
	pushq	%rbp
	movq	%rsp, %rbp
a3:	nop
	pushq	%rbp
	movq	%rsp, %rbp
a4:	nop
	pushq	%rbp
	movq	%rsp, %rbp
main:	nop
	pushq	%rbp
	movq	%rsp, %rbp
	ret
	ret
	ret
	ret
	leave
	ret
	.size	a1, .-a1
	.size	a2, .-a2
	.size	a3, .-a3
	.size	a4, .-a4
	.size	main, .-main

