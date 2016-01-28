	.section	.rodata
.int_wformat: .string "%d\n"
.str_wformat: .string "%s\n"
.int_rformat: .string "%d"
	.comm _gp, 8, 4

	.globl gcd
	.type gcd @function
	.globl main
	.type main @function

gcd:	nop
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$4, %rsp
main:	nop
	pushq	%rbp
	movq	%rsp, %rbp
	ret
	leave
	ret
	.size	gcd, .-gcd
	.size	main, .-main

