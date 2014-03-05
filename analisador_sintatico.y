%{
#include <stdio.h>
#include "hash.h"
#include "arvore.h"

Lista **tab_variaveis, **tab_funcoes;
Lista *var, *func, *l, *v;

Arvore *arvore_final, *arvore_atribuicao,*aux, *arvore_if, *arvore_funcao;

Arvore_pilha *pilha_arvore;


Pilha *pilha_exp;
int expressao_tipo;

int i;
int qtd_parametros;
int tipo_parametros[10];
int retorno_func;
char valor_esquerda[100];
extern int tipo;
extern char operacao;
extern char * yytext;
extern char identificador[100];
extern char funcao[100];
extern int num_linha;
extern char expressao[2000];
extern int escopo;
%}

/*%error-verbose*/
%token token_pr_algoritmo
%token token_pr_variaveis
%token token_pr_fim_variaveis
%token token_pr_inicio
%token token_pr_fim
%token token_pr_inteiro
%token token_pr_inteiros
%token token_pr_caractere
%token token_pr_caracteres
%token token_pr_real
%token token_pr_reais
%token token_pr_literal
%token token_pr_literais
%token token_pr_logico
%token token_pr_logicos
%token token_pr_matriz
%token token_pr_se
%token token_pr_entao
%token token_pr_senao
%token token_pr_fim_se
%token token_pr_para
%token token_pr_de
%token token_pr_ate
%token token_pr_faca
%token token_pr_passo
%token token_pr_fim_para
%token token_pr_enquanto
%token token_pr_fim_enquanto
%token token_pr_imprima
%token token_pr_leia
%token token_pr_imprima_ln
%token token_pr_leia_ln
%token token_pr_maximo
%token token_pr_minimo
%token token_pr_media
%token token_pr_funcao
%token token_pr_retorne
%token token_pr_verdadeiro
%token token_pr_falso
%token token_pr_e
%token token_pr_ou
%token token_pr_nao
%token token_inteiro;
%token token_real;
%token token_caractere
%token token_literal
%token token_soma
%token token_subtracao
%token token_divisao
%token token_multiplicacao
%token token_incrementador
%token token_modulo
%token token_maior
%token token_maior_igual
%token token_menor
%token token_menor_igual
%token token_igual
%token token_diferente
%token token_e
%token token_e_bit
%token token_ou
%token token_ou_bit
%token token_xor_bit
%token token_til
%token token_nao
%token token_aspas_dupla
%token token_aspas_simples
%token token_abre_parenteses
%token token_fecha_parenteses
%token token_abre_chaves
%token token_fecha_chaves
%token token_abre_colchetes
%token token_fecha_colchetes
%token token_tralha
%token token_contra_barra
%token token_ponto
%token token_virgula
%token token_dois_pontos
%token token_ponto_virgula
%token token_atribuicao
%token token_identificador 
%token token_desconhecido
%token token_pr_fim_funcao
%token token_pr_escolha
%token token_pr_caso 
%token token_pr_fim_escolha
%token token_pr_default

%start algoritmo


%%


algoritmo
: declaracao_algoritmo declaracao_funcoes bloco_variaveis bloco_inicio_principal
| declaracao_algoritmo bloco_variaveis bloco_inicio_principal
{
	//imprime_hash(tab_variaveis);
}
;

declaracao_algoritmo
: token_pr_algoritmo token_identificador token_ponto_virgula
{
//apagando o vetor expressao
for(i=0;i<2000;i++){
		expressao[i]='\0';
	}
}
;

/*bloco de variaveis pode nao existir ou pode ser vazio*/
bloco_variaveis
: token_pr_variaveis declaracao_variaveis token_pr_fim_variaveis
| token_pr_variaveis token_pr_fim_variaveis
|
;

