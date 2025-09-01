#include <malloc.h>
#include <stdio.h>
#include <pthread.h>
#include <unistd.h>


struct job
{
    /* Link field for linked list. */
    struct job *next;
    /* Other fields describing work to be done... */
};

/* A linked list of pending jobs. */
struct job *job_queue;
/* Process queued jobs until the queue is empty. */

void *thread_function(void *arg)
{
    while (job_queue != NULL)
    {
        /* Get the next available job. */
        struct job *next_job = job_queue;
        /* Remove this job from the list. */
        job_queue = job_queue->next;
        /* Carry out the work. */
        process_job(next_job);
        /* Clean up. */
        free(next_job);
    }
    return NULL;
}


/* Ejemplo para Listing 4.10*/
void process_job(struct job *job) {
    printf("Procesando trabajo...\n");
    sleep(1);
}

int main() {
    // Crea algunos trabajos
    struct job *job1 = malloc(sizeof(struct job));
    struct job *job2 = malloc(sizeof(struct job));
    struct job *job3 = malloc(sizeof(struct job));
    struct job *job4 = malloc(sizeof(struct job));
    struct job *job5 = malloc(sizeof(struct job));

    job1->next = job2;
    job2->next = job3;
    job3->next = job4;
    job4->next = job5;
    job5->next = NULL;
    
    job_queue = job1;
    
    pthread_t thread1, thread2;

    // Crear dos hilos que competirán para procesar trabajos
    pthread_create(&thread1, NULL, thread_function, NULL);
    pthread_create(&thread2, NULL, thread_function, NULL);
    
    pthread_join(thread1, NULL);
    pthread_join(thread2, NULL);
    
    printf("Finalizado el procesamiento de los trabajos\n");
    return 0;
}