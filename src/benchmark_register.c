#include <stdio.h>
#include <time.h>

int main()
{
    register long int x, y;
    double tempo = 0.0;

    printf("Programa iniciado.\nCalculando o tempo de processamento...\n");

    clock_t begin = clock();

    for (x = 0; x < 60000; x++)
        for (y = 0; y < 60000; y++)
            ;

    clock_t end = clock();

    tempo += (double)(end - begin) / CLOCKS_PER_SEC;

    printf("Tempo decorrido: %f segundos\n", tempo);

    return 0;
}