declaracao_variaveis
: lista_variaveis token_dois_pontos tipo_variavel token_ponto_virgula
{
	//insere a lista de variaveis(var) na tabela de variaveis(tab_variaveis), crio uma lista antes, pois so aqui fica sabendo do tipo das variaveis
	tab_variaveis = insere_variavel_hash(tab_variaveis, var, tipo,escopo);
	//se retornar vazio foi pq tentou redeclarar uma variavel
	if(tab_variaveis == NULL){
		printf("Erro semantico na linha %d. Variavel redeclarada.\n",num_linha);
		exit(0);
	}
	libera(var);
	var = inicializa();
	//apaga o vetor de expressao
	for(i=0;i<2000;i++){
		expressao[i]='\0';
	}
}
| declaracao_variaveis lista_variaveis token_dois_pontos tipo_variavel token_ponto_virgula
{
	//insere a lista de variaveis(var) na tabela de variaveis(tab_variaveis), cria uma lista antes pois so aqui fica sabendo do tipo das variaveis
	tab_variaveis = insere_variavel_hash(tab_variaveis, var, tipo,escopo);
	//se retornar vazio foi pq tentou redeclarar uma variavel
	if(tab_variaveis == NULL){
		printf("Erro semantico na linha %d. Variavel redeclarada.\n",num_linha);
		exit(0);
	}
	libera(var);
	var = inicializa();
	//apaga o vetor de expressao
	for(i=0;i<2000;i++){
		expressao[i]='\0';
	}
}
;

tipo_variavel
: tipo_primitivo
| tipo_matriz
;

lista_variaveis
: lista_variaveis token_virgula token_identificador
{
	//insere todas as variaveis dentro de uma lista(todas as variaveis tem o mesmo tipo)
	var = insere_variavel_lista(var,identificador,0);
}
| token_identificador
{
	//insere todas as variaveis dentro de uma lista(todas as variaveis tem o mesmo tipo)
	var = insere_variavel_lista(var,identificador,0);
}
;

tipo_primitivo
: token_pr_inteiro
{
	retorno_func = 0;
}
| token_pr_real
{
	retorno_func = 3;
}
| token_pr_caractere
{
	retorno_func = 1;
}
| token_pr_literal
{
	retorno_func = 2;
}
| token_pr_logico
;

tipo_matriz
: token_pr_matriz matriz_colchetes token_pr_de tipo_primitivo_plural
;

matriz_colchetes
: matriz_colchetes token_abre_colchetes token_inteiro token_fecha_colchetes
| token_abre_colchetes token_inteiro token_fecha_colchetes
;

tipo_primitivo_plural
: token_pr_inteiros
| token_pr_reais
| token_pr_caracteres
| token_pr_literais
| token_pr_logicos
;

/*bloco inicio pode ser vazio*/
bloco_inicio_principal
: token_pr_inicio lista_comandos token_pr_fim
{
	//fim do programa, verificas se tem alguma variavel que nao foi utilizada
	verifica_variavel_usada(tab_variaveis);
}
| token_pr_inicio token_pr_fim
;

bloco_inicio_funcao
: token_pr_inicio lista_comandos token_pr_fim
{
	//fim do programa, verificas se tem alguma variavel que nao foi utilizada
	verifica_variavel_usada(tab_variaveis);
}
| token_pr_inicio token_pr_fim
;

lista_comandos
: lista_comandos comando
| comando
;

comando
: atribuicao
{
	//apaga o vetor de expressao
	for(i=0;i<2000;i++){
		expressao[i]='\0';
	}
}
| chamada_funcao token_ponto_virgula
| chamada_funcao_interna
| comando_retorne
| comando_se
| comando_enquanto
| comando_para
| comando_escolha
;

valor_esquerda
: token_identificador
{
	//verifica se a variavel que estao recebendo atribuicao foi declarada, se sim usada=1, var=NULL nao foi encontrada a variavel, logo ela nao foi declarada
	var =busca(tab_variaveis,identificador, escopo); 
	if(var == NULL){
		printf("Erro semantico na linha %d. Variavel nao declarada.\n",num_linha);
		exit(0);
		
	}else{
		strcpy(valor_esquerda,identificador);
		set_usada(var);
	}
	
	arvore_atribuicao = cria_arvore("atribuicao",":=");
	arvore_atribuicao = insere_arvore(arvore_atribuicao,"variavel",identificador);
	
	var = inicializa();	
	
}
| token_identificador matriz_colchetes
;

