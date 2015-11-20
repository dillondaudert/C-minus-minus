	.section	.rodata
.int_wformat: .string "%d\n"
.str_wformat: .string "%s\n"
.int_rformat: .string "%d"

.string_const0: .string "Hello world!"

	.globl main
	.type main @function

main:	nop
	.size	main, .-main
	leave
	ret
