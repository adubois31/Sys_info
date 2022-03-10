typedef struct{
    char[16] name;
    int indexTS;
    char[8] type;
    int profondeur;
} Symbole;

typedef struct{
    Symbole S;
    Cellule * next;
} Cellule;


typedef struct{
    Cellule * pile;
    Cellule * finPile;
} TS;


void init():
void pushTS(char * name, int indexTS, char * type, int profondeur);
Symbole popTS();
extern TS TableSymb;
