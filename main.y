

%{
#include <stdio.h>
  #include <stdlib.h>
void yyerror(char *);
int yylex(void);
int i=0;
%}

%token barran NUM PA PF ADD SUB DIV MUL EL
%left ADD SUB
%left MUL DIV
%left EL

%%

S:
    E barran {printf("POP A\n");}
    |
    ;

E: 
    F {}
    | PA E PF {}
    | E ADD E {printf("POP A\nPOP C\nADD C, A\nPUSH C\n");}
    | E SUB E {printf("POP A\nPOP C\nSUB C, A\nPUSH C\n");}
    ;

F:
    POT {}
    | E MUL E {printf("POP A\nPOP C\nMUL C\nPUSH A\n");}
    | E DIV E {printf("POP C\nPOP A\nDIV C\nPUSH A\n");}
    ;

POT:
    E EL E {printf("POP C\nPOP B\nMOV A, 1\nMOV D, 0\nloop%d:\nCMP C, D\nJZ end%d\nMUL B\nSUB C, 1\nJMP loop%d\nend%d:\nPUSH A\n", i,i,i,i);i++;}
    | NUM {printf("PUSH %d\n", yylval);}
    ;

%%
/*
loop da potência
POP C
POP B
MOV A, 1
MOV D, 0
loop%d:
CMP C, D
JZ end%d
MUL B
SUB C, 1
JMP loop%d
end%d:
PUSH A
*/
void yyerror(char *s) {}

int main() {
  yyparse();
    return 0;

}
