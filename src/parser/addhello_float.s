	.section	.rodata
.int_wformat: .string "%d\n"
.str_wformat: .string "%s\n"
.int_rformat: .string "%d"
.flt_wformat: .string "%f\n"
.flt_rformat: .string "%f"
	.comm _gp, 16, 4

.string_const0: .string "Hello, world"
.LC0:
	.long	0x1.99999ap+1
	.align 4

	.globl main
	.type main @function

main:	nop
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$8, %rsp
	movl	$.string_const0, %ebx
	movl	%ebx, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
	movl	$10, %esi
	movl	$0, %eax
	movl	$.int_wformat, %edi
	call	printf
	movss	$0.000000, %xmm0
	movl	$1, %eax
	movl	$.flt_wformat, %edi
	call	printf
	leave
	ret
	.size	main, .-main

