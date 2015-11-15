#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "stable.h"
#include "cmm.h"

#define LEN 3
#define MOD 512

char chars[27] = "abcdefghijklmnopqrstuvwxyz";
char *test_string;
int st_arr[MOD];

void test_perms(int);

int main(int argv, char **argc)
{
    st_init();

    symb *s1, *s2, *s3, *s4;

    char *n1, *n2, *n3, *a1, *a2, *a3;

    n1 = malloc(sizeof(char)*2);
    a1 = malloc(sizeof(char)*4);
    sprintf(n1, "x"); 
    sprintf(a1, "gp_");

    n2 = malloc(sizeof(char)*3);
    a2 = malloc(sizeof(char)*4);
    sprintf(n2, "zz");
    sprintf(a2, "gp_");

    n3 = malloc(sizeof(char)*3);
    a3 = malloc(sizeof(char)*4);
    sprintf(n3, "S3");
    sprintf(a3, "gp_");

    s1 = st_add_symbol(n1, a1, 4, VAR, 4);
    s2 = st_add_symbol(n2, a2, 4, VAR, 4);
    s3 = st_add_symbol(n3, a3, 4, VAR, 4);

    s4 = st_get_symbol("zz");
    printf("s1 name: %s, addr: %s\n", s4->name, s4->addr);
    if(st_get_symbol("S4") == NULL){
        printf("S4 does not exist in st\n");
    }

    st_destroy();

    test_string = malloc(sizeof(char)*LEN);
    memset(st_arr, '0', MOD);
    memset(test_string, '\0', LEN);
    
    //test_perms(0);

    free(test_string);

 
    return 0;
}

void test_perms(int i)
{
    if( i == LEN ) return;
    int j, res;
    unsigned long int hash;
    hash = st_hash(test_string);
    res = hash % MOD;
    st_arr[res]++;
    //if(st_arr[res] > 1) printf("String %s has key %d, collision\n", test_string, res);
    if( res == 89 ) printf("%s:89\n", test_string);
    for( j = 0; j < 26; j++ ){
        test_string[i] = chars[j];
        test_perms(i+1);
        test_string[i] = '\0';
    }
}
