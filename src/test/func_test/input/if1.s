	.section	.rodata
.int_wformat: .string "%d\n"
.str_wformat: .string "%s\n"
.int_rformat: .string "%d"
.string_const0: .string "enter a:"
.string_const1: .string "enter b:"
.string_const2: .string "a = str_wformat, %edi
	call	printf
	movl	$.string_const1, %ebx
	movl	%ebx, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
"
.string_const3: .string "b = Ø"
.string_const4: .string "a = l	$.string_const0, %ebx
	movl	%ebx, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
	movl	$.string_const1, %ebx
	movl	%ebx, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
	movl	$.string_const2, %ebx
	movl	%ebx, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
	movl	$.string_const3, %ebx
	movl	%ebx, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
"
.string_const5: .string "b = Ø"

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
	movl	$.string_const1, %ebx
	movl	%ebx, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
	movl	$.string_const2, %ebx
	movl	%ebx, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
	movl	$.string_const3, %ebx
	movl	%ebx, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
	movl	$.string_const4, %ebx
	movl	%ebx, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
	movl	$.string_const5, %ebx
	movl	%ebx, %esi
	movl	$0, %eax
	movl	$.str_wformat, %edi
	call	printf
	leave
	ret
	.size	main, .-main

