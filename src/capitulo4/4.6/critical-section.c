#include <pthread.h>
#include <stdio.h>
#include <string.h>

#include <stdlib.h>
#define NUM_ACCOUNTS 5

/* An array of balances in accounts, indexed by account number. */
float *account_balances;

/* Transfer DOLLARS from account FROM_ACCT to account TO_ACCT. Return
0 if the transaction succeeded, or 1 if the balance FROM_ACCT is
too small. */
int process_transaction(int from_acct, int to_acct, float dollars)
{
    int old_cancel_state;

    /* Check the balance in FROM_ACCT. */
    if (account_balances[from_acct] < dollars)
        return 1;

    /* Begin critical section. */
    pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &old_cancel_state);
    
    /* Move the money. */
    account_balances[to_acct] += dollars;
    account_balances[from_acct] -= dollars;

    /* End critical section. */
    pthread_setcancelstate(old_cancel_state, NULL);
    
    return 0;
}


/* Ejemplo de uso de critical-section.c*/
struct thread_data
{
    int from_account;
    int to_account;
    float amount;
    int num_transactions;
};

/* Thread function que realiza las multiples transacciones */
void *perform_transactions(void *arg)
{
    struct thread_data *data = (struct thread_data *)arg;

    for (int i = 0; i < data->num_transactions; i++)
    {
        int result = process_transaction(data->from_account, data->to_account, data->amount);
        if (result == 0)
        {
            printf("Thread %lu: Transfirio $%.2f de la cuenta %d a la cuenta %d\n",
                   pthread_self(), data->amount, data->from_account, data->to_account);
        }
        else
        {
            printf("Thread %lu: Falló la transacción - fondos insuficientes en la cuenta %d\n",
                   pthread_self(), data->from_account);
        }

        /* Delay para hacer la condición de carrera más visible */
        usleep(1000);
    }

    return NULL;
}

int main()
{
    /* Inicializar los saldos de las cuentas */
    account_balances = malloc(NUM_ACCOUNTS * sizeof(float));
    for (int i = 0; i < NUM_ACCOUNTS; i++)
    {
        account_balances[i] = 1000.0; /* Cada cuenta comienza con $1000 */
    }

    printf("Balance inicial de las cuentas:\n");
    for (int i = 0; i < NUM_ACCOUNTS; i++)
    {
        printf("Cuenta %d: $%.2f\n", i, account_balances[i]);
    }
    printf("\n");

    /* Crear hilos para realizar transacciones concurrentes */
    pthread_t threads[4];
    struct thread_data thread_data[4];

    /* Hilo 1: Transferir de la cuenta 0 a la cuenta 1 */
    thread_data[0] = (struct thread_data){0, 1, 50.0, 5};

    /* Hilo 2: Transferir de la cuenta 1 a la cuenta 2 */
    thread_data[1] = (struct thread_data){1, 2, 75.0, 3};

    /* Hilo 3: Transferir de la cuenta 0 a la cuenta 3 */
    thread_data[2] = (struct thread_data){0, 3, 100.0, 4};

    /* Hilo 4: Transferir de la cuenta 2 a la cuenta 4 */
    thread_data[3] = (struct thread_data){2, 4, 25.0, 6};

    /* Iniciar todos los hilos */
    for (int i = 0; i < 4; i++)
    {
        pthread_create(&threads[i], NULL, perform_transactions, &thread_data[i]);
    }

    /* Espera a que los hilos completen */
    for (int i = 0; i < 4; i++)
    {
        pthread_join(threads[i], NULL);
    }

    printf("\nBalances finales de las cuentas:\n");
    float total = 0.0;
    for (int i = 0; i < NUM_ACCOUNTS; i++)
    {
        printf("Cuenta %d: $%.2f\n", i, account_balances[i]);
        total += account_balances[i];
    }
    printf("Total: $%.2f (Deberia ser $%.2f)\n", total, NUM_ACCOUNTS * 1000.0);

    free(account_balances);
    return 0;
}