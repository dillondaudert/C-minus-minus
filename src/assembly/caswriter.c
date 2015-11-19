/******************* This file handles opening and closing the ***************** 
 *                   output file that is being written to                      *
 *                   Dillon Daudert 11/16/2015                                 *
 ******************************************************************************/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "cas.h"

FILE *casout;

/******************* Internal strings and string arrays ***********************/

//Static (data) section
char *sec_static;
//Static string section
char *sec_str_const;
//Global (function) section
char *sec_globals;
//Contains function headers
char *sec_proc_heads;
//Contains function declarations
char *sec_proc_decls;
//Contains function bodies
char *sec_proc_bods;

/******************* Internal functions ***************************************/

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

/* cas_close() closes the assembly output file after cas_writer has finished
 * It returns a -1 if an error is encountered
 */
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

/******************* Externally called functions section **********************/

/* cas_writer is the end write function that the compiler calls.
 * Its job is to consolidate all of the various data/text/global sections
 * sent to caswriter by the parser and write them out to the assembly file
 * in proper order.
 */
int cas_writer()
{
    //Open assembly output file
    cas_open();
    //Write the assembly sections in order
    //Prologue
    cas_prol();
    //Static/data section
    cas_write(sec_static);
    //String constants section
    cas_write(sec_str_const);
    //Global section
    cas_write(sec_globals);
    //Process heads section
    cas_write(sec_proc_heads);
    //Process var declarations
    cas_write(sec_proc_decls);
    //Process bodies
    cas_write(sec_proc_bods);
    //Epilogue
    cas_epil();
  
    //Close the assembly file
    cas_close();
    return 0;
}

/* The cas_* functions each append the input to the end of the assembly section
 * that is indicated by their name
 * In certain cases, a first argument specifies a location in an array of
 * strings
 */
int cas_static(char *statics)
{
    //Initialize the static section if empty
    if( sec_static == NULL ){
        if( ( sec_static = calloc(4, sizeof(char)) ) == NULL ){
            printf("Calloc error in caswriter.c:cas_static\n");
            exit(0);
        }
        //Null terminate string at beginning
        sec_static[0] = '\0';
    }

    //Allocate new string with space for appending
    char *tmp = calloc(strlen(sec_static)+strlen(statics)+1, sizeof(char));
    //Copy old statis + null termination
    strncpy(tmp, sec_static, strlen(sec_static)+1);
    //Concat new string
    strcat(tmp, statics);
    sec_static = strdup(tmp);
    //Free strings
    free(statics);
    free(tmp);
    return 0;
}

int cas_str_const(int num, char *strc)
{
    //Initialize the string constant section if empty
    if( sec_str_cont == NULL ){
        if( ( sec_str_const = calloc(4, sizeof(char)) ) == NULL ){
            printf("Calloc error in caswriter.c:cas_str_const\n");
            exit(0);
        }
        //Null terminate string at beginning
        sec_str_const[0] = '\0';
    }

    //Allocate new string with space for appending
    char *tmp = calloc(strlen(sec_str_const)+strlen(strc)+1, sizeof(char));
    //Copy old statis + null termination
    strncpy(tmp, sec_str_const, strlen(sec_str_const)+1);
    //Concat new string
    strcat(tmp, strc);
    sec_str_const = strdup(tmp);
    //Free strings
    free(strc);
    free(tmp);
    return 0;
}

int cas_global(char *globals)
{
    //Initialize the static section if empty
    if( sec_globals == NULL ){
        if( ( sec_globals = calloc(4, sizeof(char)) ) == NULL ){
            printf("Calloc error in caswriter.c:cas_globals\n");
            exit(0);
        }
        //Null terminate string at beginning
        sec_globals[0] = '\0';
    }

    //Allocate new string with space for appending
    char *tmp = calloc(strlen(sec_globals)+strlen(globals)+1, sizeof(char));
    //Copy old statis + null termination
    strncpy(tmp, sec_globals, strlen(sec_globals)+1);
    //Concat new string
    strcat(tmp, globals);
    sec_globals = strdup(tmp);
    //Free strings
    free(globals);
    free(tmp);
    return 0;
}

int cas_proc_head(char *name, char *defin)
{
    //Initialize the static section if empty
    if( sec_proc_heads == NULL ){
        if( ( sec_proc_heads = calloc(8, sizeof(char)) ) == NULL ){
            printf("Calloc error in caswriter.c:cas_proc_heads\n");
            exit(0);
        }
        //Null terminate string at beginning
        sec_proc_heads[0] = '\0';
    }

    //Allocate new string with space for appending
    char *tmp = calloc(strlen(sec_proc_heads)+strlen(defin)+1, sizeof(char));
    //Copy old statis + null termination
    strncpy(tmp, sec_proc_heads, strlen(sec_proc_heads)+1);
    //Concat new string
    strcat(tmp,defin);
    sec_proc_heads = strdup(tmp);
    //Free strings
    free(defin);
    free(tmp);
    return 0;
}

int cas_proc_decls(char *name, char *decls)
{
    //Initialize the static section if empty
    if( sec_proc_decls == NULL ){
        if( ( sec_proc_decls = calloc(8, sizeof(char)) ) == NULL ){
            printf("Calloc error in caswriter.c:cas_proc_decls\n");
            exit(0);
        }
        //Null terminate string at beginning
        sec_proc_decls[0] = '\0';
    }

    //Allocate new string with space for appending
    char *tmp = calloc(strlen(sec_proc_decls)+strlen(decls)+1, sizeof(char));
    //Copy old statis + null termination
    strncpy(tmp, sec_proc_decls, strlen(sec_proc_decls)+1);
    //Concat new string
    strcat(tmp, decls);
    sec_proc_decls = strdup(tmp);
    //Free strings
    free(decls);
    free(tmp);
    return 0;
}

int cas_proc_body(char *name, char *body)
{
    //Initialize the static section if empty
    if( sec_proc_bods == NULL ){
        if( ( sec_proc_bods = calloc(8, sizeof(char)) ) == NULL ){
            printf("Calloc error in caswriter.c:cas_proc_body\n");
            exit(0);
        }
        //Null terminate string at beginning
        sec_proc_bods[0] = '\0';
    }

    //Allocate new string with space for appending
    char *tmp = calloc(strlen(sec_proc_bods)+strlen(body)+1, sizeof(char));
    //Copy old statis + null termination
    strncpy(tmp, sec_proc_bods, strlen(sec_proc_bods )+1);
    //Concat new string
    strcat(tmp,body);
    sec_proc_bods = strdup(tmp);
    //Free strings
    free(body);
    free(tmp);
    return 0;
}
