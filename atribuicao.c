#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "arvore.h"
#include "atribuicao.h"

//o tipo é se é inteiro ou real.
void insere_atribuicao(Arvore *a, char variavel[], char tipo[],char valor[]){
	Arvore *arv_atr,  *arv_var, *arv_val, *aux ;
	// esse mallocs nao podem estar aqui, tem q colocar na inicializacao da arvore
	arv_atr = (Arvore*) malloc(sizeof(Arvore));
	arv_var = (Arvore*) malloc(sizeof(Arvore));
	arv_val = (Arvore*) malloc(sizeof(Arvore));
	
	set_tipo(avr_val,tipo);
	set_valor(avr_val,valor);
	
	set_tipo(arv_var,"var");
	set_valor(arv_var,variavel);
	
	set_f1(arv_atr,arv_var);
	set_f2(arv_atr,arv_val);
	set_f3(arv_atr,NULL);
	set_f4(arv_atr,NULL);
	set_prox(arv_atr,NULL);
	//quando modificar a inicializacao, modificar aqui tbm testar se a->prox é vazio
	if(a==NULL){
		a = arv_atr;
	}
	else{
		for(aux = a; aux->prox!=NULL;aux = aux->prox){
			
		}
		aux->prox = arv_atr;	
	}	
}
