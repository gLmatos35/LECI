# include <stdio.h>
# include <string.h>
# include <stdlib.h>

int main( int argc, char* argv[]) {
    if (strcmp(argv[0], "./xpto")) == 0 {
...
    }
}

// se o argv for xpto imprimir thats all folks
// caso contrario, imprimir o nome do ficheiro/argumento dado