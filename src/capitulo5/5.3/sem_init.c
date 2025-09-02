#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/sem.h>

/* We must define union semun ourselves. */
union semun
{
    int val;
    struct semid_ds *buf;
    unsigned short int *array;
    struct seminfo *__buf;
};

/* Initialize a binary semaphore with a value of 1. */
int binary_semaphore_initialize(int semid)
{
    union semun argument;
    unsigned short values[1];
    values[0] = 1;
    argument.array = values;
    return semctl(semid, 0, SETALL, argument);
}

/* Ejemplo de uso de la inicializacion del semáforo binario */
int main()
{
    key_t key;
    int semid;
    
    /* Generar una clave única */
    key = ftok("./src/capitulo5/5.3/sem_init.c", 'S');
    if (key == -1) {
        perror("ftok");
        return 1;
    }
    
    /* Crear conjunto de semaforos con 1 semaforo */
    semid = semget(key, 1, IPC_CREAT | 0666);
    if (semid == -1) {
        perror("semget");
        return 1;
    }
    
    /* Inicializar el semaforo binario */
    if (binary_semaphore_initialize(semid) == -1) {
        perror("binary_semaphore_initialize");
        return 1;
    }
    
    printf("Semaforo binario inicializado exitosamente con ID: %d\n", semid);
    
    /* Limpiar - eliminar conjunto de semaforos */
    if (semctl(semid, 0, IPC_RMID) == -1) {
        perror("semctl IPC_RMID");
        return 1;
    }
    
    return 0;
}