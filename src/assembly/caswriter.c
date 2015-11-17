/******************* This file handles opening and closing the ***************** 
 *                   output file that is being written to                      *
 *                   Dillon Daudert 11/16/2015                                 *
 ******************************************************************************/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "cas.h"

FILE *casout;

/* cas_open takes the path to the output file to be created, which is
 * the name of the .cmm file with the .cmm replaced with .s
 * It returns a 0 on success, -1 on failure.
 */
int cas_open(char *path)
{
    char *newpath = malloc(sizeof(char)*strlen(path)+1);
    char *caspath;
    //Create new string to tokenize, separating the .cmm from the end
    strncpy(newpath, path, strlen(path));
    newpath[strlen(path)] = '\0';
    newpath = strtok(newpath, ".");
    //Alloc string for the assembly file, + ".s" at the end
    caspath = malloc(sizeof(char)*strlen(newpath)+3);
    //Copy old path and new ending
    strncpy(caspath, newpath, strlen(newpath)+1);
    strcat(caspath, ".s");
    free(newpath);
    if( (casout = fopen(caspath, "w")) == NULL) return -1;
    return 0;
}

int cas_close()
{
    if( fclose(casout) == EOF ) return -1;
    return 0;
}

/* cas_prol() takes no arguments
 * It writes the prologue that is generic to every assembly file generated
 * It returns 0 on success, -1 on failure
 */
int cas_prol()
{
    if(casout == NULL) return -1;
    char *l1 = "\t.section\t.rodata";
    char *l2 = ".int_wformat: .string \"\%d\\n\"";
    char *l3 = ".str_wformat: .string \"\%s\\n\"";
    char *l4 = ".int_rformat: .string \"\%d\"";
    if( cas_writeln(l1) == -1) return -1;
    if( cas_writeln(l2) == -1) return -1;
    if( cas_writeln(l3) == -1) return -1;
    if( cas_writeln(l4) == -1) return -1;
    return 0; 
}

/* cas_writeln is a generic write function that all other cas_ functions call
 * to write to the assembly file. It ends all writes with a new line char.
 * It returns the number of bytes written. -1 on error
 */
int cas_writeln(char *output)
{
    int nwritt;
    if(casout == NULL) return -1;
    nwritt = fwrite(output, 1, strlen(output), casout) * strlen(output);
    nwritt += fwrite("\n", 1, sizeof(char), casout);
    return nwritt;
}

/* cas_write is a generic write function that cas_ functions call. It does not
 * end what it writes with a new line.
 * Return number of bytes written on success, -1 otherwise;
 */
int cas_write(char *output)
{
    int nwritt;
    if(casout == NULL) return -1;
    nwritt = fwrite(output, 1, strlen(output), casout) * strlen(output);
    return nwritt;
}
