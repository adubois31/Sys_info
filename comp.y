%{
#include <stdlib.h>
#include <stdio.h>
#include "ts.h"
#include "assembleur.h"
#include "interpreteur.h"
void yyerror(char *s);

extern FILE *yyin;


int is_const = 0;

%}
%union { int nb; char * var; }
%token tMAIN tPO tPF tAO tAF tCONST tINT tEGAL tSOU tADD tMUL tDIV tNOT tSUP tINF tEQUAL tDIFF tSUPEQ tINFEQ tOR tAND tCOMA tSC tPRINT tBLANK tERROR tELSE
%token <var> tVARNAME 
%token <nb> tNB tWHILE tIF
%left tADD tSOU
%left tMUL tDIV
%type  Body Var Const Declaration  Lines If While 
%type <nb> Terme Operation Expr Condition 
%type <var> VarInt
%start Programme
%%
Programme :	  tMAIN  tPO  tPF   Body
      |tMAIN  tPO  VarInt  tPF  Body;

Body : tAO { ts_inc_depth(); } Lines  tAF { ts_dec_depth(); } ;

Lines :  Declaration Lines
      | Operation Lines
      | Print Lines
      |If Lines
      |While Lines
      |;
Declaration :  Const  tSC 
      |VarInt  tSC 
      |Const tEGAL Expr tSC 
      |VarInt tEGAL Expr tSC {
                              int temp=popTemp(); 
                              //printf("ADDR DE TEMP ***************************: %d \n",temp );
                              //addInst2(AFC,temp, $3);
                              //printTS();
                              addInst2(COP,findAddr($1),temp);
                              //printTabIns();
                              };
                            
Const :   tCONST { is_const = 1; }  VarInt { is_const = 0; } ;

VarInt :    tINT tVARNAME { pushTS($2,is_const); $$=$2; };
            //|tINT tVARNAME tCOMA  Var { pushTS($2,is_const); $$=$2;};


Var :     tVARNAME { pushTS($1,is_const); }
            | tVARNAME tCOMA  Var { pushTS($1,is_const); }; 
Operation :  tVARNAME  tEGAL Expr tSC {addInst2(COP,findAddr($1),popTemp());};

Expr :  Expr  tADD  Expr {int addrTemp1=popTemp() ;
                        int addrTemp2=popTemp();
                        int addrTempRes = pushTemp();
                        addInst3(ADD,addrTempRes,addrTemp1,addrTemp2);$$=addrTempRes;}
      |Expr  tSOU  Expr {int addrTemp1=popTemp() ;
                        int addrTemp2=popTemp();
                        int addrTempRes = pushTemp();
                        addInst3(SOU,addrTempRes,addrTemp2,addrTemp1);$$=addrTempRes;}
      |Expr  tMUL  Expr {int addrTemp1=popTemp() ;
                        int addrTemp2=popTemp();
                        int addrTempRes = pushTemp();
                        addInst3(MUL,addrTempRes,addrTemp2,addrTemp1);$$=addrTempRes;}  
      |Expr  tDIV  Expr {int addrTemp1=popTemp() ;
                        int addrTemp2=popTemp();
                        int addrTempRes = pushTemp();
                        addInst3(DIV,addrTempRes,addrTemp2,addrTemp1);$$=addrTempRes;}

      |Condition
      |Terme {$$=$1;};

Terme : tNB {int adrTemp=pushTemp();
            addInst2(AFC, adrTemp, $1);$$=adrTemp; }
      |tVARNAME {int adr = findAddr($1);
                  int adrTemp=pushTemp();
                  if (adr!=-1){
                        addInst2(COP,adrTemp, adr);     
                  }
                  $$=$1;
                  } ;

Print : tPRINT  tPO  Terme  tPF  tSC {int temp=popTemp();addInst1(PRI,temp);}
While : tWHILE {$1=getLastInst()+1;} tPO Condition {addInst2(JMF,$4,-1);}  tPF Body {addInst1(JMP,$1) ;modifyJump($1,getLastInst()+1);};  
If :        tIF tPO Condition {addInst2(JMF,$3,-1);$1=getLastInst();} tPF  Body {modifyInstr($1,getLastInst()+1);};
            //|tIF tPO Condition tPF   Body  tELSE   Body;

Condition :  Condition tSUPEQ Condition{int addrTemp1=popTemp() ;
                                    int addrTemp2=popTemp();
                                    int addrTempRes = pushTemp();
                                    addInst3(INF,addrTempRes,addrTemp2,addrTemp1);
                                    addInst2(NOT,addrTempRes,addrTempRes);
                                    $$=addrTempRes;}
            |Condition tSUP Condition {int addrTemp1=popTemp() ;
                                    int addrTemp2=popTemp();
                                    int addrTempRes = pushTemp();
                                    addInst3(SUP,addrTempRes,addrTemp2,addrTemp1);
                                    $$=addrTempRes;}
            |Condition tINFEQ Condition{int addrTemp1=popTemp() ;
                                    int addrTemp2=popTemp();
                                    int addrTempRes = pushTemp();
                                    addInst3(SUP,addrTempRes,addrTemp2,addrTemp1);
                                    addInst2(NOT,addrTempRes,addrTempRes);
                                    $$=addrTempRes;}
            |Condition tINF Condition {int addrTemp1=popTemp() ;
                                    int addrTemp2=popTemp();
                                    int addrTempRes = pushTemp();
                                    addInst3(INF,addrTempRes,addrTemp2,addrTemp1);
                                    $$=addrTempRes;}
            |Condition tEQUAL Condition {int addrTemp1=popTemp() ;
                                    int addrTemp2=popTemp();
                                    int addrTempRes = pushTemp();
                                    addInst3(EQU,addrTempRes,addrTemp2,addrTemp1);
                                    $$=addrTempRes;}
            |Condition tDIFF Condition {int addrTemp1=popTemp() ;
                                    int addrTemp2=popTemp();
                                    int addrTempRes = pushTemp();
                                    addInst3(EQU,addrTempRes,addrTemp2,addrTemp1);
                                    addInst2(NOT,addrTempRes,addrTempRes);
                                    $$=addrTempRes;}
            |Condition tOR Condition {int addrTemp1=popTemp() ;
                                    int addrTemp2=popTemp();
                                    int addrTempRes = pushTemp();
                                    addInst3(OR,addrTempRes,addrTemp2,addrTemp1);
                                    $$=addrTempRes;}
            |Condition tAND Condition {int addrTemp1=popTemp() ;
                                    int addrTemp2=popTemp();
                                    int addrTempRes = pushTemp();
                                    addInst3(AND,addrTempRes,addrTemp2,addrTemp1);
                                    $$=addrTempRes;}
            |tNOT tPO Condition tPF {int addrTemp=popTemp() ;
                                    int addrTempRes = pushTemp();
                                    addInst2(NOT,addrTempRes,addrTemp);
                                    $$=addrTempRes;}
            |Terme;
            



%%

void yyerror(char *s) {
      fprintf(stderr, "%s\n", s);
      exit(1);
 }


int main(int argc, char** argv) {

      yydebug = 1;
      initTabIns();
      
      if(argc != 2) { 
            fprintf(stderr, "Usage: %s <input file>\n", argv[0]); 
            exit(1); 
      } 
      FILE *f = fopen(argv[1], "r"); 
      if(f == NULL) { 
            fprintf(stderr, "Failed to open file \"%s\".\n", argv[1]); 
            exit(1); 
      } 
      yyin = f;
      printf("Lancement parsing\n"); // yydebug=1;
      TSinit();
      yyparse();
      printTabIns();
      interpret();
      return 0;
}
