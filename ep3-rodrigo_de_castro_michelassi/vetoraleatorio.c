#include "vetoraleatorio.h"

/*
 *  Função: criaVetorAleatorio
 *  -------------------------
 *  Determina se um número é quadrado perfeito (retorno 1) ou não (retorno 0)
 *  parâmetro 1: (int) 'semente' a ser utilizada para gerar um número aleatório
 *  parâmetro 2: (int) tamanho do vetor aleatório que será gerado 
 *  retorno: (long long int*) o vetor de números aleatórios resultantes
 * 
 *  Essa função recebe uma semente e o tamanho do vetor a ser gerado. Segue os seguintes passos:
 *  (1). Gera um número aleatório a partir da semente com o comando 'srand'
 *  (2). Pede que esse número seja transferido, em cada casa do vetor, em um intervalo determinado em rand()
 *  (3). Retorna o vetor com números aleatorios
*/
long long int * criaVetorAleatorio(int semente, int tamanho){
    int i, a, b;
    long long int * V;

    V = malloc(sizeof(long long int) * tamanho);
    srand(semente);

    for (i = 0; i < tamanho; i++){
        a = rand() % RAND_MAX;
        b = rand() % RAND_MAX;
        V[i] = (long long)a * b;
    }
    return V;
}