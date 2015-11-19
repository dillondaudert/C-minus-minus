/******************* cas.h contains all the header information for *************
 *                   the cmm assembly output files.                            *
 *                   Dillon Daudert 11/16/2015                                 *
 ******************************************************************************/

//List of output assembly section
#define SEC_PROL 0
#define SEC_STATIC 1
#define SEC_STR_CONST 2
#define SEC_GLOBAL 3
#define SEC_PROC_HEAD 4
#define SEC_PROC_DECL 5
#define SEC_PROC_BODY 6
#define SEC_EPIL 7

extern FILE *casout;

extern int cas_writer();
extern int cas_static(char *);
extern int cas_str_const(int, char *);
extern int cas_global(char *);
extern int cas_proc_head(char *, char *);
extern int cas_proc_decls(char *, char *);
extern int cas_proc_body(char *, char *);
