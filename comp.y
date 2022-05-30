%{
#include <stdlib.h>
#include <stdio.h>
#include "ts.h"
#include "assembleur.h"
void yyerror(char *s);

int is_const = 0;

%}
%union { int nb; char var[16]; }
%token tMAIN tPO tPF tAO tAF tCONST tINT tEGAL tSOU tADD tMUL tDIV tNOT tSUP tINF tEQUAL tDIFF tSUPEQ tINFEQ tOR tAND tCOMA tSC tPRINT tBLANK tERROR tIF tWHILE tELSE
%token <var> tVARNAME 
%token <nb> tNB
%left tADD tSOU
%left tMUL tDIV
%type  Body VarInt Var Const Declaration  Expr  If  While
%type <nb> Terme Operation Expr Condition
%start Programme
%%
Programme :	  tMAIN  tPO  tPF   Body
      |tMAIN  tPO  VarInt  tPF  Body ;

Body : tAO { ts_inc_depth(); } Lines  tAF { printTS();ts_dec_depth(); printTS(); } ;
Lines :  Declaration Lines
      | Operation Lines
      | Print Lines;
      |If Lines;
      |While Lines;
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
Operation :  tVARNAME  tEGAL Expr tSC {addInst2(COP,$3,findAddr($1));};

Expr :  Expr  tADD  Expr {addInst3(ADD,$1,$1,$3);$$=$1;}
      |Expr  tSOU  Expr {addInst3(SOU,$1,$1,$3);$$=$1;}
      |Expr  tMUL  Expr {addInst3(MUL,$1,$1,$3);$$=$1;}  
      |Expr  tDIV  Expr {addInst3(DIV,$1,$1,$3);$$=$1;}
      |Terme {$$=$1;};

Terme : tNB {pushTS("_", is_const);addInst2(AFC,getSommet(),$1);$$=getSommet();}
      |tVARNAME {pushTS("_", is_const);addInst2(COP,getSommet(),findAddr($1));$$=getSommet();} ;

Print : tPRINT  tPO  tVARNAME  tPF  tSC {addInst1(PRI,findAddr($3));}
While : tWHILE tPO Condition tPF Body   
If :        tIF tPO Condition tPF   Body
            |tIF tPO Condition tPF   Body  tELSE   Body;

Condition :  Condition tSUPEQ Condition
            |Condition tSUP Condition {addInst3(SUP,$1,$1,$3);$$=$1;}
            |Condition tINFEQ Condition
            |Condition tINF Condition {addInst3(INF,$1,$1,$3);$$=$1;}
            |Condition tEQUAL Condition {addInst3(EQU,$1,$1,$3);$$=$1;}
            |Condition tDIFF Condition
            |Condition tOR Condition
            |Condition tAND Condition
            |tNOT tPO Condition tPF 
            |Terme;
            



%%

void yyerror(char *s) {
      fprintf(stderr, "%s\n", s);
      exit(1);
 }


int main(void) {

      yydebug = 1;
      initTabIns();
      printf("Lancement parsing\n"); // yydebug=1;
      TSinit();
      yyparse();
      printTabIns();
      return 0;
}
