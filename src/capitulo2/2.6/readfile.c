#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

char *read_from_file(const char *filename, size_t length)
{
    char *buffer;
    int fd;
    ssize_t bytes_read;
    /* Allocate the buffer. */
    buffer = (char *)malloc(length);
    if (buffer == NULL)
        return NULL;
    /* Open the file. */
    fd = open(filename, O_RDONLY);
    if (fd == -1)
    {
        /* open failed. Deallocate buffer before returning. */
        free(buffer);
        return NULL;
    }
    /* Read the data. */
    bytes_read = read(fd, buffer, length);
    if (bytes_read != length)
    {
        /* read failed. Deallocate buffer and close fd before returning. */
        free(buffer);
        close(fd);
        return NULL;
    }
    /* Everything's fine. Close the file and return the buffer. */
    close(fd);
    return buffer;
}


/* Ejemplo de uso de readfile.c */
int main(int argc, char **argv)
{
    struct stat st;
    const char *filename;
    char *content;
    size_t length;

    if (argc < 2)
    {
        fprintf(stderr, "Uso: %s <archivo>\n", argv[0]);
        return 1;
    }

    filename = argv[1];

    if (stat(filename, &st) == -1)
    {
        perror("stat");
        return 1;
    }

    length = (size_t)st.st_size;
    if (length == 0)
    {
        fprintf(stderr, "Archivo vacio: %s\n", filename);
        return 0;
    }

    content = read_from_file(filename, length);
    if (content == NULL)
    {
        fprintf(stderr, "read_from_file fallo para %s\n", filename);
        return 1;
    }

    /* Escribe el contenido en la salida */
    if (fwrite(content, 1, length, stdout) != length)
    {
        perror("fwrite");
        free(content);
        return 1;
    }

    free(content);
    return 0;
}