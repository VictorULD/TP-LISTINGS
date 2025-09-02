#include <sys/ipc.h>
#include <sys/sem.h>
#include <sys/types.h>

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

/* We must define union semun ourselves. */
union semun
{
    int val;
    struct semid_ds *buf;
    unsigned short int *array;
    struct seminfo *__buf;
};

/* Obtain a binary semaphore's ID, allocating if necessary. */
int binary_semaphore_allocation(key_t key, int sem_flags)
{
    return semget(key, 1, sem_flags);
}

/* Deallocate a binary semaphore. All users must have finished their
use. Returns -1 on failure. */
int binary_semaphore_deallocate(int semid)
{
    union semun ignored_argument;
    return semctl(semid, 1, IPC_RMID, ignored_argument);
}


/* Ejemplo de Listing 5.2 */
int main() {
    key_t key = ftok(".", 1);
    int semid;
    
    // Reserva de los Semaforos
    semid = binary_semaphore_allocation(key, IPC_CREAT | 0666);
    if (semid == -1) {
        perror("Fallo al reservar el semaforo");
        exit(1);
    }
    
    printf("Semaforo reservado con ID: %d\n", semid);

    // Simular trabajo
    sleep(2);

    // Liberar semaforo
    if (binary_semaphore_deallocate(semid) == -1) {
        perror("Fallo al liberar el semaforo");
        exit(1);
    }

    printf("Semaforo liberado con exito\n");
    return 0;
}