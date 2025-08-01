%{
#include<stdio.h>
FILE *fp;
int line=1;
int slno=1;
%}
DIGIT [0-9]
ALPHA [a-zA-Z]
WS [ \t]
%%
{WS}+ {}
"\n" {line++;}
";" {fprintf(fp,"%d\t;\tsemicolon\t%d\n",slno,line); slno++;}
"+"|"-"|"*"|"/" {fprintf(fp,"%d\t%s\t Arithmetic_op\t%d\n",slno,yytext,line); slno++;}
"{"|"["|"(" {fprintf(fp,"%d\t%s\t Opening Bracket\t%d\n",slno,yytext,line); slno++;}
"}"|"]"|")" {fprintf(fp,"%d\t%s\t Closing Bracket\t%d\n",slno,yytext,line); slno++;}
"<"|">"|"<="|">="|"!"|"!="|"==" {fprintf(fp,"%d\t%s\t Relational_op\t%d\n",slno,yytext,line); slno++;}
"=" {fprintf(fp,"%d\t%s\t Assign_op\t%d\n",slno,yytext,line); slno++;}
"#"|"&"|"."|"," {fprintf(fp,"%d\t%s\t Special Char\t%d\n",slno,yytext,line); slno++;}
"void"|"main"|"if"|"else"|"for"|"while"|"do"|"int"|"char"|"float"|"double"|"printf"|"include"|"stdio.h"  {fprintf(fp,"%d\t%s\t Keyword\t%d\n",slno,yytext,line); slno++;}
{ALPHA}+({ALPHA}|{DIGIT})* {fprintf(fp,"%d\t%s\t Identifier\t%d\n",slno,yytext,line); slno++;}
{DIGIT}+"."{DIGIT}+ {fprintf(fp,"%d\t%s\t floatingpoint\t%d\n",slno,yytext,line); slno++;}
. {fprintf(fp,"%d\t%s\t unrecogonised symbol\t%d\n",slno,yytext,line); slno++;}
%%
void main(int argc[], char* argv[])
{
	yyin=fopen(argv[1],"r");
	fp=fopen(argv[2],"w");
	fprintf(fp,"slno\tlexeme\ttoken\tline\n");
	yylex();
}
int yywrap()
{
	return 1;
}
