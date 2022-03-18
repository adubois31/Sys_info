#include <stdlib.h>
#include <stdio.h>




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

void init(){
    TabSymb.sommetPile=-1;
    profondeur=-1;
}

void pushTS(char name [16],int isConst){
    Symbole newElem;
    if (isConst){
        newElem = (Symbole){name,"cint",profondeur};;
        printf("PROFONDEUR : %d \n", profondeur);
    }
    else{
        newElem = (Symbole){name,"int",profondeur};
        printf("PROFONDEUR : %d\n", profondeur);
    }
    TabSymb.sommetPile++;
    TabSymb.table[TabSymb.sommetPile]=newElem;
    printTS();
}

void printTS(){
    printf("-----------Ecriture de la Table des symboles -----------\n");
    for (int i =0;i<=TabSymb.sommetPile;i++){
        Symbole S = TabSymb.table[i];
        printf("name : %s , type : %s , profondeur : %d \n",S.name,S.type,S.profondeur);
    }
     printf("-----------Fin print de la Table des symboles -----------\n");
}

void ts_dec_depth(){
    while (TabSymb.sommetPile>=0 && (TabSymb.sommetPile)==(TabSymb.table[TabSymb.sommetPile]).profondeur){
        TabSymb.sommetPile--;
    }
}

