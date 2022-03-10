%{
#include <stdlib.h>
#include <stdio.h>
#include "ts.h"
void yyerror(char *s);
extern
%}
%union { int nb; char var[16]; }
%token tMAIN tPO tPF tAO tAF tCONST tINT tEGAL tSOU tADD tMUL tDIV tNOT tSUP tINF tEQUAL tDIFF tSUPEQ tINFEQ tOR tAND tCOMA tSC tPRINT tBLANK tERROR tIF tELSE
%token <var> tVARNAME 
%token <nb> tNB
%type  Body VarInt Var Const Declaration Terme Operation  If Condition
%start Programme
%%
Programme :	  tMAIN  tPO  tPF  tAO  Body tAF 
      |tMAIN  tPO  tPF  tAO Body  tAF  
      |tMAIN  tPO  VarInt  tPF  tAO  Body tAF 
      |tMAIN  tPO  VarInt  tPF  tAO Body tAF ;

Var :     tVARNAME | tVARNAME tCOMA  Var; 
VarInt :    tINT tVARNAME
            |tINT tVARNAME tCOMA  Var;
Const :   tCONST  VarInt;
Body :  Declaration Body
      | Operation Body
      | Print Body;
      |If Body;
      |;
Declaration :  Const  tSC 
      |VarInt  tSC 
      |Const tEGAL tNB tSC 
      |VarInt tEGAL tNB tSC ;

Terme :   tNB {}
      | tVARNAME ;
Operation :  tVARNAME  tEGAL  Terme   tADD  Terme tSC  
      | tVARNAME  tEGAL  Terme   tSOU  Terme  tSC  
      |tVARNAME  tEGAL  Terme   tMUL  Terme  tSC  
      |tVARNAME  tEGAL  Terme   tDIV  Terme  tSC ;
Print : tPRINT  tPO  tVARNAME  tPF  tSC        
If :        tIF tPO Condition tPF  tAO  Body tAF
            |tIF tPO Condition tPF  tAO  Body tAF  tELSE  tAO  Body tAF;
Condition :       Terme;
            |Terme BoolOp Condition
            |tNOT tPO Condition tPF;
BoolOp : tSUP |tINF |tEQUAL |tDIFF |tSUPEQ |tINFEQ |tOR |tAND;



%%

void yyerror(char *s) {
      fprintf(stderr, "%s\n", s);
      exit(1);
 }


int main(void) {
      yydebug = 1;
  printf("Lancement parsing\n"); // yydebug=1;
  yyparse();
  return 0;
}
