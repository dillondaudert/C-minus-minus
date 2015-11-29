/******************* This header contains the yylval struct *********************
 *                   Dillon Daudert 11/17/2015                                  *
 *******************************************************************************/

struct lval{
    char *name;		//Used to pass up symbol names
    int count;		//Used in lists to count recursion
    int d_type; 	//INT_T or FLOAT_T 
    int type; 		//VAR, ARR or PROC
    int size; 		//data type size in bytes (int:4, float:4)
    int arrsize; 	//size of array, not used if not ARR type
    union {		//union used to pass around CONSTANT values
        int ival;
        float fval;
        char *sval;	//Used for STRINGs and result registers
    } val;
    char **names;	//A list of names for new symbols in table
    
};


