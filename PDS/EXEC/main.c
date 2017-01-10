#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main(int argc, char **argv) {

    if(argc <= 1) {
        fprintf(stderr, "Pas d'argument !\n");
        exit(EXIT_FAILURE);
    } 
    
    if (argc >= 3) {
        fprintf(stderr, "Trop d'argument !\n");
        exit(EXIT_FAILURE);
    }

    pid_t p;

    if((p = fork()) == -1) {
        perror("fork");
        exit(EXIT_FAILURE);
    }

    if(p == 0) {
        execlp("ls", "ls", *argv[2], NULL);
        return -1;
    } else {
        wait(NULL);
        printf("Test\n");
    }

    return 0;
}
