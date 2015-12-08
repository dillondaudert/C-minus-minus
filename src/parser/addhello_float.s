	.section	.rodata
.int_wformat: .string "%d\n"
.str_wformat: .string "%s\n"
.int_rformat: .string "%d"
.flt_wformat: .string "%f\n"
.flt_rformat: .string "%f"
.string_const0: .string "a == b, expect 1:"
.string_const1: .string "a != b, expect 0:"
.string_const2: .string "a == b, expect 0:"
.string_const3: .string "a != b, expect 1:"
.string_const4: .string "a < b, expect 1:"
.string_const5: .string "a > b, expect 0:"
.string_const6: .string "a(4) <= b(5), expect 1:"
.string_const7: .string "a(5) <= b(5), expect 1:"
.string_const8: .string "a >= b, expect 1:"
.string_const9: .string "b(5) >= a(6), expect 0:"
.string_const10: .string "a >= b, expect 1:"

	.globl main
	.type main @function

main:	nop
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$8, %rsp
	movq	%rbp, %rax
	subq	$0, %rax
	movl	$4, %ebx
	movl	%ebx, (%rax)
	movq	%rbp, %rax
	subq	$4, %rax
	movl	$4, %ebx
	movl	%ebx, (%rax)
	movl	$.string_const0, %eax
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
	movq	%rbp, %rax
	subq	$0, %rax
	movl	(%rax), %ebx
	movq	%rbp, %rax
	subq	$4, %rax
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
	movq	%rbp, %rax
	subq	$0, %rax
	movl	(%rax), %ebx
	movq	%rbp, %rax
	subq	$4, %rax
	movl	(%rax), %ecx
	cmpl	%ecx, %ebx
	movl	$0, %ebx
	movl	$1, %ecx
	cmovne	%ecx, %ebx
	movl	%ebx, %esi
	movl	$0, %eax
	movl	$.int_wformat, %edi
	call	printf
	movq	%rbp, %rax
	subq	$4, %rax
	movl	$5, %ebx
	movl	%ebx, (%rax)
	movl	$.string_const2, %eax
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
	movq	%rbp, %rax
	subq	$0, %rax
	movl	(%rax), %ebx
	movq	%rbp, %rax
	subq	$4, %rax
	movl	(%rax), %ecx
	cmpl	%ecx, %ebx
	movl	$0, %ebx
	movl	$1, %ecx
	cmove	%ecx, %ebx
	movl	%ebx, %esi
	movl	$0, %eax
	movl	$.int_wformat, %edi
	call	printf
	movl	$.string_const3, %eax
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
	movl	$.string_const4, %eax
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
	movq	%rbp, %rax
	subq	$0, %rax
	movl	(%rax), %ebx
	movq	%rbp, %rax
	subq	$4, %rax
	movl	(%rax), %ecx
	cmpl	%ecx, %ebx
	movl	$0, %ebx
	movl	$1, %ecx
	cmovl	%ecx, %ebx
	movl	%ebx, %esi
	movl	$0, %eax
	movl	$.int_wformat, %edi
	call	printf
	movl	$.string_const5, %eax
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
	movq	%rbp, %rax
	subq	$0, %rax
	movl	(%rax), %ebx
	movq	%rbp, %rax
	subq	$4, %rax
	movl	(%rax), %ecx
	cmpl	%ecx, %ebx
	movl	$0, %ebx
	movl	$1, %ecx
	cmovg	%ecx, %ebx
	movl	%ebx, %esi
	movl	$0, %eax
	movl	$.int_wformat, %edi
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
	subq	$4, %rax
	movl	(%rax), %ecx
	cmpl	%ecx, %ebx
	movl	$0, %ebx
	movl	$1, %ecx
	cmovle	%ecx, %ebx
	movl	%ebx, %esi
	movl	$0, %eax
	movl	$.int_wformat, %edi
	call	printf
	movq	%rbp, %rax
	subq	$0, %rax
	movl	$5, %ebx
	movl	%ebx, (%rax)
	movl	$.string_const7, %eax
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
	movq	%rbp, %rax
	subq	$0, %rax
	movl	(%rax), %ebx
	movq	%rbp, %rax
	subq	$4, %rax
	movl	(%rax), %ecx
	cmpl	%ecx, %ebx
	movl	$0, %ebx
	movl	$1, %ecx
	cmovle	%ecx, %ebx
	movl	%ebx, %esi
	movl	$0, %eax
	movl	$.int_wformat, %edi
	call	printf
	movl	$.string_const8, %eax
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
	movq	%rbp, %rax
	subq	$0, %rax
	movl	(%rax), %ebx
	movq	%rbp, %rax
	subq	$4, %rax
	movl	(%rax), %ecx
	cmpl	%ecx, %ebx
	movl	$0, %ebx
	movl	$1, %ecx
	cmovge	%ecx, %ebx
	movl	%ebx, %esi
	movl	$0, %eax
	movl	$.int_wformat, %edi
	call	printf
	movq	%rbp, %rax
	subq	$0, %rax
	movl	$6, %ebx
	movl	%ebx, (%rax)
	movl	$.string_const9, %eax
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
	movq	%rbp, %rax
	subq	$4, %rax
	movl	(%rax), %ebx
	movq	%rbp, %rax
	subq	$0, %rax
	movl	(%rax), %ecx
	cmpl	%ecx, %ebx
	movl	$0, %ebx
	movl	$1, %ecx
	cmovge	%ecx, %ebx
	movl	%ebx, %esi
	movl	$0, %eax
	movl	$.int_wformat, %edi
	call	printf
	movl	$.string_const10, %eax
	movl	%eax, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
	movq	%rbp, %rax
	subq	$0, %rax
	movl	(%rax), %ebx
	movq	%rbp, %rax
	subq	$4, %rax
	movl	(%rax), %ecx
	cmpl	%ecx, %ebx
	movl	$0, %ebx
	movl	$1, %ecx
	cmovge	%ecx, %ebx
	movl	%ebx, %esi
	movl	$0, %eax
	movl	$.int_wformat, %edi
	call	printf
	leave
	ret
	.size	main, .-main

