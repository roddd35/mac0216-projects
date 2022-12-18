;   "Operações sobre primos" NASM, 64bits
global _start
section .text ;aqui fica o código fonte
_start: ;início do código
            ;leitura do MODO DE EXECUÇÃO
            mov edi, STDIN
            mov esi, buffer         ;o conteudo lido será armazenado em 'buffer'
            mov edx, 256            ;ler 256 bytes
            mov eax, 0              ;executa a leitura
            syscall                 ;chamada do sistema para leitura

            call ascii_to_bin       ;converter a entrada ascii para binário
            mov bl, [NUM]
            mov [modo], bl          ;passar o modo lido para a variável MODO

            ;leitura do número de entrada
            mov bl, 0               ;zerar o buffer pra fazer uma entrada novamente
            mov [buffer], bl
            mov [NUM], bl
            mov edi, STDIN
            mov esi, buffer         ;o conteudo lido será armazenado em 'buffer'
            mov edx, 256            ;ler 256 bytes
            mov eax, 0              ;executa a leitura
            syscall                 ;chamada do sistema para leitura  
            mov r14d, eax

            call ascii_to_bin       ;converter a entrada ascii para binário
            
            ;executar o código
            mov bl, 0
            cmp bl, [modo]          ;se o modo for 0, imprimir próximo primo
            je call_prox
            jmp call_mult


call_prox: call prox_primo ;função intermediária para fazer um "CALL CONDICIONAL"
           call bin_to_ascii

call_mult: call loopMenor  ;função intermediária para fazer um "CALL CONDICIONAL" 
           mov r12d, [J]
           mov [NUM], r12d
           call bin_to_ascii
           mov eax, 0
           mov r12d, [I]
           mov [NUM], r12d
           call bin_to_ascii
           jmp fim

return: ret                ;subrotina responsavel apenas por fazer um "return condicional"

;INÍCIO DA FUNÇÃO ascii_to_bin -> dado um número na entrada, converte essa String para o formato binário, para realizar contas
ascii_to_bin:
            sub eax, 1              ;a leitura lê 1 dígito a mais, então subtraímos 1 para ler apenas a quantidade de dígitos desejada
            mov r8d, eax            ;guardar o valor de dígitos em um registrador, para reutilizar EAX
            mov ecx, 0
loopA:    
            ;descobrir qual valor numérico corresponde
            mov eax, 10
            mov ebx, [NUM] 
            mul ebx                 ;multiplica 10 x NUM -> primeira execução: 10*0
            mov bl, [buffer+ecx]    ;usar BL como intermediário para não gerar dígitos a mais indesejados
            mov [aux], bl
            add eax, [aux]          ;adiciona o número de EBX
            sub eax, '0'            ;subtrai por 48, para alcançar o valor do binário correspondente ao ASCII
            mov [NUM], eax
            jmp proxA

proxA:      inc ecx
            cmp ecx, r8d            ;avança o loop
            jl loopA

            ret
;FIM DA FUNÇÃO ASCII_TO_BIN

;INÍCIO DA FUNÇÃO BIN_TO_ASCII -> Dado um número binário, converter ele para ASCII e executar sua impressao
bin_to_ascii:
            xor eax, eax
            xor edx, edx
            mov ecx, 0
            mov eax, [NUM]
            mov ebx, 10
empilha:       
            div ebx                 ;NUM / 10 -> pega o último dígito
            mov r10d, eax           ;R10D irá salvar o quociente
            inc ecx
            push rdx
            xor edx, edx
            xor eax, eax
            mov eax, r10d
            cmp eax, 0
            jg empilha              ;refazer o loop enquanto NUM / 10 != 0

            mov [aux], ecx          ;mover o contador para AUX pois ele se perde durante a execução de 'desempilha'
            mov r12d, 0
desempilha:      
            inc r12d
            pop rbx                 ;desempilhar cada valor da pilha
            add ebx, '0'            ;soma 48 ao número desempilhado, para conseguir o correspondente ascii ao dígito
            mov [res], ebx          ;res é a variável que será impressa na tela do usuário

            ;saída
            mov rdi, STDOUT
            mov rsi, res            
            mov rdx, 1
            mov rax, 1              ;executa a impressão
            syscall                 ;chamada do sistema para saída
            cmp r12d, [aux]
            jne desempilha          ;desempilhar até que o contador de "desempilha" seja igual ao de "empilha"

            ;imprimir uma 'quebra de linha'
            mov r12, 0x0A
            mov [aux], r12 

            mov rdi, STDOUT
            mov rsi, aux
            mov rdx, rax
            mov rax, 1              ;executa a impressão
            syscall                 ;chamada do sistema para saída
            ret
;FIM DA FUNÇÃO BIN_TO_ASCII            

;INÍCIO DA FUNÇÃO EH_PRIMO -> Dado um número NUM, verifica se esse número é primo ou não
eh_primo:
            mov bl, 0
            mov [PRIMO], bl
            mov eax, [NUM]
            cmp eax, 2
            je primo
            mov ecx, 2              ;inicia o contador em 2
loop:       xor edx, edx            ;limpar o valor de EDX antes de fazer qualquer divisao
            mov eax, [NUM]          ;passa o valor de entrada para o EAX (NUM = 31)
            mov ebx, ecx
            div ebx                 ;divide entrada(EAX) / contador(EBX), resto em RDX
            mov eax, 0
            cmp edx, eax            ;se o resto for 0 (não é primo), encerra o programa
            je return
            jne prox

