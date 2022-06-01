#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define TABLE_SIZE 1000
#define SYMB_PORTION 500


typedef struct{
    char name [16];
    char type [8];
    int profondeur;
} Symbole;

typedef struct{
    Symbole table [TABLE_SIZE] ;
    int sommetPile;
    int sommetTemp;
} TS;


TS TabSymb;
int profondeur;

void ts_inc_depth(){
    profondeur++;
}

void TSinit(){
    TabSymb.sommetPile=-1;
    TabSymb.sommetTemp=SYMB_PORTION-1;
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

void printTemp(){
    printf("-----------Ecriture de la Table des variables temporaires -----------\n");
    for (int i =SYMB_PORTION;i<=TabSymb.sommetTemp;i++){
        printf("value : %d \n",i);
    }
     printf("-----------Ecriture de la Table des variables temporaires -----------\n");
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

int pushTemp(){

    if (TabSymb.sommetTemp>=TABLE_SIZE){
        printf("Temporary Table full\n");
        return -1;
    }
    Symbole tempElem ;
    memcpy(&tempElem.name,"_",16);
    memcpy(&tempElem.type,"none",8);
    tempElem.profondeur=profondeur;
    TabSymb.sommetTemp++;
    TabSymb.table[TabSymb.sommetTemp]=tempElem;
    printTemp();
    return TabSymb.sommetTemp;
}

int popTemp(){
    if (TabSymb.sommetTemp<0){
        printf("Temporary Table empty\n");
        return -1;
    }
    int res = TabSymb.sommetTemp;
    TabSymb.sommetTemp--;
    /*Return the adress of the last element we did pop*/
    return res;
}

int findAddr(char * name){
    int found=0;
    int index=0;
    int res=-1;
    //printf("On cherche %s\n",name);
    //printf("La première case du tableau est : %s\n",TabSymb.table[0].name);
    //printf("test de comparaison : %d \n", strcmp("a","a"));
    while (!found && index<=TabSymb.sommetPile){
        if (strcmp(TabSymb.table[index].name, name)==0){
            found=1;
            res=index;
            //printf("TROUVE\n");
        }
        //printf("NON TROUVE\n");
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

