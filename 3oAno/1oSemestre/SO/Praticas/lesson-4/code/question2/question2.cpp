#include <stdio.h>
#include <unistd.h>
#include <stdint.h>
#include <math.h>
#include <libgen.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>

#include "utils.h"
#include "thread.h"

void *childThread(void *arg) {
    int N2 = 0;
    int *number = (int*)arg;
    while((N2 < 10) | (N2 > 20)) {
        printf("%s", "Introduz um valor entre 10 e 20\n");
        scanf("%d", &N2);
    }
    while(*number < N2) {
        printf("%d\n", *number);
        *number = *number + 1;
    }
    // thread é a versão mais segura, o pthread é que está com programação defensiva
    thread_exit(NULL);
    return 0;
}

int main (int argc, char *argv[]) {
    int N1 = 0;
    while((N1 < 1) | (N1 > 9)) {
        printf("%s", "Introduz um valor entre 1 e 9\n");
        scanf("%d", &N1);
    }
    pthread_t thr; 
    thread_create(&thr, NULL, childThread, &N1);
    thread_join(thr, NULL);
    while(N1 >= 1) {
        printf("%d\n",N1); 
        N1 = N1 - 1;
    }
    return 0;
}