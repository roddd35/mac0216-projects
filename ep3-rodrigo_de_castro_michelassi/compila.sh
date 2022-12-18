#!/bin/bash

verErro(){
    if [ $? -ne 0 ]; then
        exit 1
    fi
}

# compilar e gerar a biblioteca estática
gcc -Wall -c -o propriedadesnumericas.o propriedadesnumericas.c
verErro
ar -rcv libpropriedadesnumericas.a propriedadesnumericas.o
verErro
ar -t libpropriedadesnumericas.a
verErro

# compilar e gerar a biblioteca dinâmica
gcc -c -fPIC -o vetoraleatorio.o vetoraleatorio.c
verErro
gcc -o libvetoraleatorio.so -shared vetoraleatorio.o
verErro

# compilar o programa
export LD_LIBRARY_PATH=/tmp/ep3-rodrigo_de_castro_michelassi:${LD_LIBRARY_PATH}
gcc -Wall -o teste teste.c libpropriedadesnumericas.a -L . -lvetoraleatorio
verErro

doxygen -g
doxygen Doxyfile

./teste

exit 0