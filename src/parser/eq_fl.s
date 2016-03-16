	.section	.rodata
.int_wformat: .string "%d\n"
.str_wformat: .string "%s\n"
.int_rformat: .string "%d"
.flt_wformat: .string "%f\n"
.flt_rformat: .string "%f"
.string_const0: .string "10 == 10"
.string_const1: .string "5.5 == 5.5"
.string_const2: .string "5.5 == 10"
.string_const3: .string "5.0 == 5"

	.globl main
	.type main @function

main:	nop
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$8, %rsp
	movq	%rbp, %rax
	subq	$0, %rax
	movl	$10, %ebx
	movl	%ebx, (%rax)
	movq	%rbp, %rax
	subq	$4, %rax
	movss	.v0(%rip), %xmm0
	movss	%xmm0, (%rax)
	movl	$.string_const0, %eax
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
	movl	$10, %eax
	movl	$10, %ebx
	cmpl	%ebx, %eax
	movl	$0, %eax
	movl	$1, %ebx
	cmove	%ebx, %eax
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.int_wformat, %edi
	call	printf
	movq	%rbp, %rax
	subq	$0, %rax
	movl	(%rax), %ebx
	movq	%rbp, %rax
	subq	$0, %rax
	movl	(%rax), %ecx
	cmpl	%ecx, %ebx
	movl	$0, %ebx
	movl	$1, %ecx
	cmove	%ecx, %ebx
	movl	%ebx, %esi
	movl	$0, %eax
	movl	$.int_wformat, %edi
	call	printf
	movl	$.string_const1, %eax
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
	movss	.v1(%rip), %xmm0
	movss	.v2(%rip), %xmm1
	ucomiss	%xmm1, %xmm0
	movl	$0, %eax
	movl	$1, %ebx
	cmove	%ebx, %eax
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.int_wformat, %edi
	call	printf
	movq	%rbp, %rax
	subq	$4, %rax
	movss	(%rax), %xmm0
	movq	%rbp, %rax
	subq	$4, %rax
	movss	(%rax), %xmm1
	ucomiss	%xmm1, %xmm0
	movl	$0, %eax
	movl	$1, %ecx
	cmove	%ecx, %eax
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.int_wformat, %edi
	call	printf
	movl	$.string_const2, %eax
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
	movss	.v3(%rip), %xmm0
	movl	$10, %eax
	cvtsi2ss	%eax, %xmm1
	ucomiss	%xmm1, %xmm0
	movl	$1, %eax
	movl	$0, %edx
	cmove	%eax, %edx
	movl	%edx, %esi
	movl	$0, %eax
	movl	$.int_wformat, %edi
	call	printf
	movq	%rbp, %rdx
	subq	$4, %rdx
	movss	(%rdx), %xmm0
	movq	%rbp, %rdx
	subq	$0, %rdx
	movl	(%rdx), %r8d
	cvtsi2ss	%r8d, %xmm1
	ucomiss	%xmm1, %xmm0
	movl	$1, %r8d
	movl	$0, %edx
	cmove	%r8d, %edx
	movl	%edx, %esi
	movl	$0, %eax
	movl	$.int_wformat, %edi
	call	printf
	movl	$.string_const3, %edx
	movl	%edx, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
	movss	.v4(%rip), %xmm0
	movl	$5, %edx
	cvtsi2ss	%edx, %xmm1
	ucomiss	%xmm1, %xmm0
	movl	$1, %edx
	movl	$0, %r9d
	cmove	%edx, %r9d
	movl	%r9d, %esi
	movl	$0, %eax
	movl	$.int_wformat, %edi
	call	printf
	leave
	ret
	.size	main, .-main
.v0:
	.float	5.500000
.v1:
	.float	5.500000
.v2:
	.float	5.500000
.v3:
	.float	5.500000
.v4:
	.float	5.000000

