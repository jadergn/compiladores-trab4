#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "arvore.h"
#include "hash.h"

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
	if (aux ==NULL){
		return a;
	}	
	else{	
		while(aux->prox!=NULL){
			aux = aux->prox;
		}
		aux->prox = a;
		return final;
	}
	
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
       }
}
void arvore_imprime_final(Arvore *a){
	Arvore *aux;
	for(aux=a;aux!=NULL;aux=aux->prox){
		arvore_imprime(aux);
	}
}


struct arvore_pilha{
	Arvore *a;
	struct arvore_pilha *prox;		
};

float executa_expressao(Arvore *a, Lista **tab_variaveis){
	float valor;
	Arvore *aux;
	Lista *var;
	aux = a;
	if((strcmp(aux->tipo,"expressao")==0) && (strcmp(aux->valor,"+")==0)){
		valor = executa_expressao(aux->f1,tab_variaveis) + executa_expressao(aux->f2,tab_variaveis);
	}
	else if((strcmp(aux->tipo,"expressao")==0) && (strcmp(aux->valor,"-")==0)){
		valor = executa_expressao(aux->f1,tab_variaveis) - executa_expressao(aux->f2,tab_variaveis);
	}
	else if((strcmp(aux->tipo,"expressao")==0) && (strcmp(aux->valor,"*")==0)){
		valor = executa_expressao(aux->f1,tab_variaveis) * executa_expressao(aux->f2,tab_variaveis);
	}
	else if((strcmp(aux->tipo,"expressao")==0) && (strcmp(aux->valor,"/")==0)){
		valor = executa_expressao(aux->f1,tab_variaveis) / executa_expressao(aux->f2,tab_variaveis);
	}
	else if((strcmp(aux->tipo,"inteiro")==0)){
		return atof(a->valor);
	}
	else if((strcmp(aux->tipo,"real")==0)){
		return atof(a->valor);
	}
	else if((strcmp(aux->tipo,"funcao")==0)){
		int ret;
		if(strcmp(aux->valor,"maximo")==0){
			ret = executa_maximo (aux,tab_variaveis);
		}
		if(strcmp(aux->valor,"minimo")==0){
			ret = executa_minimo (aux,tab_variaveis);
		}
		if(strcmp(aux->valor,"media")==0){
			ret = executa_media (aux,tab_variaveis);
		}
		return ret;
	}
	else if (strcmp(aux->tipo,"variavel")==0){
		
		var = busca(tab_variaveis,aux->valor, 0);
		if(get_tipo(var)==0)
			return get_valor_int(var);	
		else if(get_tipo(var)==3)
			return get_valor_float(var);	
	}
	return valor;

}

void executa_imprima(Arvore *a, Lista **tab_variaveis){
	Lista *l;
	
	
	l = busca (tab_variaveis, a->f1->valor, 0);
	if(get_tipo(l) == 0){
		int valor;
		valor = get_valor_int(l);
		printf("%d",valor);
	}
	if(get_tipo(l) == 1){
		char valor;
		valor = get_valor_char(l);
		printf("%c",valor);
	}
	if(get_tipo(l) == 2){
		char* valor;
		valor = get_valor_string(l);
		printf("%s",valor);
	}
	if(get_tipo(l) == 3){
		float valor;
		valor = get_valor_float(l);
		printf("%f",valor);
	}
}

void executa_imprima_ln(Arvore *a, Lista **tab_variaveis){
	Lista *l;
	
	
	l = busca (tab_variaveis, a->f1->valor, 0);
	if(get_tipo(l) == 0){
		int valor;
		valor = get_valor_int(l);
		printf("%d\n",valor);
	}
	if(get_tipo(l) == 1){
		char valor;
		valor = get_valor_char(l);
		printf("%c\n",valor);
	}
	if(get_tipo(l) == 2){
		char* valor;
		valor = get_valor_string(l);
		printf("%s\n",valor);
	}
	if(get_tipo(l) == 3){
		float valor;
		valor = get_valor_float(l);
		printf("%f\n",valor);
	}
}

