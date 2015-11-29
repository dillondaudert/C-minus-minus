/* ***************** This is the header file exposing the necessary structs / enums
 *                   for any program that wishes to use registers in the assembly
 */
typedef enum {
    ax, bx, cx, dx, r8, r9, r10, r11, r12, r13, r14, r15
} REGS;

extern char *reg_get32b(int *);
extern char *reg_get64b(int *);
extern char *reg_getFP(int *);
extern int reg_release(int);
