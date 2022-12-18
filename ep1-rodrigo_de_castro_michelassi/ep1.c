#include <stdio.h>

int eh_primo(int n);
void prox_primo(int n);
void mult_primo(int n);

int main(){
    int modo = -1, num; /*modo é inicializado com -1 para não dar erro no while*/

    while(modo != 0 && modo != 1){
        scanf("%d %d", &modo, &num);
    }
    
    if(modo == 0){
        prox_primo(num + 1);
    }
    else{
        mult_primo(num);
    }

    return 0;
}

int eh_primo(int n){
    int i;

    for(i = 2; i * i <= n; i++){
        if (n % i == 0){
            return 0;
        }
    }
    return 1;
}

void prox_primo(int n){
    while(!eh_primo(n)){
        n++;
    }
    printf("%d\n", n);
}

void mult_primo(int n){
    long int i = 2, j = 2, divide = 0; 
    /*i e j serão os divisores primos de n, guarda é uma variável auxiliar para guardar um valor que será perdido*/
    while (j * j <= n){
        while (j * j <= n && !divide){
            if(n % j == 0 && eh_primo(j))
                divide = 1;
            else 
                j++;
        }
        if (!divide)
            n = 0; /*quebrar o laço caso não tenha nenhum numero primo divisivel*/
        else {
            if (eh_primo(n / j) && eh_primo(j)){
                i = n / j;
                if (i * j == n)
                    printf("%ld %ld\n", j, i);
                n = 0;
            }
            else
                j++;
        }
    }
}