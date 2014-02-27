#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct variavel Variavel;
typedef struct funcao Funcao;
typedef struct lista Lista;
typedef struct pilha Pilha;
typedef struct item Item;


Lista* inicializa (void);
Lista** inicializa_hash (void);
void imprime (Lista* l);
int vazia (Lista* l);
void verifica_variavel_usada(Lista** l);
void verifica (Lista* l);
int verifica_tipo_parametros_funcao(Lista** h, char funcao[],Lista* l);
int get_tipo(Lista* l);
float *get_valor(Lista* l);
int get_escopo(Lista* l);
int get_usada(Lista* l);
char* get_nome(Lista* l);
void set_valor(Lista* l, float valor);
int get_aridade(Lista* l);
int get_retorno(Lista* l);
int verifica_tipo(Lista** h, char expressao[], int escopo);
Lista* busca (Lista** l, char c[], int escopo);
Lista* insere_variavel_lista(Lista* l, char nome[], int usada);

Lista* insere_variavel_lista1(Lista* l, char nome[], int tipo, int escopo, int usada);

Lista** insere_variavel_hash(Lista** h, Lista* l, int tipo,int escopo);
Lista** insere_variavel (Lista** l, char nome[], int tipo, int usada, int escopo);
Lista** insere_funcao (Lista** l, char nome[], int retorno, int aridade);
Lista* insere_funcao_lista(Lista* l, char nome[]);
Lista** insere_funcao_hash(Lista** h, Lista* l, int retorno, int aridade);
Lista** insere_parametro_funcao(Lista** h, char nome[], int tipo_parametros[]);
void imprime_hash(Lista** l);

Pilha *pilha_constroi();
int pilha_vazia(Pilha *pilha);
void pilha_insere(Pilha *pilha, int inteiro);
int pilha_remove(Pilha *pilha);
void pilha_destroi(Pilha *pilha);


