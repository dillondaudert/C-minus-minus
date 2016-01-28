	.section	.rodata
.int_wformat: .string "%d\n"
.str_wformat: .string "%s\n"
.int_rformat: .string "%d"
	.comm _gp, 8, 4

	.globl decls
	.type decls @function
	.globl foo
	.type foo @function
	.globl main
	.type main @function

decls:	nop
	pushq	%rbp
	movq	%rsp, %rbp
foo:	nop
	pushq	%rbp
	movq	%rsp, %rbp
main:	nop
	pushq	%rbp
	movq	%rsp, %rbp
	ret
	ret
	leave
	ret
	.size	decls, .-decls
	.size	foo, .-foo
	.size	main, .-main

