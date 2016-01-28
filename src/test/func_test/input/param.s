	.section	.rodata
.int_wformat: .string "%d\n"
.str_wformat: .string "%s\n"
.int_rformat: .string "%d"
	.comm _gp, 16, 4

	.globl b4
	.type b4 @function
	.globl d2
	.type d2 @function
	.globl d3
	.type d3 @function
	.globl d1
	.type d1 @function
	.globl main
	.type main @function

b4:	nop
	pushq	%rbp
	movq	%rsp, %rbp
d2:	nop
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$4, %rsp
d3:	nop
	pushq	%rbp
	movq	%rsp, %rbp
d1:	nop
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$4, %rsp
main:	nop
	pushq	%rbp
	movq	%rsp, %rbp
	ret
	ret
	ret
	ret
	leave
	ret
	.size	b4, .-b4
	.size	d2, .-d2
	.size	d3, .-d3
	.size	d1, .-d1
	.size	main, .-main

