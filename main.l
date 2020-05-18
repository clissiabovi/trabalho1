
%{
#include <stdlib.h>
void yyerror(char *);

#include "y.tab.h"

%}


%%

[0-9]+ {yylval=atoi(yytext);return NUM;}

[\(] {return PA;}
[\)] {return PF;}

[\+] {return ADD;}
[\/] {return DIV;}
[\*] {return MUL;}
[\^] {return EL;}

[\n]+ {return barran;}

[[:space:]]+ ;

.

%%

int yywrap() {
  return 1;
}
