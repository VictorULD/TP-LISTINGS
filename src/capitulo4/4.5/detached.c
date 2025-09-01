#include <pthread.h>
#include <stdio.h>

void *thread_function(void *thread_arg)
{
    /* Do work here... */
    for (int i = 0; i < 10; i++) {
        fputc('x', stderr);
        usleep(100);
    }
}

int main()
{
    pthread_attr_t attr;
    pthread_t thread;

    pthread_attr_init(&attr);

    pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);

    pthread_create(&thread, &attr, &thread_function, NULL);

    pthread_attr_destroy(&attr);

    /* Do work here... */
    for (int i = 0; i < 5; i++) {
        fputc('o', stderr);
        usleep(100);
    }
    /* No need to join the detached thread */

    return 0;
}