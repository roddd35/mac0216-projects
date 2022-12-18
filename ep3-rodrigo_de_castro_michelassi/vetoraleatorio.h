#include <stdio.h>
#include <stdlib.h>
/*!
    \file vetoraleatorio.h
*/

/*! \fn long long int * criaVetorAleatorio(int semente, int tamanho)
    \param semente semente para a geração do número aleatório
    \param tamanho número de elementos no vetor aleatório
    \brief Uso: V = criaVetorAleatorio(semente, tamanho);
    \brief Esta função devolve um vetor (ponteiro) preenchido com números aleatórios, em um intervalo pré-definido.
    \brief Esses números gerados serão usados para cálculos posteriores.
    \return retorno: (long long int) devolve um vetor de números aleatórios 64bits, gerado a partir de uma semente com a função "rand()" 
*/

long long int * criaVetorAleatorio(int semente, int tamanho);