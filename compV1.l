%{
#include <stdlib.h>
#include <stdio.h>
#include "comp.tab.h"
%}

%option noyywrap

%%
main {printf(" tMAIN");}
"(" {printf(" tPO");}
")" {printf(" tPF");}
"{" {printf(" tAO");}
"}" {printf(" tAF");}
const {printf(" tCONST");}
int {printf(" tINT");}
printf { printf(" tPRINT"); }
[a-zA-Z][a-zA-Z0-9_]* {printf(" tVARNAME");}
"="	{ printf(" tEGAL"); }
"-"	{ printf(" tSOU"); }
"+"	{ printf(" tADD"); }
"*"	{ printf(" tMUL"); }
"/"	{ printf(" tDIV"); }
" " { printf(" tSPACE"); }
"\t" { printf(" tTAB"); }
"," { printf(" tCOMA"); }
"\n" { printf(" tEL"); }
";" { printf(" tSC"); }
[0-9]+(e[0-9]*)? { printf(" tNB"); }
. {printf(" tERROR"); }
%%
plouf