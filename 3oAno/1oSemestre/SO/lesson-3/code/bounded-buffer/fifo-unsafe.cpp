#include <stdio.h>
#include <unistd.h>
#include <stdint.h>
#include <libgen.h>
#include <stdlib.h>
#include <pthread.h>
#include <string.h>

#include "fifo.h"

void fifoInit(Fifo *f)
{
    f->in = f->out = 0;
    f->count = 0;
    memset(f->data, 0x0, N*sizeof(Item));
}

bool fifoIsFull(Fifo *f)
{
    return f->count == N;
}

bool fifoIsEmpty(Fifo *f)
{
    return f->count == 0;
}

void fifoInsert(Fifo *f, Item item)
{
// problemas desta implementação unsafe:
// por exemplo, um insert quando a fifo está cheia, ficamos a esperar até que outro
// processo remova algo da fifo.. rip
    /* wait until fifo is not full */
    while (fifoIsFull(f))
    {
        usleep(1000); // wait for a while
    }

// nesta insertion, e se dois produtores diferentes fizerem insertions ao mesmo tempo?
// certamente dará asneira.. estas operações devem ser implementadas de maneira atomica
    /* make insertion */
    f->data[f->in] = item;
    f->in = (f->in + 1) % N;
    f->count++;
}

Item fifoRetrieve(Fifo *f)
{
    // as funções fifoIsEmpty e fifoIsFull, por muito que possam ser usadas, são
    // muito inseguras, porque não garantem a continuidade do estado
    
    // require (!fifoIsEmpty(f), "fifo empty");

    /* wait until fifo is not empty */
    while (fifoIsEmpty(f))
    {
        usleep(1000); // wait for a while
    }

    /* memorize item to bereturned */
    Item ret = f->data[f->out];

    /* update fifo */
    f->out = (f->out + 1) % N;
    f->count--;

    /* return item */
    return ret;
}

void fifoDestroy(Fifo *f)
{
}
