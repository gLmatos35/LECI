#include <stdio.h>
#include <unistd.h>
#include <stdint.h>
#include <libgen.h>
#include <stdlib.h>
#include <string.h>

#include "thread.h"

static int sharedCounter;
pthread_mutex_t mtx;
pthread_cond_t cvar[2];

void *childThread(void *arg) {

	int thrId = *(int*)arg;

	while (true) {
		mutex_lock(&mtx);

		if(sharedCounter <= 2) {
			mutex_unlock(&mtx);
			break;
		}

		while ((sharedCounter % 2) != thrId) {
			cond_wait(&cvar[thrId], &mtx);
		}

		sharedCounter--;
		printf("Thread %d decremented value - sharedCounter = %d \n",thrId, sharedCounter);

		// cond_broadcast(&((thrId+1)%2));
		cond_broadcast(&cvar[(thrId + 1)%2]);

		mutex_unlock(&mtx);
	}

	return NULL;
}

int main(int argc, char *argv[]) {
	int value;
	do {
		printf("Type value between 10 and 20:\n>> ");
		scanf("%d",&value);
	} while (value < 10 || value > 20);

	sharedCounter = value;

	mutex_init(&mtx, NULL);
	cond_init(&cvar[0], NULL);
	cond_init(&cvar[1], NULL);

	pthread_t thr1, thr2;
	int id[2] = {0,1};

	thread_create(&thr1, NULL, childThread, &id[0]);
	thread_create(&thr2, NULL, childThread, &id[1]);

	thread_join(thr1, NULL);
	thread_join(thr2, NULL);

	cond_destroy(&cvar[0]);
	cond_destroy(&cvar[1]);
	mutex_destroy(&mtx);

	printf("\nBoth threads have ended their execution. Final sharedCounter value: %d\n", sharedCounter);

	return 0;
}
