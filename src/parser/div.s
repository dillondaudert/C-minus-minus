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
	movl	$51, %eax
	movl	$18, %ebx
	pushq	%rdx
	cltd
	idivl	%ebx
	popq	%rdx
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.int_wformat, %edi
	call	printf
	movq	%rbp, %rax
	subq	$0, %rax
	movl	$100, %ebx
	movl	%ebx, (%rax)
	movq	%rbp, %rax
	subq	$8, %rax
	movl	$5, %ebx
	movl	%ebx, (%rax)
	movq	%rbp, %rax
	subq	$12, %rax
	movl	$2, %ebx
	movl	%ebx, (%rax)
	movq	%rbp, %rax
	subq	$4, %rax
	movq	%rbp, %rbx
	subq	$0, %rbx
	movl	(%rbx), %ecx
	movq	%rbp, %rbx
	subq	$8, %rbx
	movl	(%rbx), %edx
	pushq	%rax
	movl	%ecx, %eax
	movl	%edx, %ebx
	pushq	%rdx
	cltd
	idivl	%ebx
	popq	%rdx
	movl	%eax, %ecx
	popq	%rax
	movq	%rbp, %rbx
	subq	$12, %rbx
	movl	(%rbx), %edx
	pushq	%rax
	movl	%ecx, %eax
	movl	%edx, %ebx
	pushq	%rdx
	cltd
	idivl	%ebx
	popq	%rdx
	movl	%eax, %ecx
	popq	%rax
	movl	%ecx, (%rax)
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

