#include "propriedadesnumericas.h"

/*
 *  Função: ehPar
 *  -------------------------
 *  Determina se um número é par (retorno 1) ou ímpar (retorno 0)
 *  parâmetro 1: (long long int) número a ser verificado
 *  retorno: (int) o resultado da operação
 * 
 *  Essa função recebe um número (long long int) e calcula seu valor nos inteiros módulo 2
 *  recebendo 0, caso esse número seja ímpar, ou 1 caso seja par, e retornando esse valor.
*/
int ehPar(long long int num){
    if(num % 2 == 0)
        return 1;
    return 0;
}

/*
 *  Função: ehPrimo
 *  -------------------------
 *  Determina se um número é primo (retorno 1) ou ímpar (retorno 0)
 *  parâmetro 1: (long long int) número a ser verificado
 *  retorno: (int) o resultado da operação
 * 
 *  Essa função recebe um número (long long int) e busca, até a sua raíz, se possui algum divisor inteiro.
 *  Caso encontre, recebe 0, significando que o número não é ímpar, caso contrário, recebe 1, significando
 *  que o número é primo, e retorna esse valor.
*/
int ehPrimo(long long int num){
    int i = 2, ehPrimo = 1;
    while(i * i <= num){
        if(num % i == 0){
            ehPrimo = 0;
            break;
        }
        i++;
    }
    return ehPrimo;
}

/*
 *  Função: ehQuadradoPerfeito
 *  -------------------------
 *  Determina se um número é quadrado perfeito (retorno 1) ou não (retorno 0)
 *  parâmetro 1: (long long int) número a ser verificado
 *  retorno: (int) o resultado da operação
 * 
 *  Essa função recebe um número (long long int) e busca, de 1 até a sua raíz, se possui uma raiz quadrada exata.
 *  Caso não encontre, recebe 0, significando que o número não é quadrado perfeito, caso contrário, recebe 1, 
 *  significando que o número é quadrado perfeito, e retorna esse valor.
*/
int ehQuadradoPerfeito(long long int num){ 
    int ehQuadrado = 0;
    long long int mul = 1;

    while (mul * mul <= num){
        if(mul * mul == num){
            ehQuadrado = 1;
            break;
        }
        mul++;
    }
    return ehQuadrado;
}

/*
 *  Função: ehCuboPerfeito
 *  -------------------------
 *  Determina se um número é cubo perfeito (retorno 1) ou não (retorno 0)
 *  parâmetro 1: (long long int) número a ser verificado
 *  retorno: (int) o resultado da operação
 * 
 *  Essa função recebe um número (long long int) e busca, de 1 até a sua raíz cúbica, se possui uma raiz cúbica exata.
 *  Caso não encontre, recebe 0, significando que o número não é cubo perfeito, caso contrário, recebe 1, 
 *  significando que o número é cubo perfeito, e retorna esse valor.
*/
int ehCuboPerfeito(long long int num){ 
    int ehCubo = 0;
    long long int mul = 1;

    while(mul * mul * mul <= num){
        if(mul * mul * mul == num){
            ehCubo = 1;
            break;
        }
        mul++;
    }
    return ehCubo;
}

/*
 *  Função: ehFibonacci
 *  -------------------------
 *  Determina se um número está na sequência de Fibonacci (retorno 1) ou não (retorno 0)
 *  parâmetro 1: (long long int) número a ser verificado
 *  retorno: (int) o resultado da operação
 * 
 *  Essa função recebe um número (long long int) e busca, incrementando a sequência de Fibonacci do começo, 
 *  até que seja maior que ele, se esse número está dentro da sequência.
 *  Caso não encontre, recebe 0, significando que o número não está na sequência de Fibonacci, caso contrário, recebe 1, 
 *  significando que o número está na sequência de Fibonacci, e retorna esse valor.
*/
int ehFibonacci(long long int num){
    int eh_fib = 0; 
    long long int anterior = 1, atual = 1, aux;

    if(num == 1) eh_fib = 1;

    while (!eh_fib && atual + anterior <= num){
        if(atual + anterior == num){
            eh_fib = 1;
        }
        aux = atual;
        atual = atual + anterior;
        anterior = aux;
    }
    return eh_fib;
}

/*
 *  Função: ehFatorial
 *  -------------------------
 *  Determina se um número é fatorial de algum número (retorno 1) ou não (retorno 0)
 *  parâmetro 1: (long long int) número a ser verificado
 *  retorno: (int) o resultado da operação
 * 
 *  Essa função recebe um número (long long int) e busca, multiplicando de 1 até superar a entrada, 
 *  se esse número é o fatorial de algum número anterior.
 *  Caso não encontre, recebe 0, significando que o número não é fatorial, caso contrário, recebe 1,
 *  significando que o número é fatorial, e retorna esse valor.
*/
int ehFatorial(long long int num){
    int eh_fat = 0;
    long long int mul = 1, res = 1;
    
    while(res <= num){
        if(res == num){
            eh_fat = 1;
            break;
        }
        res = res * (mul + 1);
        mul++;
    }
    return eh_fat;
}