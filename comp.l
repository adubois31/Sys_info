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
"printf" { return tPRINT; }
[a-zA-Z][a-zA-Z0-9_]* {
        // TODO: limite 16
        strcpy(yylval.var, yytext);
        return tVARNAME;}
"="	{ return tEGAL; }
"-"	{ return tSOU; }
"+"	{ return tADD; }
"*"	{ return tMUL; }
"/"	{ return tDIV; }
" " {}
"\t" {}
"," { return tCOMA; }
"\n" { return tEL; }
";" { return tSC; }
[0-9]+(e[0-9]*)? { 
        yylval.nb = atoi(yytext);
        return tNB; }
. {return tERROR; }