atribuicao
: valor_esquerda token_atribuicao expressao token_ponto_virgula
{
	
	var =busca(tab_variaveis,valor_esquerda, escopo);
	//printf("OI!\n");
	//arvore_pilha_imprime(pilha_arvore);
	aux = monta_arvore_atribuicao(pilha_arvore);
	//printf("OI1!\n");
	arvore_atribuicao = insere_arvore_arvore(arvore_atribuicao, aux);
	//arvore_imprime(arvore_atribuicao);
	arvore_final = insere_arvore_final(arvore_final,arvore_atribuicao);
	//printf("\n\n#######################################\n\n");
	if(get_tipo(var)!=expressao_tipo){
		printf("Erro semantico na linha %d. Tipo de atribuicao invalida.\n",num_linha);
		exit(0);
	}
	//arvore_imprime(arvore_final);
	
	executa_arvore_final(arvore_final,tab_variaveis);
	//var =busca(tab_variaveis,"idade", escopo);
	aux = inicializa_arvore();
	//printf("--%s = %f\n",get_nome(var),*get_valor(var));
	arvore_atribuicao = inicializa_arvore();
	pilha_arvore = inicializa_pilha();
	var=inicializa();
	
}
;

comando_retorne
: token_pr_retorne token_ponto_virgula
| token_pr_retorne expressao token_ponto_virgula
;

//nao pode ter escolha sem o caso
comando_escolha
: token_pr_escolha token_abre_parenteses token_identificador token_fecha_parenteses casos token_pr_fim_escolha
;

casos
: casos caso
| caso
;

caso
: token_pr_caso valor_primitivo token_dois_pontos lista_comandos token_pr_para token_ponto_virgula
| token_pr_caso valor_primitivo token_dois_pontos token_pr_para token_ponto_virgula
| token_pr_default token_dois_pontos lista_comandos token_pr_para token_ponto_virgula
;


comando_se
: token_pr_se expressao token_pr_entao lista_comandos token_pr_fim_se
| token_pr_se expressao token_pr_entao lista_comandos token_pr_senao lista_comandos token_pr_fim_se
;

comando_enquanto
: token_pr_enquanto expressao token_pr_faca lista_comandos token_pr_fim_enquanto
;

comando_para
: token_pr_para valor_esquerda token_pr_de expressao token_pr_ate expressao token_pr_faca lista_comandos token_pr_fim_para
| token_pr_para valor_esquerda token_pr_de expressao token_pr_ate expressao passo token_pr_faca lista_comandos token_pr_fim_para
;

passo
: token_pr_passo token_inteiro
| token_pr_passo token_soma token_inteiro
| token_pr_passo token_subtracao token_inteiro
;

expressao
: expressao token_pr_ou termo_1
{
	expressao_tipo = pilha_remove(pilha_exp);
	pilha_destroi(pilha_exp);
	pilha_constroi(pilha_exp);
}
| expressao token_ou termo_1
{
	expressao_tipo = pilha_remove(pilha_exp);
	pilha_destroi(pilha_exp);
	pilha_constroi(pilha_exp);
}
| termo_1
{
	expressao_tipo = pilha_remove(pilha_exp);
	pilha_destroi(pilha_exp);
	pilha_constroi(pilha_exp);
}
;

termo_1
: termo_1 token_pr_e termo_2
| termo_1 token_e termo_2
| termo_2
;

termo_2
: termo_2 token_ou_bit termo_3
| termo_3
;

termo_3
: termo_3 token_xor_bit termo_4
| termo_4
;

termo_4
: termo_4 token_e_bit termo_5
| termo_5
;

termo_5
: termo_5 token_igual termo_6
| termo_5 token_diferente termo_6
| termo_6
;

