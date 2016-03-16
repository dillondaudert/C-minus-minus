	.section	.rodata
.int_wformat: .string "%d\n"
.str_wformat: .string "%s\n"
.int_rformat: .string "%d"
.flt_wformat: .string "%f\n"
.flt_rformat: .string "%f"
.string_const0: .string "10 < 5.5"
.string_const1: .string "5.5 < 10"
.string_const2: .string "10 > 5.5"
.string_const3: .string "5.5 > 10"
.string_const4: .string "5.5 <= 10"
.string_const5: .string "10 >= 5.5"
.string_const6: .string "9 < 10"
.string_const7: .string "9 > 10"
.string_const8: .string "5.5 <= 5.5"

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
	movss	.v1(%rip), %xmm0
	cvtsi2ss	%eax, %xmm1
	ucomiss	%xmm0, %xmm1
	movl	$0, %eax
	movl	$1, %ebx
	cmovl	%ebx, %eax
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.int_wformat, %edi
	call	printf
	movq	%rbp, %rax
	subq	$0, %rax
	movl	(%rax), %ebx
	movq	%rbp, %rax
	subq	$4, %rax
	movss	(%rax), %xmm0
	cvtsi2ss	%ebx, %xmm1
	ucomiss	%xmm0, %xmm1
	movl	$0, %ebx
	movl	$1, %eax
	cmovl	%eax, %ebx
	movl	%ebx, %esi
	movl	$0, %eax
	movl	$.int_wformat, %edi
	call	printf
	movl	$.string_const1, %eax
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
	movss	.v2(%rip), %xmm0
	movl	$10, %eax
	cvtsi2ss	%eax, %xmm1
	ucomiss	%xmm1, %xmm0
	movl	$1, %eax
	movl	$0, %ebx
	cmovl	%eax, %ebx
	movl	%ebx, %esi
	movl	$0, %eax
	movl	$.int_wformat, %edi
	call	printf
	movq	%rbp, %rax
	subq	$4, %rax
	movss	(%rax), %xmm0
	movq	%rbp, %rax
	subq	$0, %rax
	movl	(%rax), %ebx
	cvtsi2ss	%ebx, %xmm1
	ucomiss	%xmm1, %xmm0
	movl	$1, %ebx
	movl	$0, %eax
	cmovl	%ebx, %eax
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.int_wformat, %edi
	call	printf
	movl	$.string_const2, %eax
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
	movl	$10, %eax
	movss	.v3(%rip), %xmm0
	cvtsi2ss	%eax, %xmm1
	ucomiss	%xmm0, %xmm1
	movl	$0, %eax
	movl	$1, %ebx
	cmovg	%ebx, %eax
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.int_wformat, %edi
	call	printf
	movq	%rbp, %rax
	subq	$0, %rax
	movl	(%rax), %ebx
	movq	%rbp, %rax
	subq	$4, %rax
	movss	(%rax), %xmm0
	cvtsi2ss	%ebx, %xmm1
	ucomiss	%xmm0, %xmm1
	movl	$0, %ebx
	movl	$1, %eax
	cmovg	%eax, %ebx
	movl	%ebx, %esi
	movl	$0, %eax
	movl	$.int_wformat, %edi
	call	printf
	movl	$.string_const3, %eax
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
	movss	.v4(%rip), %xmm0
	movl	$10, %eax
	cvtsi2ss	%eax, %xmm1
	ucomiss	%xmm1, %xmm0
	movl	$1, %eax
	movl	$0, %ebx
	cmovg	%eax, %ebx
	movl	%ebx, %esi
	movl	$0, %eax
	movl	$.int_wformat, %edi
	call	printf
	movq	%rbp, %rax
	subq	$4, %rax
	movss	(%rax), %xmm0
	movq	%rbp, %rax
	subq	$0, %rax
	movl	(%rax), %ebx
	cvtsi2ss	%ebx, %xmm1
	ucomiss	%xmm1, %xmm0
	movl	$1, %ebx
	movl	$0, %eax
	cmovg	%ebx, %eax
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.int_wformat, %edi
	call	printf
	movl	$.string_const4, %eax
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
	movss	.v5(%rip), %xmm0
	movl	$10, %eax
	cvtsi2ss	%eax, %xmm1
	ucomiss	%xmm1, %xmm0
	movl	$1, %eax
	movl	$0, %ebx
	cmovle	%eax, %ebx
	movl	%ebx, %esi
	movl	$0, %eax
	movl	$.int_wformat, %edi
	call	printf
	movq	%rbp, %rax
	subq	$4, %rax
	movss	(%rax), %xmm0
	movq	%rbp, %rax
	subq	$0, %rax
	movl	(%rax), %ebx
	cvtsi2ss	%ebx, %xmm1
	ucomiss	%xmm1, %xmm0
	movl	$1, %ebx
	movl	$0, %eax
	cmovle	%ebx, %eax
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.int_wformat, %edi
	call	printf
	movl	$.string_const5, %eax
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
	movl	$10, %eax
	movss	.v6(%rip), %xmm0
	cvtsi2ss	%eax, %xmm1
	ucomiss	%xmm0, %xmm1
	movl	$0, %eax
	movl	$1, %ebx
	cmovge	%ebx, %eax
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.int_wformat, %edi
	call	printf
	movq	%rbp, %rax
	subq	$0, %rax
	movl	(%rax), %ebx
	movq	%rbp, %rax
	subq	$4, %rax
	movss	(%rax), %xmm0
	cvtsi2ss	%ebx, %xmm1
	ucomiss	%xmm0, %xmm1
	movl	$0, %ebx
	movl	$1, %eax
	cmovge	%eax, %ebx
	movl	%ebx, %esi
	movl	$0, %eax
	movl	$.int_wformat, %edi
	call	printf
	movl	$.string_const6, %eax
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
	movl	$9, %eax
	movl	$10, %ebx
	cmpl	%ebx, %eax
	movl	$0, %eax
	movl	$1, %ebx
	cmovl	%ebx, %eax
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.int_wformat, %edi
	call	printf
	movl	$.string_const7, %eax
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
	movl	$9, %eax
	movl	$10, %ebx
	cmpl	%ebx, %eax
	movl	$0, %eax
	movl	$1, %ebx
	cmovg	%ebx, %eax
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.int_wformat, %edi
	call	printf
	movl	$.string_const8, %eax
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
	movss	.v7(%rip), %xmm0
	movss	.v8(%rip), %xmm1
	ucomiss	%xmm1, %xmm0
	movl	$0, %eax
	movl	$1, %ebx
	cmovle	%ebx, %eax
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
	cmovle	%ecx, %eax
	movl	%eax, %esi
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
	.float	5.500000
.v5:
	.float	5.500000
.v6:
	.float	5.500000
.v7:
	.float	5.500000
.v8:
	.float	5.500000

