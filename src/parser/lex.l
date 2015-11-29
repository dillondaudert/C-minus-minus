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
char *string;
int MAX_STRING = 512;
int str_index;
int strcount = 0;
int fltcount = 0;
%}

%x COMMENT
%x STRSTATE
%x STR2STATE
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


{L}{A}*			{yylval.name = strdup(yytext); return IDENTIFIER;}
"0"|{NZ}{D}*		{yylval.val.ival = atoi(yytext); return INTCON;}
{D}*"."{D}+{E}?		{yylval.val.fval = atof(yytext); 
			 char *name = malloc(32*sizeof(char));
			 snprintf(name, 32, ".LC%d", fltcount++);
			 yylval.name = strdup(name);
			 free(name);
			 return FLOATCON;}

\'			{BEGIN(STR2STATE);
			 MAX_STRING = 512;
			 string = malloc(MAX_STRING*sizeof(char));
			 str_index = 0;}
<STR2STATE>\\t		{
			 if(str_index+1 == MAX_STRING){
			     MAX_STRING <<= 1;
			     char *news = malloc(MAX_STRING*sizeof(char));
			     memcpy(news, string, str_index);
			     free(string);
			     string = news;
			 }
			 string[str_index++]='\t';}

<STR2STATE>\\n		{
			 if(str_index+1 == MAX_STRING){
			     MAX_STRING <<= 1;
			     char *news = malloc(MAX_STRING*sizeof(char));
			     memcpy(news, string, str_index);
			     free(string);
			     string = news;
			 }
			 string[str_index++]='\n';}

<STR2STATE>\\\"		{
			 if(str_index+1 == MAX_STRING){
			     MAX_STRING <<= 1;
			     char *news = malloc(MAX_STRING*sizeof(char));
			     memcpy(news, string, str_index);
			     free(string);
			     string = news;
			 }
			 string[str_index++]='\"';}

<STR2STATE>\n		{ECHO; yyerror("Invalid string\n"); exit(1);}

<STR2STATE>\'		{BEGIN 0; 
			 char *name = malloc(32 * sizeof(char));
			 sprintf(name, ".string_const%d", strcount++);
			 yylval.name = name;
			 yylval.size = strlen(string)+1;
			 yylval.val.sval = strdup(string);
			 free(string);
			 return STRING;}
<STR2STATE>.		{if(str_index+1 == MAX_STRING){
			     MAX_STRING <<= 1;
			     char *news = malloc(MAX_STRING*sizeof(char));
			     memcpy(news, string, str_index);
			     free(string);
			     string = news;
			 }
			 string[str_index++]=*yytext;}

[ \t]			;
.			{ECHO; yyerror("Unexpected character");}


%%
int yywrap(void)	{return 1;}
