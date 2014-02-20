all: analisador relatorio

analisador:	
	flex -i analisador_lexico.l
	bison -v analisador_sintatico.y
	gcc -c hash.c
	gcc -c arvore.c
	gcc -c atribuicao.c
	gcc -o trab3 analisador_sintatico.tab.c -lfl hash.o arvore.o atribuicao.o
	
relatorio:
	pdflatex trab3.tex

clean:
	rm -rf trab3 lex.yy.c analisador_sintatico.tab.c *~ hash.o
	rm -rf trab3.log texput.log trab3.aux trab3.pdf 
	rm -rf *.output
