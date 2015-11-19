#include <stdio.h>
#include <stdlib.h>
#include "cmm.h"
#include "stable.h"
#include "cas.h"
#include "grammar.tab.h"

#define YYPRINT(file, type, value) yyprint (file, type, value)

/* External variable declarations */
extern FILE *yyin;

/* Function prototypes */
void yyerror(const char *);

/* local variable declarations */
int result;

int main(int argc, char** argv)
{

    if( argc != 2 ){
        printf("Invalid number of arguments; try \"cmm /path/file\" \n");
        exit(1);
    }

    if( (yyin = fopen(argv[1], "r")) == NULL ){
        printf("Unable to open file specified\n");
        exit(1);
    }

//    cas_prol();

    //Initialize symbol table
//    st_init();

    if( (result = yyparse()) != 0 ){
        printf("Syntax error found:\n");
        exit(1);
    }

    //Output the assembly file
    cas_writer(argv[1]);
    //Destroy the symbol table
    st_destroy();

    fclose(yyin);

    return 0;
}
