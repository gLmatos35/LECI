#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

#include "delays.h"
#include "process.h"

int main(void)
{
    printf("Counting to 20: \n1 - 10 the child \n11 - 20 the parent\n");
    pid_t ret = pfork();
    
    if (ret == 0) {
        printf("\nI'm the child\n");
        int var1;
        for (var1 = 1; var1 <= 10; var1++) {
            printf("%d\n",var1);
        }
    } else {
        pwait(NULL);

        // int st = wait(NULL)
        // if (st == -1) {
        //     perror("wait");
        //     exit(1);
        // }
        // opção acima é usar o wait em vez do pwait, mas esta alternativa é
        // hardwired, precisamos de verificar se o programa filho está ok e
        // caso contrário agir conforme (neste caso fechamos o programa)
        // nem sempre queremos fechar o programa caso dê erro então ya, usar o 
        // pwait dos stores que já trata disto como deve ser 

        printf("\nI'm the parent\n");
        int var2;
        for (var2 = 11; var2 <= 20; var2++) {
            printf("%d\n",var2);
        }
    }

  return EXIT_SUCCESS;
}