termo_6
: termo_6 token_menor termo_7
| termo_6 token_menor_igual termo_7
| termo_6 token_maior termo_7
| termo_6 token_maior_igual termo_7
| termo_7
;

termo_7
: termo_7 token_soma termo_8
{
	//printf("Soma\n");
	
	pilha_arvore = insere_pilha(pilha_arvore,cria_arvore("expressao","+"));
}
| termo_7 token_subtracao termo_8
{
	//printf("Subtracao\n");
	pilha_arvore = insere_pilha(pilha_arvore,cria_arvore("expressao","-"));
}
| termo_8
;

termo_8
: termo_8 token_multiplicacao termo_9
{
	//printf("Multiplicao\n");
	
	pilha_arvore = insere_pilha(pilha_arvore,cria_arvore("expressao","*"));
}
| termo_8 token_divisao termo_9
{
	//printf("Divisao\n");
	
	pilha_arvore = insere_pilha(pilha_arvore,cria_arvore("expressao","/"));
}
| termo_8 token_modulo termo_9
| termo_9
;

termo_9
: token_soma termo_9
| token_subtracao termo_9
| token_nao termo_9
| token_abre_parenteses expressao token_fecha_parenteses
| token_identificador
{
	//verifica se a variavel foi declarada
	
	var =busca(tab_variaveis,identificador, escopo); 
	if(var == NULL){
		printf("Erro semantico na linha %d. Variavel nao declarada.\n",num_linha);
		exit(0);
		
	}else{
		set_usada(var);
		pilha_insere(pilha_exp, get_tipo(var));
		if(pilha_verifica_compatibilidade(pilha_exp)) {
		}
		else {
			printf("Erro semantico na linha %d. Incompatibilidade de tipos na expressão.\n", num_linha);
			exit(0);
		}
	}
	pilha_arvore = insere_pilha(pilha_arvore,cria_arvore("variavel",identificador));
	var = inicializa();
}
| valor_primitivo
{
	pilha_insere(pilha_exp, tipo);
	if(pilha_verifica_compatibilidade(pilha_exp)) {
	}
	else {
		printf("Erro semantico na linha %d. Incompatibilidade de tipos na expressão.\n", num_linha);
		exit(0);
	}
	if (tipo ==0)
		pilha_arvore = insere_pilha(pilha_arvore,cria_arvore("inteiro",yytext));
	else if (tipo ==1)
		pilha_arvore = insere_pilha(pilha_arvore,cria_arvore("caracter",yytext));
	else if (tipo ==2)
		pilha_arvore = insere_pilha(pilha_arvore,cria_arvore("literal",yytext));	
	else if (tipo ==3)
		pilha_arvore = insere_pilha(pilha_arvore,cria_arvore("real",yytext));	
	else if (tipo ==4)
		pilha_arvore = insere_pilha(pilha_arvore,cria_arvore("booleano",yytext));	
	//printf("tipo = %d yytext =%s\n",tipo,yytext);
	//arvore_pilha_imprime(pilha_arvore);
}
| chamada_funcao
{
	//printf("funcao = %s",funcao);
	func = busca(tab_funcoes,funcao,escopo);
	pilha_insere(pilha_exp,get_retorno(func));
	if(pilha_verifica_compatibilidade(pilha_exp)) {
	}
	else {
		printf("Erro semantico na linha %d. Incompatibilidade de tipos na expressão.\n", num_linha);
		exit(0);
	}
	func = inicializa();
	qtd_parametros=0;
	
	//pilha_arvore = insere_pilha(pilha_arvore,cria_arvore("funcao",funcao));
	
}
| chamada_funcao_interna
{
	//printf("aqui!\n");
	func = busca(tab_funcoes,funcao,escopo);
	pilha_insere(pilha_exp,get_retorno(func));
	if(pilha_verifica_compatibilidade(pilha_exp)) {
	}
	else {
		printf("Erro semantico na linha %d. Incompatibilidade de tipos na expressão.\n", num_linha);
		exit(0);
	}
	func = inicializa();
	qtd_parametros=0;
	//printf("aqui!!!!!\n");
	//arvore_imprime
	//pilha_arvore = insere_pilha(pilha_arvore,cria_arvore("funcao",funcao));
	//arvore_pilha_imprime(pilha_arvore);
}
;

