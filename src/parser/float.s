	.section	.rodata
.int_wformat: .string "%d\n"
.str_wformat: .string "%s\n"
.int_rformat: .string "%d"
.flt_wformat: .string "%f\n"
.flt_rformat: .string "%f"
.string_const0: .string "10 - 6.5 ="
.string_const1: .string "6.5 - 10 ="
.string_const2: .string "6.5 - 6.5 ="
.string_const3: .string "10 * 6.5 ="
.string_const4: .string "6.5* 10 ="
.string_const5: .string "6.5 * 6.5 ="
.string_const6: .string "10 / 6.5 ="
.string_const7: .string "6.5 / 10 ="
.string_const8: .string "6.5 / 6.5 ="
.string_const9: .string "10 / 3 ="

	.globl main
	.type main @function

main:	nop
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp
	movq	%rbp, %rax
	subq	$0, %rax
	movl	$10, %ebx
	movl	%ebx, (%rax)
	movq	%rbp, %rax
	subq	$8, %rax
	movss	.v0(%rip), %xmm0
	movss	%xmm0, (%rax)
	movl	$.string_const0, %eax
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
	movq	%rbp, %rax
	subq	$0, %rax
	movl	(%rax), %ebx
	movq	%rbp, %rax
	subq	$8, %rax
	movss	(%rax), %xmm0
	cvtsi2ss	%ebx, %xmm1
	subss	%xmm0, %xmm1
	movss	%xmm1, %xmm0
	cvtps2pd	%xmm0, %xmm0
	movl	$1, %eax
	movl	$.flt_wformat, %edi
	call	printf
	movl	$.string_const1, %eax
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
	movq	%rbp, %rax
	subq	$8, %rax
	movss	(%rax), %xmm0
	movq	%rbp, %rax
	subq	$0, %rax
	movl	(%rax), %ebx
	cvtsi2ss	%ebx, %xmm1
	subss	%xmm1, %xmm0
	cvtps2pd	%xmm0, %xmm0
	movl	$1, %eax
	movl	$.flt_wformat, %edi
	call	printf
	movl	$.string_const2, %eax
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
	movq	%rbp, %rax
	subq	$8, %rax
	movss	(%rax), %xmm0
	movq	%rbp, %rax
	subq	$8, %rax
	movss	(%rax), %xmm2
	subss	%xmm2, %xmm0
	cvtps2pd	%xmm0, %xmm0
	movl	$1, %eax
	movl	$.flt_wformat, %edi
	call	printf
	movl	$.string_const3, %eax
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
	movq	%rbp, %rax
	subq	$0, %rax
	movl	(%rax), %ebx
	movq	%rbp, %rax
	subq	$8, %rax
	movss	(%rax), %xmm0
	cvtsi2ss	%ebx, %xmm2
	mulss	%xmm0, %xmm2
	movss	%xmm2, %xmm0
	cvtps2pd	%xmm0, %xmm0
	movl	$1, %eax
	movl	$.flt_wformat, %edi
	call	printf
	movl	$.string_const4, %eax
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
	movq	%rbp, %rax
	subq	$8, %rax
	movss	(%rax), %xmm0
	movq	%rbp, %rax
	subq	$0, %rax
	movl	(%rax), %ebx
	cvtsi2ss	%ebx, %xmm2
	mulss	%xmm2, %xmm0
	cvtps2pd	%xmm0, %xmm0
	movl	$1, %eax
	movl	$.flt_wformat, %edi
	call	printf
	movl	$.string_const5, %eax
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
	movq	%rbp, %rax
	subq	$8, %rax
	movss	(%rax), %xmm0
	movq	%rbp, %rax
	subq	$8, %rax
	movss	(%rax), %xmm3
	mulss	%xmm3, %xmm0
	cvtps2pd	%xmm0, %xmm0
	movl	$1, %eax
	movl	$.flt_wformat, %edi
	call	printf
	movl	$.string_const6, %eax
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
	movq	%rbp, %rax
	subq	$0, %rax
	movl	(%rax), %ebx
	movq	%rbp, %rax
	subq	$8, %rax
	movss	(%rax), %xmm0
	cvtsi2ss	%ebx, %xmm3
	divss	%xmm0, %xmm3
	movss	%xmm3, %xmm0
	cvtps2pd	%xmm0, %xmm0
	movl	$1, %eax
	movl	$.flt_wformat, %edi
	call	printf
	movl	$.string_const7, %eax
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
	movq	%rbp, %rax
	subq	$8, %rax
	movss	(%rax), %xmm0
	movq	%rbp, %rax
	subq	$0, %rax
	movl	(%rax), %ebx
	cvtsi2ss	%ebx, %xmm3
	divss	%xmm3, %xmm0
	cvtps2pd	%xmm0, %xmm0
	movl	$1, %eax
	movl	$.flt_wformat, %edi
	call	printf
	movl	$.string_const8, %eax
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
	movq	%rbp, %rax
	subq	$8, %rax
	movss	(%rax), %xmm0
	movq	%rbp, %rax
	subq	$8, %rax
	movss	(%rax), %xmm4
	divss	%xmm4, %xmm0
	cvtps2pd	%xmm0, %xmm0
	movl	$1, %eax
	movl	$.flt_wformat, %edi
	call	printf
	movl	$.string_const9, %eax
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
	movq	%rbp, %rax
	subq	$0, %rax
	movl	(%rax), %ebx
	movl	$3, %eax
	movl	%eax, %ecx
	pushq	%rax
	movl	%ebx, %eax
	pushq	%rdx
	cltd
	idivl	%ecx
	popq	%rdx
	movl	%eax, %ebx
	popq	%rax
	movl	%ebx, %esi
	movl	$0, %eax
	movl	$.int_wformat, %edi
	call	printf
	leave
	ret
	.size	main, .-main
.v0:
	.float	6.500000

