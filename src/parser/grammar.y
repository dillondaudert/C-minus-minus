%{
/*Initial C section*/

#include <stdio.h>
#include <string.h>
void yyerror(const char *, int, const char *);
%}

/*enable improved syntax error checking*/
%define parse.lac full
%define parse.error verbose

%start program

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
%left '>' '<' "<=" ">=" "!=" "=="
%left '+' '-'
%left '*' '/'

%%


/*grammar rules**********/

program		: decl_list procs
			{;}
		| procs
			{;}
		;

procs		: proc_decl procs
			{;}
		| proc_decl
			{;}
		;

proc_decl	: proc_head proc_body
			{;}
		;

proc_head	: func_decl decl_list
			{;}
		| func_decl
			{;}
		;

func_decl	: type IDENTIFIER LP RP LBR
			{;}
		;

proc_body	: statement_list RBR
			{;}
		;

decl_list	: type ident_list SC
			{;}
		| decl_list type ident_list SC
			{;}
		;

ident_list	: var_decl
			{;}
		| ident_list CM var_decl
			{;}
		;

var_decl	: IDENTIFIER
			{;}
		| IDENTIFIER LBK INTCON RBK
			{;}
		;

type		: INT
			{;}
		| FLOAT 
			{;}
		;

statement_list	: statement
			{;}
		| statement_list statement
			{;}
		;

statement	: assignment
		| if_statement
		| while_statement
		| io_statement
		| return_statement
		| exit_statement
		| compound_statement
		;

assignment	: variable ASSIGN expr SC
		;

if_statement	: IF test_then ELSE compound_statement
		| IF test_then
		;

test_then	: test compound_statement
		;

test		: '(' expr ')'
		;

while_statement	: while_token while_expr statement
		;

while_token	: WHILE
		;

while_expr	: '(' expr ')'
		;

io_statement	: READ LP variable RP SC
		| WRITE LP expr RP SC
		| WRITE LP string_constant RP SC
		;

return_statement: RETURN expr SC
		;

exit_statement	: EXIT SC
		;

compound_statement: LBR statement_list RBR
		;

expr		: expr AND simple_expr
		| expr OR simple_expr
		| simple_expr
		| NOT simple_expr
		;

simple_expr	: simple_expr EQ add_expr
		| simple_expr NE add_expr
		| simple_expr LE add_expr
		| simple_expr LT add_expr
		| simple_expr GE add_expr
		| simple_expr GT add_expr
		| add_expr
		;

add_expr	: add_expr PLUS mul_expr
		| add_expr MINUS mul_expr
		| mul_expr
		;

mul_expr	: mul_expr TIMES factor
		| mul_expr DIVIDE factor
		| factor
		;

factor		: variable
		| constant
		| IDENTIFIER LP RP
		| LP expr RP
		;

variable	: IDENTIFIER
		| IDENTIFIER LBK expr RBK
		;

string_constant	: STRING
		;

constant	: INTCON
		| FLOATCON
		; 