valor_primitivo
: token_literal
| token_inteiro
| token_real
| token_caractere
| token_pr_verdadeiro
| token_pr_falso
;

chamada_funcao
: token_identificador token_abre_parenteses paramentros_chamada_funcao token_fecha_parenteses 
{
	func = busca(tab_funcoes,funcao,escopo);
	if(qtd_parametros != get_aridade(func)){
		printf("Erro semantico na linha %d. Quantidade de parametros invalidos.\n",num_linha);
		exit(0);
	}
	func = inicializa();
	if(!verifica_tipo_parametros_funcao(tab_funcoes,funcao,v)){
		printf("Erro semantico na linha %d. Tipo dos parametros invalidos.\n",num_linha);
		exit(0);
	}
	//nao foi testado ainda
	for(i=0;i<qtd_parametros;i++){
		pilha_arvore = remove_pilha(pilha_arvore);
	}
	set_valor_arvore(arvore_funcao,funcao);
	pilha_arvore = insere_pilha(pilha_arvore,arvore_funcao);
	arvore_funcao = inicializa_arvore();
	arvore_funcao = cria_arvore("funcao","-1");
	
	v = inicializa();
	
}
| token_identificador token_abre_parenteses token_fecha_parenteses 
{
	func = busca(tab_funcoes,funcao,escopo);
	if(qtd_parametros != get_aridade(func)){
		printf("Erro semantico na linha %d. Quantidade de parametros invalidos.\n",num_linha);
		exit(0);
	}
	func = inicializa();
	if(!verifica_tipo_parametros_funcao(tab_funcoes,funcao,v)){
		printf("Erro semantico na linha %d. Tipo dos parametros invalidos.\n",num_linha);
		exit(0);
	}
	//nao foi testado ainda
	for(i=0;i<qtd_parametros;i++){
		pilha_arvore = remove_pilha(pilha_arvore);
	}
	set_valor_arvore(arvore_funcao,funcao);
	pilha_arvore = insere_pilha(pilha_arvore,arvore_funcao);
	arvore_funcao = inicializa_arvore();
	arvore_funcao = cria_arvore("funcao","-1");
	
	v = inicializa();
}
;

