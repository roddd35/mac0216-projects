#include <stdio.h>

/*!
    \file propriedadesnumericas.h
*/

/*! \fn int ehPar(long long int)
    \param num numero de entrada para verificacao
    \brief Uso: par[i] = ehPar(V[i])
    \brief Essa função verifica se um número é par ou ímpar
    \return retorno: (int) devolve 1, se o número num for par, 0 caso seja ímpar
*/

int ehPar(long long int num);

/*! \fn ehPrimo(long long int num)
    \param num numero de entrada para verificacao
    \brief Uso: primo[i] = ehPrimo(V[i])
    \brief Essa função verifica se um número é primo
    \return retorno: (int) devolve 1, se o número num for primo, 0 caso não seja primo
*/
int ehPrimo(long long int num);

/*! \fn int ehQuadradoPerfeito(long long int num)
    \param num numero de entrada para verificacao
    \brief Uso: ehQuadrado[i] = ehQuadradoPerfeito(V[i])
    \brief Essa função verifica se um número é quadrado perfeito, isso é, se ele possui uma raiz quadrada perfeita
    \brief É chamada para cada número aleatório gerado na função criaVetorAleatorio.
    \return retorno: (int) devolve 1, se o número num for quadrado perfeito, 0 caso contrário
*/

int ehQuadradoPerfeito(long long int num);

/*! \fn int ehCuboPerfeito(long long int num)
    \param num numero de entrada para verificacao
    \brief Uso: ehCubo[i] = ehCuboPerfeito(V[i])
    \brief Essa função verifica se um número é cubo perfeito, isso é, se ele possui uma raiz cubica perfeita
    \brief É chamada para cada número aleatório gerado na função criaVetorAleatorio.
    \return retorno: (int) devolve 1, se o número num for cubo perfeito, 0 caso contrário
*/

int ehCuboPerfeito(long long int num);

/*! \fn int ehFibonacci(long long int num)
    \param num numero de entrada para verificacao
    \brief Uso: ehFib[i] = ehFibonacci(V[i])
    \brief Essa função verifica se um número pertence à sequência de Fibonacci
    \brief É chamada para cada número aleatório gerado na função criaVetorAleatorio.
    \return retorno: (int) devolve 1, se o número num pertencer a sequência de Fibonacci, 0 caso contrário
*/
int ehFibonacci(long long int num);

/*! \fn int ehFatorial(long long int num)
    \param num numero de entrada para verificacao
    \brief Uso: ehFat[i] = ehFatorial(V[i])
    \brief Essa função verifica se um número é produto de algum fatorial.
    \brief É chamada para cada número aleatório gerado na função criaVetorAleatorio.
    \return retorno: (int) devolve 1, se o número num for algum produto fatorial, 0 caso contrário
*/
int ehFatorial(long long int num);