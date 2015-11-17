/******************* This header contains the yylval struct *********************
 *                   Dillon Daudert 11/17/2015                                  *
 *******************************************************************************/

typedef struct {
    char *name;
    int count;
    int type; //VAR, ARR or PROC
    int size; //type size 4/8
    int arrsize; //size of array
    char **names;//A list of names for new symbols in table
    
} lval;


