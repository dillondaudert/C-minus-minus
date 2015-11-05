#
# This contains the struct definition for the yylval structure
# as well as any helper methods that relate to it
#

typedef enum {INT_T, FLOAT_T, STR_T} SymbType; 

struct symb{
    char *name;
    SymbType type;
    char *adr;
    
}
