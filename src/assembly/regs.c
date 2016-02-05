/******************* This file contains the code that manages the available ****
 *                   registers to the parser. A simple function call will be ***
 *                   able to return a string with the next available register */
#include <stdio.h>
#include <string.h>
#include "reg.h"
#include "cmm.h"

#define NUM_REGS 12
#define NUM_XMM 16

static int regs[NUM_REGS] = {0};
static int xmm_regs[NUM_XMM] = {0};

/* reg_get() returns an integer value for an unused register.
 * If all registers are full, it will return -1
 */
int reg_get()
{
    REGS i;
    for(i = 0; i < NUM_REGS && regs[i] != 0; i++);
    switch(i){
        case ax:
            regs[i] = 1;
            return 0;
        case bx:
            regs[i] = 1;
            return 1;
        case cx:
            regs[i] = 1;
            return 2;
        case dx:
            regs[i] = 1;
            return 3;
        case r8:
            regs[i] = 1;
            return 4;
        case r9:
            regs[i] = 1;
            return 5;
        case r10:
            regs[i] = 1;
            return 6;
        case r11:
            regs[i] = 1;
            return 7;
        case r12:
            regs[i] = 1;
            return 8;
        case r13:
            regs[i] = 1;
            return 9;
        case r14:
            regs[i] = 1;
            return 10;
        case r15:
            regs[i] = 1;
            return 11;
    }
    if(DEBUG) printf("Registers exhausted; error!\n");
    return -1;
}

/* reg_getXMM returns an integer value for an xmm register
 * If all xmm registers are taken, -1 will be returned*/
int reg_getXMM()
{
    XMM_REGS i;
    for(i = 0; i < NUM_XMM && xmm_regs[i] != 0; i++);
    switch(i){
        case xmm0:
            xmm_regs[i] = 1;
            return 0;
        case xmm1:
            xmm_regs[i] = 1;
            return 1;
        case xmm2:
            xmm_regs[i] = 1;
            return 2;
        case xmm3:
            xmm_regs[i] = 1;
            return 3;
        case xmm4:
            xmm_regs[i] = 1;
            return 4;
        case xmm5:
            xmm_regs[i] = 1;
            return 5;
        case xmm6:
            xmm_regs[i] = 1;
            return 6;
        case xmm7:
            xmm_regs[i] = 1;
            return 7;
        case xmm8:
            xmm_regs[i] = 1;
            return 8;
        case xmm9:
            xmm_regs[i] = 1;
            return 9;
        case xmm10:
            xmm_regs[i] = 1;
            return 10;
        case xmm11:
            xmm_regs[i] = 1;
            return 11;
        case xmm12:
            xmm_regs[i] = 1;
            return 12;
        case xmm13:
            xmm_regs[i] = 1;
            return 13;
        case xmm14:
            xmm_regs[i] = 1;
            return 14;
        case xmm15:
            xmm_regs[i] = 1;
            return 15;
    }
    if(DEBUG) printf("XMM Registers exhausted; error!\n");
    return -1;

}

/* reg_getName32 returns the lower 32bit name of the register
 * specified by the integer parameter, reg.
 */
char *reg_getName32(int reg)
{
    REGS i = reg;
    switch(i){
        case ax:
            return "eax";
        case bx:
            return "ebx";
        case cx:
            return "ecx";
        case dx:
            return "edx";
        case r8:
            return "r8d";
        case r9:
            return "r9d";
        case r10:
            return "r10d";
        case r11:
            return "r11d";
        case r12:
            return "r12d";
        case r13:
            return "r13d";
        case r14:
            return "r14d";
        case r15:
            return "r15d";
    }
    if(DEBUG) printf("Cannot find 32b reg name, error!\n");
    return NULL;
}

/* reg_getName64 returns the 64bit name of the register
 * indicated by the integer parameter reg
 */
char *reg_getName64(int reg)
{
    REGS i = reg;
    switch(i){
        case ax:
            return "rax";
        case bx:
            return "rbx";
        case cx:
            return "rcx";
        case dx:
            return "rdx";
        case r8:
            return "r8";
        case r9:
            return "r9";
        case r10:
            return "r10";
        case r11:
            return "r11";
        case r12:
            return "r12";
        case r13:
            return "r13";
        case r14:
            return "r14";
        case r15:
            return "r15";
    }
    if(DEBUG) printf("Cannot find 64b reg name, error!\n");
    return NULL;
}

char *reg_getNameXMM(int xmm)
{
    XMM_REGS i = xmm;
    switch(i){
        case xmm0:
            return "xmm0";
        case xmm1:
            return "xmm1";
        case xmm2:
            return "xmm2";
        case xmm3:
            return "xmm3";
        case xmm4:
            return "xmm4";
        case xmm5:
            return "xmm5";
        case xmm6:
            return "xmm6";
        case xmm7:
            return "xmm7";
        case xmm8:
            return "xmm8";
        case xmm9:
            return "xmm9";
        case xmm10:
            return "xmm10";
        case xmm11:
            return "xmm11";
        case xmm12:
            return "xmm12";
        case xmm13:
            return "xmm13";
        case xmm14:
            return "xmm14";
        case xmm15:
            return "xmm15";
    }
    if(DEBUG) printf("Cannot find name for xmm register, error!\n");
    return NULL;
}

/* reg_release returns the register specified by reg
 * to the list of available registers
 */
int reg_release(int reg)
{
    regs[reg] = 0;
    return 0;
}

int xmm_release(int xmm_reg)
{
    xmm_regs[xmm_reg] = 0;
    return 0;
}
