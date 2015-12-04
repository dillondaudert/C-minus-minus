	.section	.rodata
.int_wformat: .string "%d\n"
.str_wformat: .string "%s\n"
.int_rformat: .string "%d"
.flt_wformat: .string "%f\n"
.flt_rformat: .string "%f"
	.comm _gp, 12, 4

	.globl main
	.type main @function

main:	nop
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$8, %rsp
	movq	%rbp, %rax
	subq	$4, %rax
	movl	$6, %ebx
	movl	%ebx, (%rax)
	movq	$_gp, %rax
	addq	$0, %rax
	movl	$3, %ebx
	movl	%ebx, (%rax)
	movq	$_gp, %rax
	addq	$4, %rax
	movl	$4, %ebx
	movl	%ebx, (%rax)
	movq	$_gp, %rax
	addq	$8, %rax
	movq	$_gp, %rbx
	addq	$0, %rbx
	movl	(%rbx), %ecx
	movq	$_gp, %rbx
	addq	$4, %rbx
	movl	(%rbx), %edx
	addl	%ecx, %edx
	movl	%edx, (%rax)
	movq	$_gp, %rax
	addq	$8, %rax
	movl	(%rax), %ebx
	movl	%ebx, %esi
	movl	$0, %eax
	movl	$.int_wformat, %edi
	call	printf
	movq	%rbp, %rax
	subq	$4, %rax
	movl	(%rax), %ebx
	movl	%ebx, %esi
	movl	$0, %eax
	movl	$.int_wformat, %edi
	call	printf
	leave
	ret
	.size	main, .-main

