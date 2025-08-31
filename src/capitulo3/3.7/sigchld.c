#include <signal.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>

sig_atomic_t child_exit_status;

void clean_up_child_process(int signal_number)
{
    /* Clean up the child process. */
    int status;

    wait(&status);

    /* Store its exit status in a global variable. */
    child_exit_status = status;
}

int main()
{
    /* Handle SIGCHLD by calling clean_up_child_process. */
    struct sigaction sigchld_action;

    memset(&sigchld_action, 0, sizeof(sigchld_action));

    sigchld_action.sa_handler = &clean_up_child_process;

    sigaction(SIGCHLD, &sigchld_action, NULL);

    /* Ejemplo de uso: Fork un proceso hijo que termina después de 2 segundos */
    pid_t child_pid = fork();

    if (child_pid > 0)
    {
        /* Proceso padre */
        printf("Proceso hijo creado con PID: %d\n", child_pid);
        sleep(5); /* Espera para que el handler SIGCHLD sea llamado */
        printf("Estado de salida del hijo: %d\n", child_exit_status);
    }
    else
    {
        /* Proceso hijo */
        sleep(2);
        exit(42); /* Termina con código de salida 42 */
    }
    /* Fin del ejemplo: El handler limpia automáticamente el proceso hijo */

    return 0;
}