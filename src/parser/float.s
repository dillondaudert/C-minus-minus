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
	movl	%eax, (%rax)
	leave
	ret
	.size	main, .-main
.v0:
	.float	3.300000

