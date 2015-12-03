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
	call	printf              ;calling printf correctly
	movl	$10, %eax
	movl	$20, %ebx
	addl	%eax, %ebx          ;will call printf here
	movq	$_gp, %rax
	addq	$0, %rax            ;reference global 1
	movl	$1, %ecx
	movl	%ecx, (%rax)        ;put $1 into global 1!
	movq	$_gp, %rax
	addq	$8, %rax            ;reference global 3, k
	movl	$3, %ecx
	movl	%ecx, (%rax)        ;put 3 into k!
	movq	$_gp, %rax          
	addq	$12, %rax           ;reference l
	movl	$4, %ecx
	movl	%ecx, (%rax)        ;put 4 into l!
	movq	$_gp, %rax
	addq	$4, %rax            ;reference j!
	movq	$_gp, %rcx
	addq	$0, %rcx
	movl	(%rcx), %edx        ;dereference i, put 32bit value into edx
	movq	$_gp, %rcx
	addq	$8, %rcx
	movl	(%rcx), %r8d        ; dereference k, put 32bit value into r8d
	addl	%edx, %r8d          ; add i(edx) into k(r8d), free edx
	movq	$_gp, %rcx
	addq	$12, %rcx
	movl	(%rcx), %edx        ;dereference l, put into edx
	addl	%r8d, %edx          ;add i+k to l(edx), free r8d
	movl	%edx, (%rax)        ;move i+k+l into j!!!!
	movq	$_gp, %rax
	addq	$4, %rax
	movl	(%rax), %ecx
	leave
	ret
	.size	main, .-main

