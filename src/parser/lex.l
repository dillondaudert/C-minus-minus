D	[0-9]
NZ	[1-9]
L	[a-zA-Z_]
A	[a-zA-Z_0-9]
E	([Ee][+-]?{D}+)

%{
#include "grammar.tab.h"
#include <string.h>
#include "lval.h"
extern void yyerror(const char *);
%}

/* Options to suppress unused functions */

%x COMMENT
%x STRSTATE
%%

	/* keywords */

(?:else)		{return ELSE;}
(?:exit)		{return EXIT;}
(?:float)		{return FLOAT;}
(?:if)			{return IF;}
(?:int)			{yylval.size = 4; return INT;}
(?:read)		{yylval.size = 8; return READ;}
(?:return)		{return RETURN;}
(?:while)		{return WHILE;}
(?:write)		{return WRITE;}

	/* special characters */

"&&"			{return AND;}
"="			{return ASSIGN;}
","			{return CM;}
"/"			{return DIVIDE;}
"=="			{return EQ;}
">="			{return GE;}
">"			{return GT;}
"{"			{return LBR;}
"["			{return LBK;}
"<="			{return LE;}
"("			{return LP;}
"<"			{return LT;}
"-"			{return MINUS;}
"!="			{return NE;}
"!"			{return NOT;}
"||"			{return OR;}
"+"			{return PLUS;}
"}"			{return RBR;}
"]"			{return RBK;}
")"			{return RP;}
";"			{return SC;}
"*"			{return TIMES;}

	/* comments */

"/*"			{BEGIN(COMMENT);}
<COMMENT>.		;
<COMMENT>"*/"		{BEGIN 0;}

	/* identifiers and strings */


{L}{A}*			{yylval.name = strdup(yytext); return IDENTIFIER;}
"0"|{NZ}{D}*		{yylval.val.ival = atoi(yytext); return INTCON;}
{D}*"."{D}+{E}?		{yylval.val.dval = atof(yytext); return FLOATCON;}

\'			{BEGIN(STRSTATE);}
\"			{BEGIN(STRSTATE);}
<STRSTATE>\"		{BEGIN 0; return STRING;}
<STRSTATE>\'		{BEGIN 0; return STRING;}
<STRSTATE>.		{ECHO;}

[ \t]			;
.			{ECHO; yyerror("Unexpected character");}


%%
int yywrap(void)	{return 1;}
