/******************* cas.h contains all the header information for *************
 *                   the cmm assembly output files.                            *
 *                   Dillon Daudert 11/16/2015                                 *
 ******************************************************************************/

extern FILE *casout;

extern int cas_open(char *);
extern int cas_prol();
extern int cas_writeln(char *);
extern int cas_write(char *);
