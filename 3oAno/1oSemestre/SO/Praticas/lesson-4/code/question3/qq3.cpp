#include <stdio.h>
#include <unistd.h>
#include <stdint.h>
#include <libgen.h>
#include <stdlib.h>
#include <string.h>

#include "thread.h"

static int sharedCnt;
pthread_mutex_t mtx;
pthread_cond_t cnd[2];

void *childThread(void *arg) {


	return 0;
}

int main(int argc, char *argv[]) {
	int value;
	do {
		printf("Type value between 10 and 20:\n>> ");
		scanf("%d",&value);
	} while (value < 10 || value > 20);

	sharedCnt = value;

	

	return 0;
}
