%{
/*Initial C section*/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "cmm.h"
#include "stable.h"
#include "cas.h"
#include "lval.h"
void yyerror(const char *);
int yylex(void);

/*Global variables*/
//g_label is the current label scope. It is a name prefixed with '_'
char *g_label;
%}

/*enable improved syntax error checking*/
%define parse.lac full
%define parse.error verbose
/*define yylval type in lval.h*/
%define api.value.type {struct lval}

%start start

/*token declarations*/
%token ELSE EXIT FLOAT IF INT
%token READ RETURN WHILE WRITE
%token AND ASSIGN CM DIVIDE
%token EQ GE GT LBR LBK LE LP
%token LT MINUS NE NOT OR PLUS
%token RBR RBK RP SC SQ TIMES
%token INTCON FLOATCON STRING
%token IDENTIFIER

/*operator precedence*/
%left "&&" "||"
%right '!'
%left '>' '<' "<=" ">=" "!=" "=="
%left '+' '-'
%left '*' '/'

%%


/*grammar rules**********/

start		: /* empty */
			{st_init();
			 g_label = "_gp";
			 }
		  program 
			{;}
		;

program		: decl_list procs
			{
			 //Write out global variables
			 char *statics = malloc(32 * sizeof(char));
			 snprintf(statics, 32,"\t.comm %s, %d, %d\n", $1.name, $1.val.ival, $1.size);
			 if(DEBUG) printf("Static: %s\n", statics);
			 cas_static(statics);
			 free(statics);
			 }
		| procs
			{;}
		;

procs		: proc_decl procs
			{;}
		| proc_decl
			{;}
		;

proc_decl	: proc_head proc_body
			{/* Write the function ending
			  */
			 cas_proc_body($1.name, "\t.size\t");
			 cas_proc_body($1.name, $1.name);
			 cas_proc_body($1.name, ", .-");
			 cas_proc_body($1.name, $1.name);
			 cas_proc_body($1.name, "\n");}
		;

proc_head	: func_decl 
			{/* Send this function information to the appropriate
			  * cas_ output files to be written later
			  */
                          $$ = $1;
			  cas_global("\t.globl ");
			  cas_global($1.name);
                          cas_global("\n");
			  cas_global("\t.type ");
			  cas_global($1.name);
			  cas_global(" @function\n");
                          //Write beginning of function section
			  cas_proc_head($1.name, $1.name);
			  cas_proc_head($1.name, ":\tnop\n");}
			decl_list
			{;}
		| func_decl
			{
                          $$ = $1;
			  cas_global("\t.globl ");
			  cas_global($1.name);
                          cas_global("\n");
			  cas_global("\t.type ");
			  cas_global($1.name);
			  cas_global(" @function\n");
                          //Write beginning of function section
			  cas_proc_head($1.name, $1.name);
			  cas_proc_head($1.name, ":\tnop\n");}
			
		;

func_decl	: type IDENTIFIER LP RP LBR
			{/*Create new function sym in s.table.
			  * type(PROC), addr(LABEL), size (of retval)*/
			 symb *s;
			 char *addr = strdup($2.name);
			 s = st_add_symbol($2.name, addr, 0, PROC,
					   $1.size, 0);
			 if(DEBUG) printf("Added process %s to stable\n"
			                  , s->name);
			 $$.name = $2.name;}
			 
		;

proc_body	: statement_list RBR
			{;}
		;

decl_list	: type ident_list SC
			{/*Here we have the size and the symbols in the table*
			  * The symbols are listed in $2.hashes and there are
			  * $2.count of them in the list */
			 int size = $1.size;
			 int i, offset = 0;
			 symb *s;
			 for(i = 0; i < $2.count; i++){
			     if(DEBUG) printf("updating symbol %s\n", $2.names[i]);
			     s = st_get_symbol($2.names[i]);
			     s->size = size;
			     if(s->type == VAR){
				 s->offset = offset;
			         offset += size; 
			     }else if(s->type == ARR){
			         s->offset = offset;
				 offset += size*s->arrsize;
			     }else{
				 yyerror("Not expecting type in decl_list\n");
				 YYERROR;
			     }
			     if(DEBUG) printf("Symbol %s updated with size %d, offset %d\n"
						, s->name,s->size, s->offset);
			 }
			 //Free the list of pointers (not the strings themselves)
			 free($2.names);
			 //Pass up size and count
			 $$.size = size; $$.val.ival = size*$2.count;
			 $$.name = g_label;
			 //Pass up offset
			 $$.count = offset;
			 //Now all symbols are updated with size and offset
			 ;}
		| decl_list type ident_list SC
			{/*Here we have the size and the symbols in the table*
			  * The symbols are listed in $3.names and there are
			  * $3.count of them in the list.
			  * There are also declarations that come before these.
			  *  */
			 int size = $2.size;
			 //The offset of these will be after previous declarations
			 int i, offset = $1.count;
			 symb *s;
			 for(i = 0; i < $3.count; i++){
			     if(DEBUG) printf("updating symbol %s\n", $3.names[i]);
			     s = st_get_symbol($3.names[i]);
			     s->size = size;
			     if(s->type == VAR){
				 s->offset = offset;
			         offset += size; 
			     }else if(s->type == ARR){
			         s->offset = offset;
				 offset += size*s->arrsize;
			     }else{
				 yyerror("Not expecting type in decl_list\n");
				 YYERROR;
			     }
			     if(DEBUG) printf("Symbol %s updated with size %d,offset %d\n"
					,s->name, s->size, s->offset);
			 }
			 //Free the list of pointers (not the strings themselves)
			 free($3.names);
			 //Pass up size and count
			 $$.size = (size >= $1.size ? size : $1.size); 
			 $$.val.ival = size*$3.count + $1.val.ival;
			 $$.name = $1.name;
			;}
			
		;

