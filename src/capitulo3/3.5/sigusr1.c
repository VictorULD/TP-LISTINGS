#include <signal.h>
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <unistd.h>

sig_atomic_t sigusr1_count = 0;

void handler(int signal_number)
{
    ++sigusr1_count;
}

int main()
{
    struct sigaction sa;
    memset(&sa, 0, sizeof(sa));
    sa.sa_handler = &handler;
    sigaction(SIGUSR1, &sa, NULL);

    /* Do some lengthy stuff here. */
    for (int i = 0; i < 1000000; i++) {
        usleep(100); // Sleep for 100 microseconds

        // Simular llamadas inesperadas a SIGUSR1
        if (i % ((rand() % 49999) + 1) == 0) {
            kill(getpid(), SIGUSR1);
        }

        if (i % 100000 == 0) {
            printf("Processing... %d%%\n", i / 10000);
        }
    }
    /* Do some lengthy stuff here. */

    printf("SIGUSR1 was raised %d times\n", sigusr1_count);
    return 0;
}