%{
/*Initial C section*/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "cmm.h"
#include "stable.h"
#include "cas.h"
#include "lval.h"
#include "reg.h"
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
			 if(strcmp($1.name, "main") == 0) cas_proc_body($1.name, "\tleave\n");
			 cas_proc_body($1.name, "\tret\n");
			 //Write function footer
			 cas_proc_foot($1.name, "\t.size\t");
			 cas_proc_foot($1.name, $1.name);
			 cas_proc_foot($1.name, ", .-");
			 cas_proc_foot($1.name, $1.name);
			 cas_proc_foot($1.name, "\n");}
		;

proc_head	: func_decl decl_list
			{/* Write out function header and create new stack frame
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
			  cas_proc_head($1.name, ":\tnop\n");
			  cas_proc_head($1.name, "\tpushq\t\%rbp\n");
			  cas_proc_head($1.name, "\tmovq\t\%rsp, \%rbp\n");
			  /* Allocate space for
			   * the variable declarations in function
			   */
			  char *output = malloc(64*sizeof(char));
			  snprintf(output, 64, "\tsubq\t$%d, %%rsp\n", $2.val.ival);
			  cas_proc_head($1.name, output);
			  free(output);}
		| func_decl
			{ /*Write out function header, new stack frame*/
                          $$ = $1;
			  cas_global("\t.globl ");
			  cas_global($1.name);
                          cas_global("\n");
			  cas_global("\t.type ");
			  cas_global($1.name);
			  cas_global(" @function\n");
                          //Write beginning of function section
			  cas_proc_head($1.name, $1.name);
			  cas_proc_head($1.name, ":\tnop\n");
			  cas_proc_head($1.name, "\tpushq\t\%rbp\n");
			  cas_proc_head($1.name, "\tmovq\t\%rsp, \%rbp\n");}
			
		;

func_decl	: type IDENTIFIER LP RP LBR
			{/*Create new function sym in s.table.
			  * type(PROC), addr(LABEL), size (of retval)*/
			 symb *s;
			 char *addr = strdup($2.name);
			 s = st_add_symbol($2.name, addr, 0, $1.d_type, PROC,
					   $1.size, 0);
			 if(DEBUG) printf("Added process %s to stable\n"
			                  , s->name);
			 $$.name = $2.name;
			 g_label = "rbp";}
			 
		;

proc_body	: statement_list RBR
			{;}
		;

