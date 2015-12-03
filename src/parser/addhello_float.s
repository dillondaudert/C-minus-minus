	.section	.rodata
.int_wformat: .string "%d\n"
.str_wformat: .string "%s\n"
.int_rformat: .string "%d"
.flt_wformat: .string "%f\n"
.flt_rformat: .string "%f"
	.comm _gp, 16, 4

.string_const0: .string "Hello, world"

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
	movl	$10, %eax
	movl	$20, %ebx
	addl	%eax, %ebx
	movl	%ebx, %esi
	movl	$0, %eax
	movl	$.int_wformat, %edi
	call	printf
	movq	$_gp, %rax
	addq	$0, %rax
	movl	$1, %ebx
	movl	%ebx, (%rax)
	movq	$_gp, %rax
	addq	$8, %rax
	movl	$3, %ebx
	movl	%ebx, (%rax)
	movq	$_gp, %rax
	addq	$12, %rax
	movl	$4, %ebx
	movl	%ebx, (%rax)
	movq	$_gp, %rax
	addq	$4, %rax
	movq	$_gp, %rbx
	addq	$0, %rbx
	movl	(%rbx), %ecx
	movq	$_gp, %rbx
	addq	$8, %rbx
	movl	(%rbx), %edx
	addl	%ecx, %edx
	movq	$_gp, %rbx
	addq	$12, %rbx
	movl	(%rbx), %ecx
	addl	%edx, %ecx
	movl	%ecx, (%rax)
	movq	$_gp, %rax
	addq	$4, %rax
	movl	(%rax), %ebx
	movl	%ebx, %esi
	movl	$0, %eax
	movl	$.int_wformat, %edi
	call	printf
	leave
	ret
	.size	main, .-main

