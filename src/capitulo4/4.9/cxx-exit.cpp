#include <pthread.h>
#include <iostream>
#include <unistd.h>
#include <cstdlib>

// Variable global para controlar cuando el thread debe salir
static bool exit_requested = false;

// Función que simula alguna condición para salir del thread
bool should_exit_thread_immediately()
{
    return exit_requested;
}

class ThreadExitException
{
public:
    /* Create an exception-signaling thread exit with RETURN_VALUE. */
    ThreadExitException(void *return_value)
        : thread_return_value_(return_value)
    {
    }
    /* Actually exit the thread, using the return value provided in the
    constructor. */
    void *DoThreadExit()
    {
        pthread_exit(thread_return_value_);
    }

private:
    /* The return value that will be used when exiting the thread.
     */
    void *thread_return_value_;
};

void do_some_work()
{
    int work_counter = 0;
    while (1)
    {
        /* Simular trabajo útil */
        std::cout << "Thread working... iteration " << ++work_counter << std::endl;
        sleep(1);  // Simular trabajo que toma tiempo
        
        // Verificar si debemos salir del thread
        if (should_exit_thread_immediately())
        {
           //throw ThreadExitException(/* thread's return value = */ NULL);
            std::cout << "Thread exit requested, throwing exception..." << std::endl;
            throw ThreadExitException(/* thread's return value = */ reinterpret_cast<void*>(work_counter));
        }
    }
}

void *thread_function(void *arg)
{
    std::cout << "Thread started" << std::endl;
    try
    {
        do_some_work();
    }
    catch (ThreadExitException ex)
    {
        /* Some function indicated that we should exit the thread. */
        std::cout << "Caught ThreadExitException, exiting thread safely..." << std::endl;
        ex.DoThreadExit();
    }
    return NULL;
}


// Función principal con ejemplo de uso
int main()
{
    pthread_t thread;
    void *thread_result;
    
    std::cout << "Creating thread..." << std::endl;
    
    // Crear el thread
    if (pthread_create(&thread, NULL, thread_function, NULL) != 0)
    {
        std::cerr << "Error creating thread" << std::endl;
        return 1;
    }
    
    // Permitir que el thread trabaje por un tiempo
    std::cout << "Main thread sleeping for 5 seconds..." << std::endl;
    sleep(5);
    
    // Solicitar que el thread salga
    std::cout << "Requesting thread to exit..." << std::endl;
    exit_requested = true;
    
    // Esperar a que el thread termine
    if (pthread_join(thread, &thread_result) != 0)
    {
        std::cerr << "Error joining thread" << std::endl;
        return 1;
    }
    
    std::cout << "Thread finished with result: " << thread_result << std::endl;
    std::cout << "Main program finished" << std::endl;
    
    return 0;
}