decl_list	: type ident_list SC
			{/*Here we have the type and the symbols in the table*
			  * The symbols are listed in $2.names and there are
			  * $2.count of them in the list */
			 int i, offset = 0;
			 symb *s;
			 for(i = 0; i < $2.count; i++){
			     if(DEBUG) printf("updating symbol %s\n", $2.names[i]);
			     s = st_get_symbol($2.names[i]);
			     s->size = $1.size;
			     s->d_type = $1.d_type;
			     if(s->type == VAR){
				 s->offset = offset;
			         offset += $1.size; 
			     }else if(s->type == ARR){
			         s->offset = offset;
				 offset += $1.size*s->arrsize;
			     }else{
				 yyerror("Not expecting type in decl_list\n");
				 YYERROR;
			     }
			     if(DEBUG) printf("Symbol %s updated with type %d, offset %d\n"
						, s->name,s->d_type, s->offset);
			 }
			 //Free the list of pointers (not the strings themselves)
			 free($2.names);
			 //Pass up size and count
			 $$.size = $1.size; 
			 $$.val.ival = $1.size*$2.count;
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
			 //The offset of these will be after previous declarations
			 int i, offset = $1.count;
			 symb *s;
			 for(i = 0; i < $3.count; i++){
			     if(DEBUG) printf("updating symbol %s\n", $3.names[i]);
			     s = st_get_symbol($3.names[i]);
			     s->size = $2.size;
			     s->d_type = $2.d_type;
			     if(s->type == VAR){
				 s->offset = offset;
			         offset += $2.size; 
			     }else if(s->type == ARR){
			         s->offset = offset;
				 offset += $2.size*s->arrsize;
			     }else{
				 yyerror("Not expecting type in decl_list\n");
				 YYERROR;
			     }
			     if(DEBUG) printf("Symbol %s updated with type %d,offset %d\n"
					,s->name, s->d_type, s->offset);
			 }
			 //Free the list of pointers (not the strings themselves)
			 free($3.names);
			 //Pass up size and count
			 $$.size = ($2.size >= $1.size ? $2.size : $1.size); 
			 $$.val.ival = $2.size*$3.count + $1.val.ival;
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
			 st_add_symbol($$.names[0], strdup(g_label), 0, 0, $1.type,
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
                                       , $1.count, 0, $3.type, 0, arrsize);
			 //Free old list
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
			{$$.size = 4;
			 $$.d_type = INT_T;}
		| FLOAT 
			{$$.size = 4;
			 $$.d_type = FLOAT_T;}
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
            {//Var reg $1.val.ival, value reg $3.val.ival
             //Check that variable and expr are same type...
             if( $1.d_type != $3.d_type ){
                if(DEBUG) printf("Tried to assign missmatching type to variable!\n");
                YYERROR;
             }
             char *buf = calloc(64, sizeof(char));
             char *r1Name, *r2Name;
             r1Name = reg_getName64($1.val.ival);
             r2Name = reg_getName32($3.val.ival);
             //movl %r1-32, (%r2-64) ; move value into the location dereferenced by r2
             snprintf(buf, 64, "\tmovl\t%%%s, (%%%s)\n", r2Name, r1Name);
             cas_proc_body(NULL, buf);
             free(buf);
             //Release both registers
             reg_release($1.val.ival);
             reg_release($3.val.ival);
             if(DEBUG) printf("Assigned value from reg %s into %s\n", r2Name, r1Name);
            }
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
            {//Value stored in $3.ival register, print by type
			 char *buf = calloc(64, sizeof(char));
             char *rName = reg_getName32($3.val.ival); 
			 //Print the constant that was evaluated
			 if($3.d_type == INT_T){
			     //Create string to move value into source register
			     snprintf(buf,64,"\tmovl\t%%%s, %%esi\n",rName);
			     cas_proc_body(NULL,buf);
			     cas_proc_body(NULL,"\tmovl\t$0, \%eax\n");
			     cas_proc_body(NULL,"\tmovl\t$.int_wformat, \%edi\n");
			     cas_proc_body(NULL,"\tcall\tprintf\n"); 
                 
			 }else{
				 //Put the # of fp args passed to printf in %eax
				 //movss (32bit FP) their vals into xmm0, xmm1, etc
			     snprintf(buf,64,"\tmovss\t%%%s, %%xmm0\n",rName);
			     cas_proc_body(NULL,buf);
			     cas_proc_body(NULL,"\tmovl\t$1, \%eax\n");
			     cas_proc_body(NULL,"\tmovl\t$.flt_wformat, \%edi\n");
			     cas_proc_body(NULL,"\tcall\tprintf\n");
			 }
            free(buf);
            reg_release($3.val.ival);
			 
			}
		| WRITE LP string_constant RP SC
            {/* Write the print assembly to the process body
			  *
			  */
			 cas_proc_body(NULL,"\tmovl\t$");
			 cas_proc_body(NULL,$3.name);
			 cas_proc_body(NULL,", \%ebx\n");
			 cas_proc_body(NULL,"\tmovl\t\%ebx, \%esi\n");
			 cas_proc_body(NULL,"\tmovl\t$0, \%eax\n");
			 cas_proc_body(NULL,"\tmovl\t$.str_wformat, \%edi\n");
			 cas_proc_body(NULL,"\tcall\tprintf\n");}
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

expr	: expr AND simple_expr
                        {$$ = $1;}
		| expr OR simple_expr
                        {$$ = $1;}
		| simple_expr
                        {$$ = $1;}
		| NOT simple_expr
                        {$$ = $1;}
		;

simple_expr	: simple_expr EQ add_expr
                        {$$ = $1;}
		| simple_expr NE add_expr
                        {$$ = $1;}
		| simple_expr LE add_expr
                        {$$ = $1;}
		| simple_expr LT add_expr
                        {$$ = $1;}

		| simple_expr GE add_expr
                        {$$ = $1;}

		| simple_expr GT add_expr
                        {$$ = $1;}

		| add_expr
                        {$$ = $1;}

		;

add_expr	: add_expr PLUS mul_expr
            {/*Register in lval.val.ival, data type in attr.d_type */
			 char *buf = calloc(64, sizeof(char));
             char *r1Name, *r2Name;
             int d_type;
             /*Check for float vs int here */
			 if($1.d_type == INT_T && $3.d_type == INT_T){
                //Integer addition, attr.reg * attr2.reg, pass up right
                d_type = INT_T;
                r1Name = reg_getName32($1.val.ival);
                r2Name = reg_getName32($3.val.ival);
                snprintf(buf, 64, "\taddl\t%%%s, %%%s\n", r1Name, r2Name);
                cas_proc_body(NULL, buf);
                
			 }else if($1.d_type == FLOAT_T && $3.d_type == INT_T){

			 }else if($1.d_type == INT_T && $3.d_type == FLOAT_T){

			 }else{

			     if(DEBUG) printf("FLOAT - FLOAT = %f\n", $$.val.fval);
			 } //Pass up type and result
             free(buf);
             reg_release($1.val.ival);                
             $$.val.ival = $3.val.ival; 
             $$.d_type = d_type;
			 }
            
            

		| add_expr MINUS mul_expr
            {/*Register in lval.val.ival, data type in attr.d_type */
			 
			 char *buf = calloc(64, sizeof(char));
             char *r1Name, *r2Name;
             int d_type;
             /*Check for float vs int here */
			 if($1.d_type == INT_T && $3.d_type == INT_T){
                //Integer subtraction, attr.reg * attr2.reg, pass up right
                d_type = INT_T;
                r1Name = reg_getName32($1.val.ival);
                r2Name = reg_getName32($3.val.ival);
                snprintf(buf, 64, "\tsubl\t%%%s, %%%s\n", r1Name, r2Name);
                cas_proc_body(NULL, buf);
                
			 }else if($1.d_type == FLOAT_T && $3.d_type == INT_T){

			 }else if($1.d_type == INT_T && $3.d_type == FLOAT_T){

			 }else{

			     if(DEBUG) printf("FLOAT - FLOAT = %f\n", $$.val.fval);
			 } //Pass up type and result
             free(buf);
             reg_release($1.val.ival);                
             $$.val.ival = $3.val.ival; 
             $$.d_type = d_type;
            }
			     

		| mul_expr
            {$$ = $1;}

		;

mul_expr    : mul_expr TIMES factor
            {/*Register in lval.val.ival, data type in attr.d_type */
			 char *buf = calloc(64, sizeof(char));
             char *r1Name, *r2Name;
             int d_type;
             /*Check for float vs int here */
			 if($1.d_type == INT_T && $3.d_type == INT_T){
                //Integer multiplication, attr.reg * attr2.reg, pass up right
                d_type = INT_T;
                r1Name = reg_getName32($1.val.ival);
                r2Name = reg_getName32($3.val.ival);
                snprintf(buf, 64, "\timull\t%%%s, %%%s\n", r1Name, r2Name);
                cas_proc_body(NULL, buf);
                
			 }else if($1.d_type == FLOAT_T && $3.d_type == INT_T){

			 }else if($1.d_type == INT_T && $3.d_type == FLOAT_T){

			 }else{

			     if(DEBUG) printf("FLOAT * FLOAT = %f\n", $$.val.fval);
			 } //Pass up type and result
             free(buf);
             reg_release($1.val.ival);                
             $$.val.ival = $3.val.ival; 
             $$.d_type = d_type;
			 }
            

		| mul_expr DIVIDE factor
            {/*Register in lval.val.ival, data type in attr.d_type */
			 char *buf = calloc(64, sizeof(char));
             char *r1Name, *r2Name;
             int d_type;
             /*Check for float vs int here */
			 if($1.d_type == INT_T && $3.d_type == INT_T){
                //Integer division, attr.reg * attr2.reg, pass up right
                d_type = INT_T;
                r1Name = reg_getName32($1.val.ival);
                r2Name = reg_getName32($3.val.ival);
                snprintf(buf, 64, "\timull\t%%%s, %%%s\n", r1Name, r2Name);
                cas_proc_body(NULL, buf);
                
			 }else if($1.d_type == FLOAT_T && $3.d_type == INT_T){

			 }else if($1.d_type == INT_T && $3.d_type == FLOAT_T){

			 }else{

			     if(DEBUG) printf("FLOAT * FLOAT = %f\n", $$.val.fval);
			 } //Pass up type and result
             free(buf);
             $$.val.ival = $3.val.ival; 
             reg_release($1.val.ival);                
             $$.d_type = d_type;
			 }
            
                        

		| factor
                        {$$ = $1;}
		;

factor	: variable
                        {//Send up variable values to expressions
                         int reg = reg_get();
                         char *rName = reg_getName32(reg);
                         char *rAddrName = reg_getName64($1.val.ival);
                         char *buf = calloc(64, sizeof(char));
                         //Output assembly to dereference
                         snprintf(buf, 64, "\tmovl\t(%%%s), %%%s\n",rAddrName, rName);
                         cas_proc_body(NULL, buf);
                         free(buf);
                         //Release prev address register
                         reg_release($1.val.ival);
                         $$.val.ival = reg;
                         $$.d_type = $1.d_type;
                        }

		| constant
                        {$$ = $1;}

		| IDENTIFIER LP RP
                        {/*Function call*/
            			 $$ = $1;}

		| LP expr RP
                        {/*Pass up result of expr*/;}

		;

variable	: IDENTIFIER  
			{//Get var from symbol table, load its address
			 //Into a register, pass up
			 symb *var = st_get_symbol($1.name);
			 if(var == NULL) YYERROR;
			 //Get register to store variable
			 int reg = reg_get();
			 char *rName = reg_getName64(reg);
			 char *buf = calloc(64, sizeof(char));
			 if( strcmp(var->addr, "_gp") == 0 ){
			     snprintf(buf, 64, "\tmovq\t$_gp, %%%s\n",rName);
			     //Move addr of global into register
			     cas_proc_body(NULL, buf);
			     //Incr by offset
			     snprintf(buf, 64, "\taddq\t$%d, %%%s\n",var->offset,rName);
			     cas_proc_body(NULL, buf);

			 }else if( strcmp(var->addr, "rbp") == 0 ){
			     snprintf(buf, 64, "\tmovq\t%%rbp, %%%s\n",rName);
			     //Move addr of local var into register
			     cas_proc_body(NULL, buf);
			     //Incr by offset (negative)
			     snprintf(buf, 64, "\tsubq\t$%d, %%%s\n",var->offset,rName);
			     cas_proc_body(NULL, buf);

			 }else{
			     if(DEBUG) printf("Variable's address invalid: %s\n", var->addr);
			     YYERROR;
			 }
			 free(buf);
			 //Pass up register location and type
			 $$.val.ival = reg;
			 $$.d_type = var->d_type;
             $$.type = VAR;
			}

		| IDENTIFIER LBK expr RBK
                        {/*Pass up name of array and result of expr*/}

		;

string_constant	: STRING
            {char *name = $1.name;
			 char *addr = strdup(name);
			 //Add string constant to symbol table
			 st_add_symbol(name, addr, 0, 0, VAR, $1.size, 0);
			 //Write string constant to proper assembly section
			 cas_str_const(0, name);
			 cas_str_const(0, ": .string \"");
			 cas_str_const(0, $1.val.sval);
			 cas_str_const(0, "\"\n");
			 //Pass up reference 
			 $$.name = name;
             $$.type = -1;
			}

		;

constant    : INTCON
            {//Put constant into register, pass reg val up
			 int reg = reg_get();
			 char *rName = reg_getName32(reg);
			 char *buf = calloc(64, sizeof(char));
			 //Build assembly string
			 snprintf(buf, 64, "\tmovl\t$%d, %%%s\n", $1.val.ival, rName);
			 //Write to output
			 cas_proc_body(NULL, buf);
			 //Pass up register reference and data type
			 $$.val.ival = reg;
			 $$.d_type = INT_T;
             //Type is a constant
             $$.type = -1;
			 free(buf);
             if(DEBUG) printf("Putting int %d into reg %s\n", $1.val.ival, rName);
			}

        | FLOATCON
			{//Put float constant into register
			 int reg = reg_get();
			 char *rName = reg_getName64(reg);
			 char *buf = calloc(64, sizeof(char));
			 //Build assembly string
			 snprintf(buf, 64, "\tmovl\t$%f, %%%s\n", $1.val.fval, rName);
			 //Write to output
			 cas_proc_body(NULL, buf);
			 //Pass up register reference and data type
			 $$.val.ival = reg;
			 $$.d_type = FLOAT_T;
             //Type is a constant
             $$.type = -1;
			 free(buf);
             if(DEBUG) printf("Putting float %f into reg %s\n", $1.val.fval, rName);
			}

		; 

%%

void yyerror(const char *s) {fprintf(stderr, "%s\n",s);}
