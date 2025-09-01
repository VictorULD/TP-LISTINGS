#include <malloc.h>
#include <pthread.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>

/* Allocate a temporary buffer. */
void *allocate_buffer(size_t size)
{
    //return malloc(size);
    void *buffer = malloc(size);
    printf("Buffer de %zu bytes asignado en la dirección: %p\n", size, buffer);
    return buffer;
}

/* Deallocate a temporary buffer. */
void deallocate_buffer(void *buffer)
{
    printf("Liberando buffer en la dirección: %p\n", buffer);
    free(buffer);
}

void do_some_work()
{
    /* Allocate a temporary buffer. */
    void *temp_buffer = allocate_buffer(1024);

    /* Register a cleanup handler for this buffer, to deallocate it in
    case the thread exits or is cancelled. */
    pthread_cleanup_push(deallocate_buffer, temp_buffer);


    /* Simulate work that might call pthread_exit or be cancelled... */
    printf("Realizando trabajo con el buffer...\n");
    
    /* Simula escritura en el buffer */
    strcpy((char*)temp_buffer, "Datos importantes del hilo");
    printf("Datos escritos en el buffer: %s\n", (char*)temp_buffer);
    
    /* Simula tiempo de procesamiento */
    sleep(2);
    
    printf("Trabajo completado exitosamente\n");


    /* Unregister the cleanup handler.Because we pass a nonzero value,
       this actually performs the cleanup by calling
       deallocate_buffer.*/
    pthread_cleanup_pop(1);
}

// Ejemplo de uso de cleanup.c
/* Función del hilo que puede ser cancelado */
void *thread_function(void *arg)
{
    printf("Hilo iniciado (ID: %lu)\n", pthread_self());
    
    /* Habilita la cancelación del hilo */
    pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
    pthread_setcanceltype(PTHREAD_CANCEL_DEFERRED, NULL);
    
    do_some_work();
    
    printf("Hilo terminando normalmente\n");
    return NULL;
}

int main()
{
    pthread_t thread1, thread2;
    
    /* Crear primer hilo que terminará normalmente */
    printf("Creando hilo que terminará normalmente:\n");
    pthread_create(&thread1, NULL, thread_function, NULL);
    pthread_join(thread1, NULL);
    
    printf("\n");
    
    /* Crear segundo hilo que será cancelado */
    printf("Creando hilo que será cancelado:\n");
    pthread_create(&thread2, NULL, thread_function, NULL);
    
    /* Esperar un poco y luego cancelar el hilo */
    sleep(1);
    printf("Cancelando el segundo hilo...\n");
    pthread_cancel(thread2);
    pthread_join(thread2, NULL);
    
    printf("\nPrograma terminado. En ambos casos el buffer fue liberado correctamente.\n");
    
    return 0;
}