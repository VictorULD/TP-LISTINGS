#include <malloc.h>
#include <pthread.h>
#include <stdio.h>
#include <unistd.h>

struct job
{
    /* Link field for linked list. */
    struct job *next;
    /* Other fields describing work to be done... */
};

/* A linked list of pending jobs. */
struct job *job_queue;

/* A mutex protecting job_queue. */
pthread_mutex_t job_queue_mutex = PTHREAD_MUTEX_INITIALIZER;

/* Process queued jobs until the queue is empty. */
void *thread_function(void *arg)
{
    while (1)
    {
        struct job *next_job;
        /* Lock the mutex on the job queue. */
        pthread_mutex_lock(&job_queue_mutex);
        /* Now it's safe to check if the queue is empty. */
        if (job_queue == NULL)
            next_job = NULL;
        else
        {
            /* Get the next available job. */
            next_job = job_queue;
            /* Remove this job from the list. */
            job_queue = job_queue->next;
        }
        /* Unlock the mutex on the job queue because we're done with the
        queue for now. */
        pthread_mutex_unlock(&job_queue_mutex);
        /* Was the queue empty? If so, end the thread. */
        if (next_job == NULL)
            break;
        /* Carry out the work. */
        process_job(next_job);
        /* Clean up. */
        free(next_job);
    }
    return NULL;
}



/* Ejemplo para Listing 4.11*/
void process_job(struct job *job)
{
    printf("Procesando trabajo...\n");
    sleep(1);
}

int main()
{
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