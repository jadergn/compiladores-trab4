%{
#include <stdio.h>
#include <string.h>
#include "hash.h"
#include "arvore.h"
#include "atribuicao.h"
int i = 0;
int num_linha = 1;
int escopo;
char c;
char comentario[2000];
char identificador[100];
char funcao[100];
char expressao[2000];
int tipo;

%}

%%



algoritmo 		{return token_pr_algoritmo;}
variáveis 		{return token_pr_variaveis;}
fim-variáveis 		{return token_pr_fim_variaveis;}
início			{return token_pr_inicio;}
fim 			{return token_pr_fim;}
inteiro 		{tipo = 0; return token_pr_inteiro;}
inteiros 		{return token_pr_inteiros;}
caractere 		{tipo = 1; return token_pr_caractere;}
caracteres 		{return token_pr_caracteres;}
real 			{tipo = 3; return token_pr_real;}
reais 			{return token_pr_reais;}
literal 		{tipo = 2; return token_pr_literal;}
literais 		{return token_pr_literais;}
lógico 			{return token_pr_logico;}
lógicos 		{return token_pr_logicos;}
matriz 			{return token_pr_matriz;}
se 			{return token_pr_se;}
então 			{return token_pr_entao;}
senão 			{return token_pr_senao;}
fim-se 			{return token_pr_fim_se;}
para 			{return token_pr_para;}
de 			{return token_pr_de;}
até 			{return token_pr_ate;}
faça 			{return token_pr_faca;}
fim-para 		{return token_pr_fim_para;}
passo 			{return token_pr_passo;}
enquanto 		{return token_pr_enquanto;}
fim-enquanto 		{return token_pr_fim_enquanto;}
imprima 		{return token_pr_imprima;}
imprima_ln 		{return token_pr_imprima_ln;}
leia 			{return token_pr_leia;}
leia_ln			{return token_pr_leia_ln;}
maximo			{return token_pr_maximo;}
minimo			{return token_pr_minimo;}
media			{return token_pr_media;}
função 			{escopo = 0;return token_pr_funcao;}
fim-função		{escopo = 1;return token_pr_fim_funcao;}
retorne 		{return token_pr_retorne;}
verdadeiro		{return token_pr_verdadeiro;}
falso			{return token_pr_falso;}
e			{return token_pr_e;}
ou			{return token_pr_ou;}
	
escolha			{return token_pr_escolha;}
caso			{return token_pr_caso;}	
fim-escolha		{return token_pr_fim_escolha;}
default			{return token_pr_default;}


("+"|"-")?[0-9]+ |
0(x|X)[0-9a-fA-F]+ |
0(c|C)[0-7]+ |
0(b|B)[0-1]+ 				{tipo =0; return token_inteiro;}
("+"|-)?[0-9]"."[0-9]+ 		{tipo =3; return token_real;}
\'([^\\]|\\.)?\'			{tipo =1;return token_caractere;}
\"([^\"\\\n\r]|\\.)*\"		{tipo =2; return token_literal;}
"+"							{return token_soma;}
"-"							{return token_subtracao;}
"\/"						{return token_divisao;}
"\*"						{return token_multiplicacao;}
"++"						{return token_incrementador;}
"%"							{return token_modulo;}
">"							{return token_maior;}
">="						{return token_maior_igual;}
"<"							{return token_menor;}
"<="						{return token_menor_igual;}
"="							{return token_igual;}
"<>"						{return token_diferente;}
"&&"						{return token_e;}
"&"							{return token_e_bit;}
"||"						{return token_ou;}
"|"							{return token_ou_bit;}
"^"							{return token_xor_bit;}
"!"							{return token_nao;}
"~"							{return token_til;}
"\""						{return token_aspas_dupla;}
"'"							{return token_aspas_simples;}
"("							{strcpy(funcao,identificador); return token_abre_parenteses;}
")"							{return token_fecha_parenteses;}
"{"							{return token_abre_chaves;}
"}"							{return token_fecha_chaves;}
"["							{return token_abre_colchetes;}
"]"							{return token_fecha_colchetes;}
"#"							{return token_tralha;}
"\\"						{return token_contra_barra;}
"."							{return token_ponto;}
","							{return token_virgula;}
";"							{return token_ponto_virgula;}
":"							{return token_dois_pontos;}
":="						{return token_atribuicao;}
[a-zA-Z_][a-zA-Z0-9_]*		{
	
	strcpy(identificador,yytext);	
	expressao[strlen(expressao)] = '-';
	i=0;
	c = yytext[i];
	while(c!='\0'){
		expressao[strlen(expressao)] = c;
		i++;
		c = yytext[i];
	}
	expressao[strlen(expressao)]='\0';
	return token_identificador;
} 

\/\/[^\n]*\n {num_linha++;}
\/\*[^(\*\/)]*\*\/ {
	strcpy(comentario,yytext);
	for(i=0; i<strlen(comentario); i++){
		if(comentario[i] == '\n')
			num_linha++;	
	}
}

[ \t]	;
\n	{num_linha++;}

.							{return token_desconhecido;}

%%
