	.section	.rodata
.int_wformat: .string "%d\n"
.str_wformat: .string "%s\n"
.int_rformat: .string "%d"
.flt_wformat: .string "%f\n"
.flt_rformat: .string "%f"
	.globl main
	.type main @function

main:	nop
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp
	movq	%rbp, %rax
	subq	$0, %rax
	movl	$4, %ebx
	movl	%ebx, (%rax)
	movq	%rbp, %rax
	subq	$8, %rax
	movss	.v0(%rip), %xmm0
	movss	%xmm0, (%rax)
	movq	%rbp, %rax
	subq	$0, %rax
	movl	(%rax), %ebx
	movl	%ebx, %esi
	movl	$0, %eax
	movl	$.int_wformat, %edi
	call	printf
	movq	%rbp, %rax
	subq	$8, %rax
	movss	(%rax), %xmm0
	cvtps2pd	%xmm0, %xmm0
	movl	$1, %eax
	movl	$.flt_wformat, %edi
	call	printf
	leave
	ret
	.size	main, .-main
.v0:
	.float	3.300000

