%{
#include <stdlib.h>
#include <stdio.h>
#include "ts.h"
void yyerror(char *s);

int is_const = 0;

%}
%union { int nb; char var[16]; }
%token tMAIN tPO tPF tAO tAF tCONST tINT tEGAL tSOU tADD tMUL tDIV tNOT tSUP tINF tEQUAL tDIFF tSUPEQ tINFEQ tOR tAND tCOMA tSC tPRINT tBLANK tERROR tIF tELSE
%token <var> tVARNAME 
%token <nb> tNB
%type  Body VarInt Var Const Declaration  Expr  If Condition
%type <nb> Terme Operation Expr
%start Programme
%%
Programme :	  tMAIN  tPO  tPF   Body
      |tMAIN  tPO  VarInt  tPF  Body ;

Body : tAO { ts_inc_depth(); } Lines  tAF { printTS();ts_dec_depth(); } ;
Lines :  Declaration Lines
      | Operation Lines
      | Print Lines;
      |If Lines;
      //|While Lines;
      |;
Declaration :  Const  tSC 
      |VarInt  tSC 
      |Const tEGAL Expr tSC 
      |VarInt tEGAL Expr tSC ;
Const :   tCONST { is_const = 1; }  VarInt { is_const = 0; } ;

VarInt :    tINT tVARNAME { pushTS($2,is_const); }
            |tINT tVARNAME tCOMA  Var { pushTS($2,is_const); };


Var :     tVARNAME { pushTS($1,is_const); }
            | tVARNAME tCOMA  Var { pushTS($1,is_const); }; 
Operation :  tVARNAME  tEGAL Expr tSC;

Expr :  Expr  tADD  Expr
      |Expr  tSOU  Expr    
      |Expr  tMUL  Expr    
      |Expr  tDIV  Expr   
      |Terme;

Terme : tNB {$$=$1;}
      |tVARNAME ;

Print : tPRINT  tPO  tVARNAME  tPF  tSC
// while à faire   
If :        tIF tPO Condition tPF   Body
            |tIF tPO Condition tPF   Body  tELSE   Body;
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
      init();
      yyparse();
      return 0;
}
