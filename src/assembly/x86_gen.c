/* Generator functions for various aspects of the assembly.
 * Moved to here in order to remove clutter in grammar and to follow the 
 * Do Not Repeat Yourself philosophy.
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <cmm.h>
#include <stable.h>
#include <cas.h>
#include <lval.h>
#include <reg.h>

/******************************************************************************
 * Move and conditional move functions
 *
 * ***************************************************************************/

int mov_i(char *s_name, char *d_name)
{
    char *buf; 
    if((buf = calloc(64, sizeof(char))) == NULL){
        return -1;
    }

    snprintf(buf, 64, "\tmovl\t%%%s, %%%s\n", s_name, d_name);
    cas_proc_body(NULL, buf);
    free(buf);
    return 0;   
}

int cmov_e(char *s_name, char *d_name)
{
    char *buf; 
    if((buf = calloc(64, sizeof(char))) == NULL){
        return -1;
    }

    snprintf(buf, 64, "\tcmove\t%%%s, %%%s\n", s_name, d_name);
    cas_proc_body(NULL, buf);
    free(buf);
    return 0;
}


/******************************************************************************
 * Comparison functions
 *
 * ***************************************************************************/

int cmp_i(char *s_name, char *d_name)
{
    char *buf; 
    if((buf = calloc(64, sizeof(char))) == NULL){
        return -1;
    }

    //Output instruction (s_reg < d_reg?)
    snprintf(buf, 64, "\tcmpl\t%%%s, %%%s\n", s_name, d_name);
    cas_proc_body(NULL, buf);
    free(buf);
    return 0;
}

int cmp_f(char *s_name, char *d_name)
{
    char *buf;
    if((buf = calloc(64, sizeof(char))) == NULL){
        return -1;
    }

    //Output instruction (s_reg < d_reg?)
    snprintf(buf, 64, "\tucomiss\t%%%s, %%%s\n", s_name, d_name);
    cas_proc_body(NULL, buf);
    free(buf);
    return 0;
}

/******************************************************************************
 * Conversion functions
 *
 * ***************************************************************************/

int cvt_i2s(char *s_name, char *d_name)
{
    char *buf;
    if((buf = calloc(64, sizeof(char))) == NULL){
        return -1;
    }

    //Output instruction (s_reg < d_reg?)
    snprintf(buf, 64, "\tcvtsi2ss\t%%%s, %%%s\n", s_name, d_name);
    cas_proc_body(NULL, buf);
    free(buf);
    return 0;
}

int cvt_s2i(char *s_name, char *d_name)
{
    char *buf;
    if((buf = calloc(64, sizeof(char))) == NULL){
        return -1;
    }

    //Output instruction (s_reg < d_reg?)
    snprintf(buf, 64, "\tcvtss2si\t%%%s, %%%s\n", s_name, d_name);
    cas_proc_body(NULL, buf);
    free(buf);
    return 0;
}
