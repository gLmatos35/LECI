#include <stdio.h>
#include <unistd.h>
#include <stdint.h>
#include <libgen.h>
#include <stdlib.h>
#include <string.h>

#include "thread.h"

static int counter;
pthread_mutex_t mtx;
pthread_cond_t cnd[2];

void *childThread(void *arg) {
	int thrID = *(int*)arg;

	while(true) {
		mutex_lock(&mtx);

		while(counter % 2 != thrID) {
			cond_wait(&cnd[thrID], &mtx);	// a thread em questao fica em estado de espera até ser a sua vez de decrementar
		}

		counter--;

		printf("Thread %d announces new counter value: %d \n",thrID, counter);

		cond_broadcast(&cnd[ (thrID+1)%2 ]);	// acorda a outra thread
		
		if(counter <= 2) {
			mutex_unlock(&mtx);
			break;
		}

		mutex_unlock(&mtx);
	}

    return NULL;
}

int main (int argc, char *argv[]) {
	do {
		printf("%s","Introduz um valor entre 10 e 20\n");
		scanf("%d",&counter);
	} while (counter < 10 || counter > 20);

	printf("\nValor inicial de counter: %d \n", counter);

	// inicialização das mutex e condition variables
    mutex_init(&mtx, NULL);
    // 2 condiçoes - ser par ou ser impar
    cond_init(&cnd[0],NULL);
    cond_init(&cnd[1],NULL);

    pthread_t thr1, thr2;

	int id[2] = {0,1};
    thread_create(&thr1, NULL, childThread, &id[0]);
    thread_create(&thr2, NULL, childThread, &id[1]);

	thread_join(thr1, NULL);
	thread_join(thr2, NULL);
	// a partir daqui é passado para a funçao de gestao das threads, so quando acabar é que volta a "dar controlo" ao main

	mutex_destroy(&mtx);
	cond_destroy(&cnd[0]);
	cond_destroy(&cnd[1]);

	printf("Both threads have concluded\nFinal value: %d \n", counter);

    return 0;
}