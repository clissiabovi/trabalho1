

%{
#include <stdio.h>
  #include <stdlib.h>
void yyerror(char *);
int yylex(void);
%}

%token barran NUM PA PF ADD DIV MUL EL
%left ADD SUB
%left MUL
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
    ;

F:
    POT {}
    | E MUL E {printf("POP A\nPOP C\nMUL C\nPUSH A\n");}
    | E DIV E {printf("POP A\nPOP C\nDIV C\nPUSH A\n");}
    ;

POT:
    E EL E {printf("POP C\nPOP B\nMOV A, 1\nMOV D, 0\nloop:\nCMP C, D\nJZ end\nMUL B\nSUB C, 1\nJMP loop\nend:\nPUSH A\n");}
    | NUM {printf("PUSH %d\n", yylval);}
    ;

%%
/*
loop da potência
POP C
POP B
MOV A, 1
MOV D, 0
loop:
CMP C, D
JZ end
MUL B
SUB C, 1
JMP loop
end:
PUSH A
*/
void yyerror(char *s) {}

int main() {
  yyparse();
    return 0;

}
