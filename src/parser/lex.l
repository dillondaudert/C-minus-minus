D	[0-9]
NZ	[1-9]
L	[a-zA-Z_]
A	[a-zA-Z_0-9]
E	([Ee][+-]?{D}+)

%{
#include "grammar.tab.h"
#include <string.h>
%}

/* Options to suppress unused functions */
%option nounput
%option noinput

%x COMMENT
%x STRSTATE
%%

	/* keywords */

(?:else)		{return ELSE;}
(?:exit)		{return EXIT;}
(?:float)		{return FLOAT;}
(?:if)			{return IF;}
(?:int)			{return INT;}
(?:read)		{return READ;}
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


{L}{A}*			{return IDENTIFIER;}
"0"|{NZ}{D}*		{return INTCON;}
{D}*"."{D}+{E}?		{return FLOATCON;}

\'			{BEGIN(STRSTATE);}
\"			{BEGIN(STRSTATE);}
<STRSTATE>\"		{BEGIN 0; return STRING;}
<STRSTATE>\'		{BEGIN 0; return STRING;}
<STRSTATE>.		{ECHO;}

[ \t]			;
.			{ECHO; yyerror("Unexpected character");}


%%
int yywrap(void)	{return 1;}
