/******************* This header contains the yylval struct *********************
 *                   Dillon Daudert 11/17/2015                                  *
 *******************************************************************************/

struct lval{
    char *name;
    int count;
    int d_type;
    int type; //VAR, ARR or PROC
    int size; //type size 4/8
    int arrsize; //size of array
    union {
        int ival;
        double dval;
        char *sval;
    } val;
    char **names;//A list of names for new symbols in table
    
};


