	.section	.rodata
.int_wformat: .string "%d\n"
.str_wformat: .string "%s\n"
.int_rformat: .string "%d"
	.globl main
	.type main @function

main:	nop
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp
	leave
	ret
	.size	main, .-main

