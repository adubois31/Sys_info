%{
#include <stdlib.h>
#include <stdio.h>
void yyerror(char *s);
%}
%union { int nb; char var[16]; }
%token tMAIN tPO tPF tAO tAF tCONST tINT tEGAL tSOU tADD tMUL tDIV tCOMA tEL tSC tPRINT tBLANK tERROR
%token <var> tVARNAME 
%token <nb> tNB
%type  Body VarInt Var Const Declaration Terme Operation NewLine
%start Programme
%%
Programme :	  tMAIN  tPO  tPF  tAO NewLine Body tAF NewLine
      |tMAIN  tPO  tPF  tAO Body  tAF NewLine 
      |tMAIN  tPO  VarInt  tPF  tAO NewLine Body tAF NewLine
      |tMAIN  tPO  VarInt  tPF  tAO Body tAF NewLine;

Var :     tVARNAME | tVARNAME tCOMA  Var; 
VarInt :    tINT tVARNAME| tINT tVARNAME tCOMA  Var;
Const :   tCONST  VarInt;
Body :  Declaration Body
      | Operation Body
      | Print Body;
      |;
Declaration :  Const  tSC NewLine
      |VarInt  tSC NewLine
      |Const tEGAL tNB tSC NewLine
      |VarInt tEGAL tNB tSC NewLine;

Terme :   tNB 
      | tVARNAME ;
Operation :  tVARNAME  tEGAL  Terme   tADD  Terme  tSC  NewLine
      | tVARNAME  tEGAL  Terme   tSOU  Terme  tSC  NewLine
      |tVARNAME  tEGAL  Terme   tMUL  Terme  tSC  NewLine
      |tVARNAME  tEGAL  Terme   tDIV  Terme  tSC  NewLine;
Print : tPRINT  tPO  tVARNAME  tPF  tSC  NewLine      
NewLine : tEL NewLine
      |tEL
      |;



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
