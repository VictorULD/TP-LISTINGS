#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/sem.h>

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

/* Wait on a binary semaphore. Block until the semaphore value is positive,
then
decrement it by 1. */
int binary_semaphore_wait(int semid)
{
    struct sembuf operations[1];
    /* Use the first (and only) semaphore. */
    operations[0].sem_num = 0;
    /* Decrement by 1. */
    operations[0].sem_op = -1;
    /* Permit undo'ing. */
    operations[0].sem_flg = SEM_UNDO;
    return semop(semid, operations, 1);
}

/* Post to a binary semaphore: increment its value by 1.
This returns immediately. */
int binary_semaphore_post(int semid)
{
    struct sembuf operations[1];
    /* Use the first (and only) semaphore. */
    operations[0].sem_num = 0;
    /* Increment by 1. */
    operations[0].sem_op = 1;
    /* Permit undo'ing. */
    operations[0].sem_flg = SEM_UNDO;
    return semop(semid, operations, 1);
}


/* Ejemplo de uso de Listing 5.4 */
int main()
{
    int semid;
    key_t key;
    pid_t pid;
    
    // Crear una clave unica para el semaforo
    key = ftok("/tmp", 'S');
    if (key == -1) {
        perror("ftok");
        exit(1);
    }
    
    // Crear el semaforo binario con valor inicial 1
    semid = semget(key, 1, IPC_CREAT | 0666);
    if (semid == -1) {
        perror("semget");
        exit(1);
    }
    
    // Inicializar el semaforo con valor 1 (disponible)
    if (semctl(semid, 0, SETVAL, 1) == -1) {
        perror("semctl");
        exit(1);
    }
    
    printf("Semaforo creado. ID: %d\n", semid);
    
    // Crear proceso hijo
    pid = fork();
    if (pid == 0) {
        // Proceso hijo
        printf("Hijo: Intentando acceder al recurso...\n");
        binary_semaphore_wait(semid);
        printf("Hijo: Recurso obtenido. Trabajando por 3 segundos...\n");
        sleep(3);
        printf("Hijo: Liberando recurso.\n");
        binary_semaphore_post(semid);
        exit(0);
    } else if (pid > 0) {
        // Proceso padre
        sleep(1); // Pequeña pausa para que el hijo vaya primero
        printf("Padre: Intentando acceder al recurso...\n");
        binary_semaphore_wait(semid);
        printf("Padre: Recurso obtenido. Trabajando por 2 segundos...\n");
        sleep(2);
        printf("Padre: Liberando recurso.\n");
        binary_semaphore_post(semid);
        
        // Esperar que termine el hijo
        wait(NULL);
        
        // Eliminar el semáforo
        if (semctl(semid, 0, IPC_RMID) == -1) {
            perror("semctl remove");
        } else {
            printf("Semaforo eliminado.\n");
        }
    } else {
        perror("fork");
        exit(1);
    }
    
    return 0;
}