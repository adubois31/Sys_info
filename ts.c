#include <stdlib.h>
#include <stdio.h>
#include <string.h>



typedef struct{
    char name [16];
    char type [8];
    int profondeur;
} Symbole;

typedef struct{
    Symbole table [1000] ;
    int sommetPile;
} TS;

TS TabSymb;
int profondeur;

void ts_inc_depth(){
    profondeur++;
}

void TSinit(){
    TabSymb.sommetPile=-1;
    profondeur=-1;
}


void printTS(){
    printf("-----------Ecriture de la Table des symboles -----------\n");
    for (int i =0;i<=TabSymb.sommetPile;i++){
        Symbole S = TabSymb.table[i];
        printf("name : %s , type : %s , profondeur : %d \n",S.name,S.type,S.profondeur);
    }
     printf("-----------Fin print de la Table des symboles -----------\n");
}

void pushTS(char name [16],int isConst){
    Symbole newElem;
    if (isConst){
        memcpy(&newElem.name, name,16);
        memcpy(&newElem.type, "cint",8);
        newElem.profondeur=profondeur;
    }
    else{
        memcpy(&newElem.name, name,16);
        memcpy(&newElem.type, "int",8);
        newElem.profondeur=profondeur;}
    TabSymb.sommetPile++;
    TabSymb.table[TabSymb.sommetPile]=newElem;
    printTS();
}

int findAddr(char name[16]){
    int found=0;
    int index=0;
    int res=-1;
    while (!found && index<=TabSymb.sommetPile){
        if (strcmp(TabSymb.table[index].name, name)){
            found=1;
            res=index;
        }
        index++;
    }
    return res;
}

void ts_dec_depth(){
    while (TabSymb.sommetPile>=0 && ((TabSymb.table[TabSymb.sommetPile]).profondeur==profondeur)){
        TabSymb.sommetPile--;
    }
    profondeur--;
}

int getSommet(){
    return TabSymb.sommetPile;
}

