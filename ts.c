#include <stdlib.h>
#include <stdio.h>

void init (){
    TableSymb.pile = null;
    TableSymb.finPile = null;
}

void pushTS(char * nom, int index, char * type, int profondeur){
    Symbole newS;
    strncpy(newS.name, nom,sizeof(nom));
    newS.indexTS = index;
    strncpy(newS.type, type,sizeof(type));
    newS.profondeur=profondeur;
    Cellule newCell=(Cellule){newS,null};
    if (TableSymb.pile==null){
        TableSymb.pile=&newCell;
        TableSymb.finPile=&newCell;
    }
    else{
        (TableSymb.finPile)->next=&newCell;
        TableSymb.finPile=&newCell;
    }
    
}

Symbole popTS(){
    Symbole returnedS;
    Cellule * currentCell = TableSymb.pile;
    if (currentCell==null)
        return null;
    else{
        while(currentCell->next/=TableSymb.finPile){
            currentCell=currentCell->next;
        }
        returnedS=(currentCell->next)->S
        currentCell->next=null;
        TableSymb.finPile = currentCell;
        return returnedS;
    }
}