	.section	.rodata
.int_wformat: .string "%d\n"
.str_wformat: .string "%s\n"
.int_rformat: .string "%d"
	.comm _gp, 16, 4

	.globl main
	.type main @function

main:	nop
	.size	main, .-main
	leave
	ret
