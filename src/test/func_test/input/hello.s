	.section	.rodata
.int_wformat: .string "%d\n"
.str_wformat: .string "%s\n"
.int_rformat: .string "%d"
.string_const0: .string "Hello world!"

	.globl main
	.type main @function

main:	nop
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$.string_const0, %ebx
	movl	%ebx, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
	leave
	ret
	.size	main, .-main

