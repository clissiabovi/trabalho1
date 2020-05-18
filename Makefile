all: main

main: main.y main.l 
	bison -dy main.y
	flex main.l
	gcc -omain lex.yy.c y.tab.c -ll
	

