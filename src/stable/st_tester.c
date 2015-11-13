#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "stable.h"
#include "cmm.h"

int main(int argv, char **argc)
{
    st_init();

    symb *s1, *s2, *s3, *s4;

    char *n1, *n2, *n3, *a1, *a2, *a3;

    n1 = malloc(sizeof(char)*3);
    a1 = malloc(sizeof(char)*4);
    sprintf(n1, "S1"); 
    sprintf(a1, "gp_");

    n2 = malloc(sizeof(char)*3);
    a2 = malloc(sizeof(char)*4);
    sprintf(n2, "S2");
    sprintf(a2, "gp_");

    n3 = malloc(sizeof(char)*3);
    a3 = malloc(sizeof(char)*4);
    sprintf(n3, "S3");
    sprintf(a3, "gp_");

    s1 = st_add_symbol(n1, a1, 4, VAR, 4);
    s2 = st_add_symbol(n2, a2, 4, VAR, 4);
    s3 = st_add_symbol(n3, a3, 4, VAR, 4);

    s4 = st_get_symbol("S1");
    printf("s1 name: %s, addr: %s\n", s4->name, s4->addr);
    if(st_get_symbol("S4") == NULL){
        printf("S4 does not exist in st\n");
    }

    st_destroy();
    return 0;
}
