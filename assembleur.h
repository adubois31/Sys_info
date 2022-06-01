enum operation{
    ADD, MUL, SOU, DIV, COP , AFC, JMP, JMF, INF, SUP, EQU, PRI, OR, AND, NOT
};

typedef struct{
    char op;
    int res;
    int op1;
    int op2;
}instruction;

void initTabIns();
void printTabIns();
int getLastInst();
int getAdrLastJump();
void modifyInstr(int adr, int val);
void modifyJump(int begin, int val);
void addInst3(enum operation op, int res, int op1, int op2);
void addInst2(enum operation op, int res, int operande);
void addInst1(enum operation op, int addr);
instruction getInst(int adr);