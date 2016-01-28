	.section	.rodata
.int_wformat: .string "%d\n"
.str_wformat: .string "%s\n"
.int_rformat: .string "%d"
	.globl b1
	.type b1 @function
	.globl b2
	.type b2 @function
	.globl b3
	.type b3 @function
	.globl b4
	.type b4 @function
	.globl main
	.type main @function

b1:	nop
	pushq	%rbp
	movq	%rsp, %rbp
b2:	nop
	pushq	%rbp
	movq	%rsp, %rbp
b3:	nop
	pushq	%rbp
	movq	%rsp, %rbp
b4:	nop
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
	.size	b1, .-b1
	.size	b2, .-b2
	.size	b3, .-b3
	.size	b4, .-b4
	.size	main, .-main

