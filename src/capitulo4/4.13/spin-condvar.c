#include <pthread.h>
#include <stdio.h>
#include <unistd.h>

int thread_flag;

pthread_mutex_t thread_flag_mutex;

void initialize_flag()
{
    pthread_mutex_init(&thread_flag_mutex, NULL);
    thread_flag = 0;
}

/* Calls do_work repeatedly while the thread flag is set; otherwise
spins. */
void *thread_function(void *thread_arg)
{
    while (1)
    {
        int flag_is_set;
        /* Protect the flag with a mutex lock. */
        pthread_mutex_lock(&thread_flag_mutex);
        flag_is_set = thread_flag;
        pthread_mutex_unlock(&thread_flag_mutex);
        if (flag_is_set)
            do_work();
        /* Else don't do anything. Just loop again. */
    }
    return NULL;
}

/* Sets the value of the thread flag to FLAG_VALUE. */
void set_thread_flag(int flag_value)
{
    /* Protect the flag with a mutex lock. */
    pthread_mutex_lock(&thread_flag_mutex);
    thread_flag = flag_value;
    pthread_mutex_unlock(&thread_flag_mutex);
}


/* Ejemplo de Listing 4.13*/
void do_work() {
    printf("Trabajando...\n");
    usleep(500000); // Sleep for 0.5 seconds
}

int main() {
    pthread_t thread;
    
    initialize_flag();
    
    // Create thread
    pthread_create(&thread, NULL, thread_function, NULL);
    
    printf("Thread created, flag is off\n");
    sleep(2);
    
    printf("Setting flag to 1\n");
    set_thread_flag(1);
    sleep(3);
    
    printf("Setting flag to 0\n");
    set_thread_flag(0);
    sleep(2);
    
    printf("Setting flag to 1 again\n");
    set_thread_flag(1);
    sleep(2);

    pthread_cancel(thread);
    pthread_join(thread, NULL);
    
    return 0;
}