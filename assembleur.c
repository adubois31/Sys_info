#include <stdlib.h>
#include <stdio.h>
#include "assembleur.h"
#define NUMINS 100






int lastIns = -1;
instruction tabIns [NUMINS];


void initTabIns(){
    printf("initialisation table d'instruction \n");
    instruction insNull;
    insNull.op='n';
    insNull.res=-1;
    insNull.op1=-1;
    insNull.op2=-1;
    for (int i=0;i<NUMINS;i++){
        tabIns[i]=insNull;
    }
}

instruction getInst(int adr){
    return tabIns[adr];
}

int getLastInst(){
    return lastIns;
}

int getAdrLastJump(){
    for (int i = lastIns; i>=0; i--){
        if (tabIns[i].op == '8'){
            return i;
        }
    }
    return -1;
}

//return the adress of the first JMF instruction after begin
void modifyJump(int begin, int val){
    int i = begin;
    while (tabIns[i].op!='8'&&i<NUMINS){
        i++;
    }
    tabIns[i].op1=val;
}

void modifyInstr(int adr, int val){
    switch(tabIns[adr].op){
        case '7':tabIns[adr].res=val;break;
        case '8':tabIns[adr].op1=val;break;
        default: break;
    }
}

void printTabIns(){
    printf("********************Ecriture de la table d'instruction********************\n");
    for (int i=0;i<NUMINS;i++){
        printf("operation : %c, res : %d, op1 : %d, op2 : %d \n",tabIns[i].op,tabIns[i].res,tabIns[i].op1,tabIns[i].op2);
    }
}

char codeOP(enum operation op){
    switch(op){
        case ADD:return '1';
        case MUL:return '2';
        case SOU:return '3';
        case DIV:return '4';
        case COP:return '5';
        case AFC:return '6';
        case JMP:return '7';
        case JMF:return '8';
        case INF:return '9';
        case SUP:return 'A';
        case EQU:return 'B';
        case PRI:return 'C';
        case OR:return 'D';
        case AND: return 'E';
        case NOT: return 'F';
    }
}


void addInst3(enum operation op, int res, int op1, int op2){
    lastIns++;
    //if (lastIns > NUMINS) chopper débordement tableau
    instruction newIns;
    switch(op){
        case ADD:
        case MUL:
        case SOU:
        case DIV:
        case INF:
        case SUP:
        case EQU:
        case OR:
        case AND:
        //printf("ON essaye d'ajouter une instruction\n");
            newIns.op=codeOP(op);
            newIns.res=res;
            newIns.op1=op1;
            newIns.op2=op2;
            break;
        default: break;

    }
    tabIns[lastIns]=newIns;

}

void addInst2(enum operation op, int res, int operande){
    lastIns++;
    instruction newIns;
    switch(op){
        case COP:
        case AFC:
        case JMF:
        case NOT:
            newIns.op=codeOP(op);
            newIns.res=res;
            newIns.op1=operande;
            newIns.op2=-1;
            break;
        default: break;

    }
    tabIns[lastIns]=newIns;
}


void addInst1(enum operation op, int addr){
    lastIns++;
    instruction newIns;
    switch(op){
        case JMP:
        case PRI:
            newIns.op=codeOP(op);
            newIns.res=addr;
            newIns.op1=-1;
            newIns.op2=-1;
            break;
        default: break;

    }
    tabIns[lastIns]=newIns;
}

