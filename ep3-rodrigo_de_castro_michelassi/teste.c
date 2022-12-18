#include <stdio.h>
#include "propriedadesnumericas.h"
#include "vetoraleatorio.h"
// #include "libvetoraleatorio.so"
// #include "libpropriedadesnumericas.a"

void alocaVetores(int tamanho, int *primo, int *par, int *ehQuadrado, int *ehCubo, int *ehFib, int *ehFat);

int main(){
    int semente = 0, tamanho = 0;
    int i, *primo = NULL, *par = NULL, *ehQuadrado = NULL, *ehCubo = NULL, *ehFib = NULL, *ehFat = NULL;
    long long int *V;
    char espaco = ' ';

    scanf("%d %d", &semente, &tamanho);

    V = criaVetorAleatorio(semente, tamanho);
    
    //  alocar vetores
    primo = malloc(sizeof(int) * tamanho);
    par = malloc(sizeof(int) * tamanho);
    ehQuadrado = malloc(sizeof(int) * tamanho);
    ehCubo = malloc(sizeof(int) * tamanho);
    ehFib = malloc(sizeof(int) * tamanho);
    ehFat = malloc(sizeof(int) * tamanho);

    //  chamar as funções das bibliotecas para cada numero do vetor aleatorio gerado
    for (i = 0; i < tamanho; i++){
        primo[i] = ehPrimo(V[i]);
        par[i] = ehPar(V[i]);
        ehQuadrado[i] = ehQuadradoPerfeito(V[i]);
        ehCubo[i] = ehCuboPerfeito(V[i]);
        ehFib[i] = ehFibonacci(V[i]);
        ehFat[i] = ehFatorial(V[i]);
    }

    //  imprimir os resultados
    printf("\n--*-- RESULTADOS --*--");
    for(i = 0; i < tamanho; i++){
        printf("\n");
        printf("\n%7cNúmero%7c| Primo | Par | Quad | Cubo | Fib | Fat\n", espaco, espaco);
        printf("%7lld | %5d | %3d | %4d | %4d | %3d | %4d", V[i], primo[i], par[i], ehQuadrado[i], ehCubo[i], ehFib[i], ehFat[i]);
    }
    
    free(V);
    free(primo);
    free(par);
    free(ehQuadrado);
    free(ehCubo);
    free(ehFib);
    free(ehFat);
    printf("\n\n");
    return 0;
}