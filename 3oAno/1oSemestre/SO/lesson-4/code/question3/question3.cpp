#include <stdio.h>
#include <unistd.h>
#include <stdint.h>
#include <libgen.h>
#include <stdlib.h>
#include <string.h>

#include "thread.h"

static int sharedCounter;
pthread_mutex_t mutex;
pthread_cond_t cvar[2];

void* thread_function(void* arg) {
    int me = *(int*)arg;

    while (true) {
        mutex_lock(&mutex);

        while (sharedCounter % 2 != me) {  
            cond_wait(&cvar[me], &mutex);
        }
        
		sharedCounter--;

        printf("Thread %d decremented, new value: %d\n", me, sharedCounter);

        cond_broadcast(&cvar[(me + 1)  % 2]);
        
        if (sharedCounter <= 2) {
            mutex_unlock(&mutex);
            break;
        }

        mutex_unlock(&mutex);
    }

    return NULL;
}

int main(void) {
    int N2;

    do {
        printf("Enter a value between 10 and 20: ");
        if (scanf("%d", &N2) != 1) 
            scanf("%*s");  
    } while (N2 < 10 || N2 > 20);

    sharedCounter = N2;

    mutex_init(&mutex, NULL);
    cond_init(&cvar[0], NULL);
    cond_init(&cvar[1], NULL);

    pthread_t thread1, thread2;

    int id[2] = {0, 1};
    thread_create(&thread1, NULL, thread_function, id);
    thread_create(&thread2, NULL, thread_function, id + 1);

    thread_join(thread1, NULL);
    thread_join(thread2, NULL);

    mutex_destroy(&mutex);
    cond_destroy(&cvar[0]);
    cond_destroy(&cvar[1]);

    printf("Both threads have terminated, final value: %d\n", sharedCounter);

    return 0;
}