chamada_funcao_interna
: token_pr_imprima token_abre_parenteses paramentros_chamada_funcao token_fecha_parenteses token_ponto_virgula
{
	//busca a funcao imprima na tabela de funcoes e verifica se a quantidade de parametros que a funcao esta recebendo, eh a mesma que foi declarada na tabela, em funcoes o escopo precisa ser colocado mas nao eh usado
	func = busca(tab_funcoes,"imprima",escopo);
	if (qtd_parametros != get_aridade(func)){
		printf("Erro semantico na linha %d. Quantidade de parametros invalidos.\n",num_linha);
		exit(0);
	}
	
	for(i=0;i<qtd_parametros;i++){
		pilha_arvore = remove_pilha(pilha_arvore);
	}
	strcpy(funcao,"imprima");
	set_valor_arvore(arvore_funcao,"imprima");
	pilha_arvore = insere_pilha(pilha_arvore,arvore_funcao);
	arvore_funcao = inicializa_arvore();
	arvore_funcao = cria_arvore("funcao","-1");
	v = inicializa();
	qtd_parametros =0;	
}
| token_pr_leia token_abre_parenteses paramentros_chamada_funcao token_fecha_parenteses token_ponto_virgula
{
	//busca a funcao imprima na tabela de funcoes e verifica se a quantidade de parametros que a funcao esta recebendo, eh a mesma que foi declarada na tabela
	func = busca(tab_funcoes,"leia",escopo);
	if (qtd_parametros != get_aridade(func)){
		printf("Erro semantico na linha %d. Quantidade de parametros invalidos.\n",num_linha);
		exit(0);
	}
	
	for(i=0;i<qtd_parametros;i++){
		pilha_arvore = remove_pilha(pilha_arvore);
	}
	strcpy(funcao,"leia");
	set_valor_arvore(arvore_funcao,"leia");
	pilha_arvore = insere_pilha(pilha_arvore,arvore_funcao);
	arvore_funcao = inicializa_arvore();
	arvore_funcao = cria_arvore("funcao","-1");
	v = inicializa();
	qtd_parametros =0;	
}
| token_pr_leia_ln token_abre_parenteses paramentros_chamada_funcao token_fecha_parenteses token_ponto_virgula
{
	//busca a funcao imprima na tabela de funcoes e verifica se a quantidade de parametros que a funcao esta recebendo, eh a mesma que foi declarada na tabela
	func = busca(tab_funcoes,"leia_ln",escopo);
	if (qtd_parametros != get_aridade(func)){
		printf("Erro semantico na linha %d. Quantidade de parametros invalidos.\n",num_linha);
		exit(0);
	}
	
	for(i=0;i<qtd_parametros;i++){
		pilha_arvore = remove_pilha(pilha_arvore);
	}
	strcpy(funcao,"leia_ln");
	set_valor_arvore(arvore_funcao,"leia_ln");
	pilha_arvore = insere_pilha(pilha_arvore,arvore_funcao);
	arvore_funcao = inicializa_arvore();
	arvore_funcao = cria_arvore("funcao","-1");
	v = inicializa();
	qtd_parametros =0;	
}
| token_pr_imprima_ln token_abre_parenteses paramentros_chamada_funcao token_fecha_parenteses token_ponto_virgula
{
	//busca a funcao imprima na tabela de funcoes e verifica se a quantidade de parametros que a funcao esta recebendo, eh a mesma que foi declarada na tabela
	func = busca(tab_funcoes,"imprima_ln",escopo);
	if (qtd_parametros != get_aridade(func)){
		printf("Erro semantico na linha %d. Quantidade de parametros invalidos.\n",num_linha);
		exit(0);
	}
	
	for(i=0;i<qtd_parametros;i++){
		pilha_arvore = remove_pilha(pilha_arvore);
	}
	strcpy(funcao,"imprima_ln");
	set_valor_arvore(arvore_funcao,"imprima_ln");
	pilha_arvore = insere_pilha(pilha_arvore,arvore_funcao);
	arvore_funcao = inicializa_arvore();
	arvore_funcao = cria_arvore("funcao","-1");
	v = inicializa();
	qtd_parametros =0;	
}
| token_pr_maximo token_abre_parenteses paramentros_chamada_funcao token_fecha_parenteses 
{
	//busca a funcao imprima na tabela de funcoes e verifica se a quantidade de parametros que a funcao esta recebendo, eh a mesma que foi declarada na tabela
	func = busca(tab_funcoes,"maximo",escopo);
	if (qtd_parametros != get_aridade(func)){
		printf("Erro semantico na linha %d. Quantidade de parametros invalidos.\n",num_linha);
		exit(0);
	}
	strcpy(funcao,"maximo");
	if(!verifica_tipo_parametros_funcao(tab_funcoes,funcao,v)){
		printf("Erro semantico na linha %d. Tipo dos parametros invalidos.\n",num_linha);
		exit(0);
	}
	
	for(i=0;i<qtd_parametros;i++){
		pilha_arvore = remove_pilha(pilha_arvore);
	}
	set_valor_arvore(arvore_funcao,"maximo");
	pilha_arvore = insere_pilha(pilha_arvore,arvore_funcao);
	arvore_funcao = inicializa_arvore();
	arvore_funcao = cria_arvore("funcao","-1");
	v = inicializa();
	qtd_parametros =0;	
}
| token_pr_minimo token_abre_parenteses paramentros_chamada_funcao token_fecha_parenteses 
{
	//busca a funcao imprima na tabela de funcoes e verifica se a quantidade de parametros que a funcao esta recebendo, eh a mesma que foi declarada na tabela
	func = busca(tab_funcoes,"minimo",escopo);
	if (qtd_parametros != get_aridade(func)){
		printf("Erro semantico na linha %d. Quantidade de parametros invalidos.\n",num_linha);
		exit(0);
	}
	strcpy(funcao,"minimo");
	if(!verifica_tipo_parametros_funcao(tab_funcoes,funcao,v)){
		printf("Erro semantico na linha %d. Tipo dos parametros invalidos.\n",num_linha);
		exit(0);
	}
	
	for(i=0;i<qtd_parametros;i++){
		pilha_arvore = remove_pilha(pilha_arvore);
	}
	set_valor_arvore(arvore_funcao,"minimo");
	pilha_arvore = insere_pilha(pilha_arvore,arvore_funcao);
	arvore_funcao = inicializa_arvore();
	arvore_funcao = cria_arvore("funcao","-1");
	v = inicializa();
	qtd_parametros =0;	
}
| token_pr_media token_abre_parenteses paramentros_chamada_funcao token_fecha_parenteses 
{
	//busca a funcao imprima na tabela de funcoes e verifica se a quantidade de parametros que a funcao esta recebendo, eh a mesma que foi declarada na tabela
	//printf("aquia!!\n");
	func = busca(tab_funcoes,"media",escopo);
	
	if (qtd_parametros != get_aridade(func)){
		printf("Erro semantico na linha %d. Quantidade de parametros invalidos.\n",num_linha);
		exit(0);
	}
		
	strcpy(funcao,"media");
	if(!verifica_tipo_parametros_funcao(tab_funcoes,funcao,v)){
		printf("Erro semantico na linha %d. Tipo dos parametros invalidos.\n",num_linha);
		exit(0);
	}
	//arvore_imprime(arvore_funcao);
	for(i=0;i<qtd_parametros;i++){
		pilha_arvore = remove_pilha(pilha_arvore);
	}
	
	qtd_parametros =0;
	set_valor_arvore(arvore_funcao,"media");
	pilha_arvore = insere_pilha(pilha_arvore,arvore_funcao);
	arvore_funcao = inicializa_arvore();
	arvore_funcao = cria_arvore("funcao","-1");
	v = inicializa();
}
;