ident_list	: var_decl
			{/*add first variable to symbol table*/
			 int arrsize = 0;
			 //get size of array 
			 if($1.type == ARR) arrsize = $1.arrsize;
			 $$.count = 1;
			 //Save name in list
			 $$.names = calloc(1, sizeof(char *));
			 $$.names[0] = $1.name;
			 if(DEBUG) printf("Added %s to $$names, count=%d\n", 
					  $$.names[0], $$.count);
			 //Add symbol without size into table
			 st_add_symbol($$.names[0], strdup(g_label), 0, $1.type,
				       0, arrsize);
			 }
		| ident_list CM var_decl
			{/*add subsequent symbols to table*/
			 int arrsize = 0;
                         int newcount = $1.count + 1;
                         char **newnames = calloc(newcount, sizeof(char *));
			 //get size of array 
			 if($3.type == ARR) arrsize = $3.arrsize;
			 //Pass up the count of var declarations
			 $$.count = newcount;
			 //Copy old name pointers into new list
			 memcpy(newnames, $1.names, sizeof(char *)*$1.count);
			 //Add new name to end of list
			 newnames[newcount-1] = $3.name;
			 $$.names = newnames;
			 if(DEBUG) printf("Added %s to $$names, count=%d\n", 
					  $$.names[newcount-1], $$.count);
			 //New symbol has size 0, offset will be size*count
			 // * arrsize if it isn't 0.
			 st_add_symbol($$.names[newcount-1], strdup(g_label)
                                       , $1.count, $3.type, 0, arrsize);
			 free($1.names);
			 }
			
		;

var_decl	: IDENTIFIER
			{/*Pass up a new variable symbol*/
			 $$.name = $1.name;
			 $$.type = VAR;}
		| IDENTIFIER LBK INTCON RBK
			{/*Pass up a new array symbol*/
			 $$.name = $1.name;
			 $$.type = ARR;
			 $$.arrsize = $3.arrsize;}
		;

type		: INT
			{$$.size = 4;}
		| FLOAT 
			{$$.size = 8;}
		;

statement_list	: statement
			{;}
		| statement_list statement
			{;}
		;

statement	: assignment
                        {;}
		| if_statement                        
			{;}
		| while_statement
                        {;}
		| io_statement
                        {;}
		| return_statement
                        {;}
		| exit_statement
                        {;}
		| compound_statement
                        {;}
		;

assignment	: variable ASSIGN expr SC
                        {;}
		;

if_statement	: IF test_then ELSE compound_statement
                        {;}
		| IF test_then
                        {;}
		;

test_then	: test compound_statement
                        {;}
		;

test		: LP expr RP
                        {;}
		;

while_statement	: while_token while_expr statement
                        {;}
		;

while_token	: WHILE
                        {;}
		;

while_expr	: LP expr RP
                        {;}
		;

io_statement	: READ LP variable RP SC
                        {;}
		| WRITE LP expr RP SC
                        {;}
		| WRITE LP string_constant RP SC
                        {;}
		;

return_statement: RETURN expr SC
                        {;}
		;

exit_statement	: EXIT SC
                        {;}
		;

compound_statement: LBR statement_list RBR
                        {;}
		;

expr		: expr AND simple_expr
                        {;}
		| expr OR simple_expr
                        {;}
		| simple_expr
                        {;}
		| NOT simple_expr
                        {;}
		;

simple_expr	: simple_expr EQ add_expr
                        {;}
		| simple_expr NE add_expr
                        {;}
		| simple_expr LE add_expr
                        {;}
		| simple_expr LT add_expr
                        {;}

		| simple_expr GE add_expr
                        {;}

		| simple_expr GT add_expr
                        {;}

		| add_expr
                        {;}

		;

add_expr	: add_expr PLUS mul_expr
                        {;}

		| add_expr MINUS mul_expr
                        {;}

		| mul_expr
                        {;}

		;

mul_expr	: mul_expr TIMES factor
                        {;}

		| mul_expr DIVIDE factor
                        {;}

		| factor
                        {;}
		;

factor		: variable
                        {;}

		| constant
                        {;}

		| IDENTIFIER LP RP
                        {;}

		| LP expr RP
                        {;}

		;

variable	: IDENTIFIER
                        {;}

		| IDENTIFIER LBK expr RBK
                        {;}

		;

string_constant	: STRING
                        {char *name = $1.name;
			 char *addr = strdup(name);
			 //Add string constant to symbol table
			 st_add_symbol(name, addr, 0, VAR, $1.size, 0);
			 //Write string constant to proper assembly section
			 cas_str_const(0, name);
			 cas_str_const(0, ": .string \"");
			 cas_str_const(0, $1.val.sval);
			 cas_str_const(0, "\"\n");
			 //Pass up reference 
			 $$.name = name;
			 }

		;

constant	: INTCON
                        {;}

		| FLOATCON
                        {;}

		; 

%%

void yyerror(const char *s) {fprintf(stderr, "%s\n",s);}