prox:       mov ebx, ecx
            mov eax, ecx
            mul eax                 ;eleva ebx ao quadrado, para fazer a verificação (div*div <= numero)
            inc ecx
            cmp eax, [NUM]
            jle loop                ;continuar o laço se a raiz não for maior
            jmp primo

primo:      mov rbx, 1
            mov [PRIMO], rbx        ;a função devolve na variável PRIMO os valores 0 (não é primo) ou 1 (é primo)

            ret
;FIM DA FUNÇÃO EH_PRIMO            

;INÍCIO DA FUNÇÃO PROX_PRIMO -> calcula o primeiro primo imediatamente após o número de entrada
prox_primo: jmp loopProx

loopProx:   mov eax, 1
            add [NUM], eax          ;incrementar o valor da variável onde está a entrada
            call eh_primo           ;verificar se o número é primo
            mov ebx, 1
            cmp [PRIMO], ebx        ;se PRIMO não tiver valor 1 (não é primo), executar o loop novamente
            jne loopProx
            ret

;FIM DA FUNÇÃO PROX_PRIMO                    

;INÍCIO DA FUNÇÃO "MULTIPLO DE PRIMOS" -> verifica (e imprime) se um número é múltiplo de dois números primos

increment:  ;função de incrementação de J
            mov eax, [J]
            add eax, 1
            mov [J], eax
            mov eax, 0
            mov [divide], eax
            jmp loopMenor       ;incrementa J e roda o loop novamente 

loopMenor:  ;em assembly, temos apenas um loop, diferente de C, por conta dos comandos JUMP
            mov eax, [J]
            mov ebx, [J]
            mul eax                 ;EAX = J*J
            mov ebx, 0
            mov [divide], ebx   
            cmp eax, [NUM]
            jle checkDiv
            jmp fim

checkDiv:   ;verifica se !divide para continuar o loop
            mov eax, 0
            cmp eax, [divide]
            je condition        ;se !divide, chamar a proxima função
            jmp increment


condition:  ;verifica se NUM % J == 0
            mov eax, [NUM]
            mov ebx, [J]
            div ebx             ;EAX = EAX / EBX, resto em EDX
            cmp edx, 0          ;se J é múltiplo de NUM, verificar se J é primo, senão incrementar J e rodar novamente
            je call_PRIMO
            jne increment

call_PRIMO: mov r13, [NUM]
            mov eax, [J]
            mov [NUM], eax
            call eh_primo
            mov ebx, 1
            cmp [PRIMO], ebx    ;se for primo, mudar DIVIDE para 1, senão incrementar J
            jne increment
            mov [NUM], r13
            mov [divide], ebx
            jmp segundo_div

segundo_div:
            mov ebx, 0
            mov [PRIMO], ebx    ;reinicia o valor da variavel PRIMO pois iremos utilizar essa condição novamente
            cmp ebx, [divide]
            je quebra_loop
            jmp ver_segundo

quebra_loop:
            mov eax, 0
            mov [NUM], eax
            jmp fim

ver_segundo:
            mov eax, [NUM]
            mov ebx, [J]
            div ebx             ;NUM / J, resultado fica em EAX
            mov r13, [NUM]
            mov [NUM], eax
            call eh_primo       ;verificar se o resultado de NUM / J é primo
            mov ebx, 1
            mov [NUM], r13
            cmp [PRIMO], ebx
            je ver_j_primo      ;verificar (novamente) se J é primo
            jmp increment

ver_j_primo:
            mov r13, [NUM]
            mov ebx, 0
            mov [PRIMO], ebx
            mov ecx, [J]
            mov [NUM], ecx      ;verificar se J é primo
            call eh_primo
            mov ebx, 1
            cmp [PRIMO], ebx    ;se for primo
            je div_1
            jmp fim

div_1:  
            mov [NUM], r13       ;recupera o valor inicial de NUM
            mov eax, [NUM]
            mov ebx, [J]
            div ebx
            mov [I], eax        ;eax possui o valor de NUM / J, que será passado para I
            xor rax, rax
            xor rbx, rbx
            mov rbx, [J]
            mov rax, [I]
            mul rbx
            cmp rax, [NUM]
            jne fim         ;terminar o programa caso o produto dos números encontrados não seja igual
            jmp return
            
;FIM DA FUNÇÃO "MÚLTIPLO DE PRIMOS"



;termina a execução
fim:    mov rdi, 0
        mov rax, 60
        syscall

;as variáveis I e J representam  os dois possíveis primos múltiplos da entrada do usuário
section .data ;aqui ficam os dados/variáveis
STDIN:      EQU 0
STDOUT:     EQU 1
STDERR:     EQU 2
J:          dq 2
divide:     dq 0
PRIMO:      db 0


section .bss ;aqui ficam os dados/variáveis não inicializados
guardaNUM:  resb 256
I:          resd 256
modo:       resb 256
NUM:        resd 256
buffer:     resd 256
aux:        resd 256
res:        resd 256

;   nasm -f elf64 epS.s -o epS.o para compilar
;   ld -s -o epS epS.o 
;   ./epS
;   ndisasm arquivo.o -> executar um desmontador
;   gdb arquivo.o # ou o executavel -> executar um depurador, incluir -g no nasm e não usar -s no ld
;   x/5cb &VARIAVEL para ver o valor de uma variavel no gdb