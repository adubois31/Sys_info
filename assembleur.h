enum operation{
    ADD, MUL, SOU, DIV, COP , AFC, JMP, JMF, INF, SUP, EQU, PRI
};

void addInst3(enum operation op, int res, int op1, int op2);
void addInst2(enum operation op, int res, int operande);
void addInst1(enum operation op, int addr);