paramentros_chamada_funcao
: paramentros_chamada_funcao token_virgula expressao
{
	//printf("aquiasd1.1\n");
	//printf("funcao = %s\n",identificador);
	arvore_funcao = insere_arvore(arvore_funcao,"variavel",identificador);
	//conta quantos parametros a funcao esta recebendo
	l = busca(tab_variaveis,identificador,escopo);
	v = insere_variavel_lista1(v,identificador,get_tipo(l),get_escopo(l),get_usada(l));
	qtd_parametros++;
}
| expressao
{
	//printf("aquiasd1.2\n");
	//conta quantos parametros a funcao esta recebendo
	l = busca(tab_variaveis,identificador,escopo);
	v = insere_variavel_lista1(v,identificador,get_tipo(l),get_escopo(l),get_usada(l));
	qtd_parametros++;
	//printf("aquiasd1.4\n");
	arvore_funcao = insere_arvore(arvore_funcao,"variavel",identificador);
	//printf("aquiasd1.3\n");
	//printf("funcao = %s\n",identificador);
	//printf("aquiasd1.2\n");
}
;

declaracao_funcoes
: declaracao_funcoes declaracao_funcao
| declaracao_funcao
;

declaracao_funcao
: token_pr_funcao token_identificador paramentros_funcao_parenteses token_dois_pontos tipo_primitivo bloco_inicio_funcao token_pr_fim_funcao
{
	tipo_parametros[qtd_parametros] = -1;
	func = busca(tab_funcoes, funcao, escopo);
	if(func) {
		printf("Erro semantico na linha %d. Função redeclarada.\n",num_linha);
		exit(0);
	}
	tab_funcoes = insere_funcao(tab_funcoes,funcao,retorno_func,qtd_parametros);
	tab_funcoes = insere_parametro_funcao(tab_funcoes,funcao,tipo_parametros);
	qtd_parametros=0;
//	func = inicializa();
	
}
| token_pr_funcao token_identificador paramentros_funcao_parenteses bloco_inicio_funcao token_pr_fim_funcao
{
	tipo_parametros[0] = -1;
	tab_funcoes = insere_funcao(tab_funcoes,funcao,retorno_func,0);
	tab_funcoes = insere_parametro_funcao(tab_funcoes,funcao,tipo_parametros);
}
;

