#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct arvore Arvore;

Arvore* inicializa_arvore (void);
void set_tipo_arvore(Arvore *a,char tipo[]);
void set_valor_arvore(Arvore *a,char comando[]);
void set_f1(Arvore *a,Arvore *f1);
void set_f2(Arvore *a,Arvore *f2);
void set_f3(Arvore *a,Arvore *f3);
void set_f4(Arvore *a,Arvore *f4);
void set_prox(Arvore *a,Arvore *prox);

char* get_tipo_arvore(Arvore *a);
char* get_valor_arvore(Arvore *a);
Arvore* get_f1(Arvore *a);
Arvore* get_f2(Arvore *a);
Arvore* get_f3(Arvore *a);
Arvore* get_f4(Arvore *a);
Arvore* get_prox(Arvore *a);
