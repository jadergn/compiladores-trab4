#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct arvore Arvore;
typedef struct arvore_pilha Arvore_pilha;


Arvore* inicializa_arvore (void);
Arvore *cria_arvore(char tipo[], char valor[]);
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

Arvore * insere_arvore(Arvore *a, char tipo[], char valor[]);
Arvore *insere_arvore_arvore(Arvore *arvore, Arvore *a);
Arvore *insere_arvore_final(Arvore *final, Arvore *a);

Arvore_pilha *remove_pilha (Arvore_pilha *pilha);
Arvore *remove_final_pilha (Arvore_pilha *pilha);
Arvore *topo_pilha (Arvore_pilha *pilha);


void arvore_imprime(Arvore* a);
//Arvore* insere_atribuicao(Arvore *a, char variavel[], char tipo[],char valor[]);
Arvore * insere_pilha_arvore_atribuicao(Arvore *a, Arvore_pilha *p);
int tamanho_pilha(Arvore_pilha *pilha);
Arvore *monta_arvore_atribuicao(Arvore_pilha *pilha);


Arvore_pilha* inicializa_pilha();
Arvore_pilha* insere_pilha(Arvore_pilha *pilha, Arvore *a);
void arvore_pilha_imprime(Arvore_pilha *a);
