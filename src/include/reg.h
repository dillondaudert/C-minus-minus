/* ***************** This is the header file exposing the necessary structs / enums
 *                   for any program that wishes to use registers in the assembly
 */
typedef enum {
    ax, bx, cx, dx, r8, r9, r10, r11, r12, r13, r14, r15
} REGS;

typedef enum {
    xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, xmm8, 
    xmm9, xmm10, xmm11, xmm12, xmm13, xmm14, xmm15
} XMM_REGS;

extern int reg_get();
extern int reg_getXMM();
extern char *reg_getName32(int);
extern char *reg_getName64(int);
extern char *reg_getNameXMM(int);
extern int reg_release(int);
extern int xmm_release(int);
