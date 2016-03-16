    .section    .rodata
.int_wformat: .string "%d\n"
    .globl main
    .type main @function

main:   nop
    pushq   %rbp
    movq    %rsp, %rbp
    subq    $8, %rsp
    movq    %rbp, %rax
    movl    $10, (%rax)
    movq    %rbp, %rax
    subq    $4, %rax
    movss   .v0(%rip), %xmm0
    movss   %xmm0, (%rax)
    movss   .v0(%rip), %xmm1
    movl    $10, %eax
    cvtsi2ss    %eax, %xmm0
    ucomiss %xmm1, %xmm0
    movl    $0, %eax
    movl    $1, %ebx
    cmovl   %ebx, %eax
    movl    %eax, %esi
    movl    $0, %eax
    movl    $.int_wformat, %edi
    call printf 
    leave
    ret
    .size   main, .-main

.v0:
    .float  5.500000
