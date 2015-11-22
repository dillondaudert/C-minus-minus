#include <stdio.h>
#include <string.h>
#include "reg.h"

void main(void)
{
    int r1, r2, r3;
    printf("REG32: %s\n", reg_get32b(&r1));
    printf("val: %d\n", r1);
    printf("REG32: %s\n", reg_get32b(&r2));
    printf("val: %d\n", r2);
    reg_release(r2);
    printf("Released: %d\n", r2);
    printf("REG64: %s\n", reg_get64b(&r3));
    printf("val: %d\n", r3);
    
}
