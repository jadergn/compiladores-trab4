#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "arvore.h"

struct arvore{
	char tipo[30];
	char valor[30];
	struct arvore *f1;
	struct arvore *f2;
	struct arvore *f3;	
	struct arvore *f4;
	struct arvore *prox;		
};

Arvore* inicializa_arvore (void){
	return NULL;
}
void set_tipo_arvore(Arvore *a,char tipo[]){
	strcpy(a->tipo,tipo);
}
void set_valor_arvore(Arvore *a,char valor[]){
	strcpy(a->valor,valor);
}
void set_f1(Arvore *a,Arvore *f1){
	a->f1 = f1;
}
void set_f2(Arvore *a,Arvore *f2){
	a->f2 = f2;
}
void set_f3(Arvore *a,Arvore *f3){
	a->f3 = f3;
}
void set_f4(Arvore *a,Arvore *f4){
	a->f4 = f4;
}
void set_prox(Arvore *a,Arvore *prox){
	a->prox = prox;
}

char* get_tipo_arvore(Arvore *a){
	return a->tipo;
}
char* get_valor_arvore(Arvore *a){
	return a->valor;
}
Arvore* get_f1(Arvore *a){
	return a->f1;
}
Arvore* get_f2(Arvore *a){
	return a->f2;
}
Arvore* get_f3(Arvore *a){
	return a->f3;
}
Arvore* get_f4(Arvore *a){
	return a->f4;
}
Arvore* get_prox(Arvore *a){
	return a->prox;
}
