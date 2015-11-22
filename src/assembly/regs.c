/******************* This file contains the code that manages the available ****
 *                   registers to the parser. A simple function call will be ***
 *                   able to return a string with the next available register */
#include <stdio.h>
#include <string.h>
#include "reg.h"
#include "cmm.h"

#define length 12

static int regs[length] = {0};

char *reg_get32b(int *num)
{
    REGS i;
    for(i = 0; i < length && regs[i] != 0; i++);
    switch(i){
        case ax:
            regs[i] = 1;
            *num = 0;
            return "eax";
        case bx:
            regs[i] = 1;
            *num = 1;
            return "ebx";
        case cx:
            regs[i] = 1;
            *num = 2;
            return "ecx";
        case dx:
            regs[i] = 1;
            *num = 3;
            return "edx";
        case r8:
            regs[i] = 1;
            *num = 4;
            return "r8d";
        case r9:
            regs[i] = 1;
            *num = 5;
            return "r9d";
        case r10:
            regs[i] = 1;
            *num = 6;
            return "r10d";
        case r11:
            regs[i] = 1;
            *num = 7;
            return "r11d";
        case r12:
            regs[i] = 1;
            *num = 8;
            return "r12d";
        case r13:
            regs[i] = 1;
            *num = 9;
            return "r13d";
        case r14:
            regs[i] = 1;
            *num = 10;
            return "r14d";
        case r15:
            regs[i] = 1;
            *num = 11;
            return "r15d";
    }
    if(DEBUG) printf("Registers exhausted; error!\n");
    return NULL;
}

char *reg_get64b(int *num)
{
    REGS i;
    for(i = 0; i < length && regs[i] != 0; i++);
    switch(i){
        case ax:
            regs[i] = 1;
            *num = 0;
            return "rax";
        case bx:
            regs[i] = 1;
            *num = 1;
            return "rbx";
        case cx:
            regs[i] = 1;
            *num = 2;
            return "rcx";
        case dx:
            regs[i] = 1;
            *num = 3;
            return "rdx";
        case r8:
            regs[i] = 1;
            *num = 4;
            return "r8";
        case r9:
            regs[i] = 1;
            *num = 5;
            return "r9";
        case r10:
            regs[i] = 1;
            *num = 6;
            return "r10";
        case r11:
            regs[i] = 1;
            *num = 7;
            return "r11";
        case r12:
            regs[i] = 1;
            *num = 8;
            return "r12";
        case r13:
            regs[i] = 1;
            *num = 9;
            return "r13";
        case r14:
            regs[i] = 1;
            *num = 10;
            return "r14";
        case r15:
            regs[i] = 1;
            *num = 11;
            return "r15";
    }
    if(DEBUG) printf("Registers exhausted; error!\n");
    return NULL;
}

char *reg_getFP(int *num)
{
    return NULL;
}

int reg_release(int num)
{
    regs[num] = 0;
    return 0;
}