paramentros_funcao_parenteses
: token_abre_parenteses paramentros_funcao token_fecha_parenteses
{
	for(i=0;i<2000;i++){
		expressao[i]='\0';
	}
}
| token_abre_parenteses token_fecha_parenteses
{
	for(i=0;i<2000;i++){
		expressao[i]='\0';
	}
}
;

paramentros_funcao
: paramentros_funcao token_virgula paramentro_funcao
| paramentro_funcao
;

paramentro_funcao
: token_identificador token_dois_pontos tipo_primitivo
{
	insere_variavel(tab_variaveis,identificador,tipo,0,escopo);
	tipo_parametros[qtd_parametros] = tipo;
	qtd_parametros++;
}
| token_identificador token_dois_pontos tipo_matriz
{
	tipo_parametros[qtd_parametros] = tipo;
	qtd_parametros++;
}
;



%%

#include "lex.yy.c"

main(){
	
	tab_variaveis = inicializa_hash();
	var = inicializa();
	
	tab_funcoes = inicializa_hash();
	func = inicializa();
	//insere as funcoes primitivas da linguagem
	insere_funcao(tab_funcoes,"leia",-1,1);
	tipo_parametros[0]=2;
	tipo_parametros[1]=-1;
	insere_parametro_funcao(tab_funcoes,"leia",tipo_parametros);	
	insere_funcao(tab_funcoes,"leia_ln",-1,1);
	insere_parametro_funcao(tab_funcoes,"leia_ln",tipo_parametros);
	insere_funcao(tab_funcoes,"imprima",-1,1);
	insere_parametro_funcao(tab_funcoes,"imprima",tipo_parametros);
	insere_funcao(tab_funcoes,"imprima_ln",-1,1);
	insere_parametro_funcao(tab_funcoes,"imprima_ln",tipo_parametros);
	insere_funcao(tab_funcoes,"-",0,2);
	tipo_parametros[0]=0;
	tipo_parametros[1]=0;
	tipo_parametros[2]=-1;
	insere_parametro_funcao(tab_funcoes,"-",tipo_parametros);
	insere_funcao(tab_funcoes,"*",0,2);
	insere_parametro_funcao(tab_funcoes,"*",tipo_parametros);
	insere_funcao(tab_funcoes,"/",0,2);
	insere_parametro_funcao(tab_funcoes,"/",tipo_parametros);
	insere_funcao(tab_funcoes,"^",0,2);
	insere_parametro_funcao(tab_funcoes,"^",tipo_parametros);
	insere_funcao(tab_funcoes,"maximo",0,2);
	insere_parametro_funcao(tab_funcoes,"maximo",tipo_parametros);
	insere_funcao(tab_funcoes,"minimo",0,2);
	insere_parametro_funcao(tab_funcoes,"minimo",tipo_parametros);
	insere_funcao(tab_funcoes,"media",0,2);
	insere_parametro_funcao(tab_funcoes,"media",tipo_parametros);
	
	pilha_exp = pilha_constroi();
	//arvore
	arvore_final = inicializa_arvore();
	pilha_arvore = inicializa_pilha();
	arvore_funcao = cria_arvore("funcao","-1");
	
	//for(aux=a; aux!=NULL; aux=get_prox(aux)){
	//	arvore_imprime(aux);
	//}
	yyparse();
}

/* rotina de erro */
yyerror (){
	printf("Erro! Linha %d\n", num_linha);
}
