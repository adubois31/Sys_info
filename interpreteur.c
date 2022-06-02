#include <stdio.h>
#include <stdlib.h>
#include <string.h>


#include "assembleur.h"

#define TAILLE 1000

int interpreterTable[TAILLE];

void initInterpretTable()
{
    for (int i = 0; i < TAILLE - 1; i++)
    {
        interpreterTable[i] = -1;
    }
}

void interpret()
{   
    printf("debut de l interpretation\n");
    initInterpretTable();
    int i=0;
    instruction inst = getInst(i);
    while (inst.op != 'n')
    {
        i++;
        
        switch (inst.op)
        {
        case '1':
            interpreterTable[inst.res] = interpreterTable[inst.op1] + interpreterTable[inst.op2];
            break;
        case '2':
            interpreterTable[inst.res] = interpreterTable[inst.op1] * interpreterTable[inst.op2];
            break;
        case '3':
            interpreterTable[inst.res] = interpreterTable[inst.op1] - interpreterTable[inst.op2];
            break;
        case '4':
            interpreterTable[inst.res] = interpreterTable[inst.op1] / interpreterTable[inst.op2];
            break;
        case '5':
            interpreterTable[inst.res] = interpreterTable[inst.op1];
            break;
        case '6':
            interpreterTable[inst.res] = inst.op1;
            break;
        case '7':
            i = inst.res;
            break;
        case '8':
            if (interpreterTable[inst.res] == 0)
            {
                i = inst.op1;
            }
            break;
        case '9':
            interpreterTable[inst.res] = interpreterTable[inst.op1] < interpreterTable[inst.op2];
            break;
        case 'A':
            interpreterTable[inst.res] = interpreterTable[inst.op1] > interpreterTable[inst.op2];
            break;
        case 'B':
            interpreterTable[inst.res] = interpreterTable[inst.op1] == interpreterTable[inst.op2];
            break;
        case 'C':
            printf("%d\n", interpreterTable[inst.res]);
            break;
        case 'D':
            interpreterTable[inst.res] = interpreterTable[inst.op1] || interpreterTable[inst.op2];
            break;
        case 'E':
            interpreterTable[inst.res] = interpreterTable[inst.op1] && interpreterTable[inst.op2];
            break;
        case 'F':
            interpreterTable[inst.res] = !interpreterTable[inst.op1];
            break;
        default:
            printf("\n");
            break;
        }
        inst = getInst(i);
        
    }
}