void executa_leia(Arvore *a,Lista **tab_variaveis){
	Lista *l;
	l = busca (tab_variaveis, a->f1->valor, 0);
	if(get_tipo(l) == 0){
		int valor;
		scanf("%d",&valor);
		set_valor(l,valor);
	}
	if(get_tipo(l) == 1){
		char valor;
		scanf("%c",&valor);
		set_valor_string(l,&valor);
	}
	if(get_tipo(l) == 2){
		char* valor;
		scanf("%s",valor);
		set_valor_string(l,valor);
	}
	if(get_tipo(l) == 3){
		float valor;
		scanf("%f",&valor);
		set_valor(l,valor);
	}
}
Lista** executa_arvore(Arvore *a, Lista **tab_variaveis){
	if(strcmp(a->tipo,"atribuicao")==0){
		return executa_atribuicao(a,tab_variaveis);;
	}
	else if(strcmp(a->tipo,"funcao")==0){
		if(strcmp(a->valor,"imprima")==0){
			executa_imprima(a,tab_variaveis);
			return tab_variaveis;
		}
		if(strcmp(a->valor,"imprima_ln")==0){
			executa_imprima_ln(a,tab_variaveis);
			return tab_variaveis;
		}
		if(strcmp(a->valor,"leia")==0){
			executa_leia(a,tab_variaveis);
			return tab_variaveis;
		}
		
	}
	//ir adicionando todas as funcoes de execucao que forem criadas	
}

void executa_arvore_final(Arvore *arvore_final, Lista **tab_variaveis){
	Arvore *aux;
	Lista **tab;
	tab = tab_variaveis;
	for(aux=arvore_final; aux!=NULL; aux=aux->prox){
		tab = executa_arvore(aux,tab);

	}
	
}
int executa_maximo(Arvore *a, Lista **tab){
	Lista *l1, *l2;
	l1 = busca(tab,a->f1->valor,0);
	l2 = busca(tab,a->f2->valor,0);
	if(get_valor_int(l1)>get_valor_int(l2)){
		return get_valor_int(l1);
	}
	else{
		return get_valor_int(l2);
	}
}
int executa_minimo(Arvore *a, Lista **tab){
	Lista *l1, *l2;
	l1 = busca(tab,a->f1->valor,0);
	l2 = busca(tab,a->f2->valor,0);
	if(get_valor_int(l1)<get_valor_int(l2)){
		return get_valor_int(l1);
	}
	else{
		return get_valor_int(l2);
	}
}
int executa_media(Arvore *a, Lista **tab){
	Lista *l1, *l2;
	l1 = busca(tab,a->f1->valor,0);
	l2 = busca(tab,a->f2->valor,0);
	return (get_valor_int(l1)+get_valor_int(l2))/2;
}
Lista** executa_atribuicao (Arvore *a,Lista **tab_variaveis){
	float valor, v;
	Arvore *aux;
	Lista *l;
	Lista **tab;
	tab = tab_variaveis;
	aux=a->f2;
	
	if((strcmp(aux->tipo,"inteiro")==0) || (strcmp(aux->tipo,"real")==0)){
		valor = atof(aux->valor);
		l = busca (tab, a->f1->valor, 0);
		set_valor(l,valor);
		return tab;
	}
	else if ((strcmp(aux->tipo,"literal")==0) || (strcmp(aux->tipo,"caracter")==0)){
		char *str;
		str = (char*) malloc ((strlen(aux->valor)+1)*sizeof(char));
		strcpy(str,aux->valor);
		l = busca (tab, a->f1->valor, 0);
		set_valor_string(l,str);
		return tab;
	}
	else if ((strcmp(aux->tipo,"funcao")==0)){
		int ret;
		if(strcmp(aux->valor,"maximo")==0){
			ret = executa_maximo (aux,tab);
		}
		if(strcmp(aux->valor,"minimo")==0){
			ret = executa_minimo (aux,tab);
		}
		if(strcmp(aux->valor,"media")==0){
			ret = executa_media (aux,tab);
		}
		l = busca (tab, a->f1->valor, 0);
		set_valor(l,ret);
		return tab;
	}
	else{
		valor = executa_expressao(aux,tab);
	}
	l = busca (tab, a->f1->valor, 0);
	set_valor(l,valor);
	return tab;
}

Arvore_pilha* inicializa_pilha(){
	return NULL;
}

Arvore_pilha* insere_pilha(Arvore_pilha *pilha, Arvore *a){
	Arvore_pilha *nova;
	nova =  (Arvore_pilha*) malloc(sizeof(Arvore_pilha));

	nova->a = a;
	nova->prox = pilha;

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
			aux_f2 = topo_pilha(pilha);
			pilha = remove_pilha(pilha);
			aux_f1 = topo_pilha(pilha);
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
	return pilha->a;
}



void arvore_pilha_imprime(Arvore_pilha *a){
	Arvore_pilha *aux;
	
	for(aux=a; aux!=NULL;aux=aux->prox){
		arvore_imprime(aux->a);
	}
}

