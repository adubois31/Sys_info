%{
#include <stdlib.h>
#include <stdio.h>
#include "y.tab.h"
%}

%option noyywrap

%%
main {return tMAIN;}
"(" {return tPO;}
")" {return tPF;}
"{" {return tAO;}
"}" {return tAF;}
const {return tCONST;}
int {return tINT;}
"if" {return tIF;}
"else" {return tELSE;}
"printf" { return tPRINT; }
"while" {return tWHILE;}
[a-zA-Z][a-zA-Z0-9_]* {
        // TODO: limite 16
        yylval.var=strdup(yytext);
        return tVARNAME;}
"="	{ return tEGAL; }
"-"	{ return tSOU; }
"+"	{ return tADD; }
"*"	{ return tMUL; }
"/"	{ return tDIV; }
"!"     { return tNOT; }
">"     { return tSUP; }
"<"     { return tINF; }
"=="    { return tEQUAL; }
"/="    { return tDIFF; }
"<="    { return tSUPEQ; }
">="    { return tINFEQ; }
"||"    { return tOR; }
"&&"    { return tAND; }
" " {}
"\t" {}
"," { return tCOMA; }
"\n" {}
";" { return tSC; }
[0-9]+(e[0-9]*)? { 
        yylval.nb = atoi(strdup(yytext));
        return tNB; }
. {return tERROR; }
