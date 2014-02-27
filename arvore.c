#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "arvore.h"

struct arvore{
	char *tipo;
	char *valor;
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

Arvore *cria_arvore(char tipo[], char valor[]){
	Arvore *a;
	a = (Arvore*) malloc(sizeof(Arvore));
	
	a->tipo = (char*) malloc ((strlen(tipo)+1)*sizeof(char)); 
	a->valor = (char*) malloc ((strlen(valor)+1)*sizeof(char));
	
	strcpy(a->tipo,tipo);
	strcpy(a->valor,valor);
	a->f1 = NULL;
	a->f2 = NULL;
	a->f3 = NULL;
	a->f4 = NULL;
	a->prox = NULL;
	
	
	return a;
	
}
Arvore * insere_arvore(Arvore *a, char tipo[], char valor[]){
	Arvore *arv;
	arv = (Arvore*) malloc(sizeof(Arvore));
	arv->tipo = (char*) malloc ((strlen(tipo)+1)*sizeof(char)); 
	arv->valor = (char*) malloc ((strlen(valor)+1)*sizeof(char));
	strcpy(arv->tipo,tipo);
	strcpy(arv->valor,valor);
	
	if (a->f1 == NULL)
		a->f1 = arv;
	else if (a->f2 == NULL)
		a->f2 = arv;
	else if (a->f3 == NULL)
		a->f3 = arv;
	else if (a->f4 == NULL)
		a->f4 = arv;			
	return a;
}
Arvore *insere_arvore_final(Arvore *final, Arvore *a){
	Arvore *aux;
	aux = final;
	if (aux ==NULL)
		aux = a;
	else{	
		while(aux->prox!=NULL){
			aux = aux->prox;
		}
		aux->prox = a;
	}
	return final;
}
Arvore *insere_arvore_arvore(Arvore *arvore, Arvore *a){
	Arvore *aux;
	aux = arvore;
	
	if(aux->f1 == NULL)
		aux->f1 = a;
	else if(aux->f2 == NULL)
		aux->f2 = a;
	else if(aux->f3 == NULL)
		aux->f3 = a;
	else if(aux->f4 == NULL)
		aux->f4 = a;
	return aux;				
		
}
//talvez nao use essa funcao
/*Arvore* insere_atribuicao(Arvore *a, char variavel[], char tipo[],char valor[]){
	Arvore *arv_atr,  *arv_var, *arv_val, *aux ;
	arv_atr = (Arvore*) malloc(sizeof(Arvore));
	arv_var = (Arvore*) malloc(sizeof(Arvore));
	arv_val = (Arvore*) malloc(sizeof(Arvore));
	
	arv_atr->tipo = (char*) malloc ((strlen("atribuicao")+1)*sizeof(char)); 
	arv_atr->valor = (char*) malloc ((strlen(":=")+1)*sizeof(char));
	strcpy(arv_atr->tipo,"atribuicao");
	strcpy(arv_atr->valor,":=");
	
	arv_val->tipo = (char*) malloc ((strlen(tipo)+1)*sizeof(char)); 
	arv_val->valor = (char*) malloc ((strlen(valor)+1)*sizeof(char));
	strcpy(arv_val->tipo,tipo);
	strcpy(arv_val->valor,valor);
	
	arv_var->tipo = (char*) malloc ((strlen("variavel")+1)*sizeof(char)); 
	arv_var->valor = (char*) malloc ((strlen(variavel)+1)*sizeof(char));
	strcpy(arv_var->tipo,"variavel");
	strcpy(arv_var->valor,variavel);
	
	arv_atr->f1 = arv_var;
	arv_atr->f2 = arv_val;
	arv_atr->f3 = NULL;
	arv_atr->f4 = NULL;
	arv_atr->prox = NULL;
	if(a==NULL){
		a = arv_atr;
	}
	else{
		for(aux = a; aux->prox!=NULL;aux = aux->prox){
			
		}
		aux->prox = arv_atr;	
	}	
	return a;
}*/

void arvore_imprime(Arvore* a){
       	if (a!=NULL){
       		printf("tipo = %s valor = %s\n", a->tipo, a->valor);
               	if(a->f1!=NULL){
               		printf("pai = %s f1 =>",a->valor);
               		arvore_imprime(a->f1);
               }
               if(a->f2!=NULL){
               		printf("pai = %s f2 =>",a->valor);
               		arvore_imprime(a->f2);
               	}
               	if(a->f3!=NULL){
					printf("pai = %s f3 =>",a->valor);
               		arvore_imprime(a->f3);
               	}
               	if(a->f4!=NULL){
               		printf("pai = %s f4 =>",a->valor);
               		arvore_imprime(a->f4);
       			}
       			/*if(a->prox != NULL){
       				printf("pai = %s prox =>",a->valor);
               		arvore_imprime(a->prox);
       			}*/
       }
}



struct arvore_pilha{
	Arvore *a;
	struct arvore_pilha *prox;		
};

Arvore * insere_pilha_arvore_atribuicao(Arvore *a, Arvore_pilha *p){
	Arvore_pilha *p1,*p2,*p3;
	Arvore *a1,*a2,*a3, *aux;
	p1 = p;
	a1 = p->a;
	p2 = p1->prox;
	a2 = p2->a;
	p3 = p2->prox;
	a3 = p3->a;
	if(strcmp(a3->valor,":=")==0){
		a3->f1 = a2;
		a3->f2 = a1;
	}
	else{
		//IMPLEMENTAR A ATRIBUICAO COM EXPRESSAO AQUI
	}
	if(a==NULL){
		a = a3;
	}
	else{
		for(aux = a; aux->prox!=NULL;aux = aux->prox){
			
		}
		aux->prox = a3;	
	}	
	
	return a;
}

Arvore_pilha* inicializa_pilha(){
	return NULL;
}

Arvore_pilha* insere_pilha(Arvore_pilha *pilha, Arvore *a){
	Arvore_pilha *nova;
	//printf("aqui2\n");
	nova =  (Arvore_pilha*) malloc(sizeof(Arvore_pilha));
	//nova->a =  (Arvore*) malloc(sizeof(Arvore));
	nova->a = a;
	nova->prox = pilha;
	//printf("aqui1\n");
	return nova;
	
}
Arvore_pilha * remove_pilha(Arvore_pilha *pilha){
	Arvore_pilha *aux;
	aux = pilha->prox;
	return aux;
}
Arvore *topo_pilha (Arvore_pilha *pilha){
	Arvore_pilha *p, *aux;
	Arvore *a;
	a = pilha->a;
	//aux = pilha;
	//pilha = inicializa_pilha();
	//pilha = aux->prox;
	//pilha = pilha->prox;
	return a;
	
}

Arvore *remove_final_pilha (Arvore_pilha *pilha){
	Arvore_pilha *p, *aux;
	Arvore *a;
	for(aux=pilha; aux->prox->prox!=NULL; aux = aux->prox){

	}
	a = aux->prox->a;
	aux->prox =NULL;
	return a;
	
}

int tamanho_pilha(Arvore_pilha *pilha){
	Arvore_pilha *p;
	int tam=0;
	for(p=pilha; p!=NULL; p=p->prox){
		tam++;
	}
	return tam;
}
//sempre deve remover do final e inserindo no topo da pilha, ai quando pegar um operador remove os doi elementos do topo da pilha, cria a arvore e insere novamente na pilha, fazer isso ate sobrar um elemento
Arvore *monta_arvore_atribuicao(Arvore_pilha *pilha){
	Arvore *aux,*aux_f1,*aux_f2;
	int tam = 0;
	tam = tamanho_pilha(pilha);
	while(tam > 1){
		aux = remove_final_pilha(pilha);
		if(strcmp(aux->tipo,"expressao")==0){
			aux_f1 = topo_pilha(pilha);
			pilha = remove_pilha(pilha);
			aux_f2 = topo_pilha(pilha);
			pilha = remove_pilha(pilha);
			aux->f1 = aux_f1;
			aux->f2 = aux_f2;
			pilha = insere_pilha(pilha,aux);
		}
		else{
			pilha = insere_pilha(pilha,aux);
		}
		tam = tamanho_pilha(pilha);
	}
	//arvore_imprime(pilha->a);
	return pilha->a;
}

void arvore_pilha_imprime(Arvore_pilha *a){
	Arvore_pilha *aux;
	
	for(aux=a; aux!=NULL;aux=aux->prox){
		arvore_imprime(aux->a);
	}
}

