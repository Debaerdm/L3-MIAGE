#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <fcntl.h>

#define MAX_VAL 20

int vie_des_fils(FILE *fd, int pipefd[], int nb);

int main(int argc, char *arg[]) {
    int pipefd[2];
    pid_t p;
    FILE *fd;
    int nb;
    if((pipe(pipefd)) == -1) {
        perror("pipe");
        return EXIT_FAILURE;
    }

    if((fd = fopen("nombrePremier", "w")) == NULL) {
        perror("open");
        return EXIT_FAILURE;
    }

    switch(p = fork()) {
        case (pid_t) -1:
            perror("fork");
            return EXIT_FAILURE;
        case (pid_t) 0:
            close(pipefd[1]);
            if((read(pipefd[0], &nb, sizeof(int))) != 0) {
                if(vie_des_fils(fd, pipefd, nb) == -1) {
                    perror("vie des fils");
                    return EXIT_FAILURE;
                }     
            }
           break; 
        default:
            close(pipefd[0]);
            for(nb = 2; nb < MAX_VAL; nb++) {
                if((write(pipefd[1], &nb, sizeof(int))) == -1) {
                    perror("write");
                    return EXIT_FAILURE;
                }
            }

            close(pipefd[1]);
            wait(NULL);
            break;
    }

    fclose(fd);

    return EXIT_SUCCESS;
}

int divisable(int first, int second) {
    if(first % second != 0) {
        return -1;
    } 
    return 0;
}

int vie_des_fils(FILE *fd, int pipefd[], int premier) {
    fprintf(fd, "%d\n", premier);
    fflush(fd);
    int pipefdtmp[2];
    int nb;
    int hasfork = 0;
    close(pipefd[1]);
    while((read(pipefd[0], &nb, sizeof(int))) != 0) {    
        if(divisable(nb,premier) == -1) {
            if(!hasfork) {
                hasfork = 1;
                if((pipe(pipefdtmp)) == -1){
                    perror("pipe");
                    return -1;
                }

                if(fork() == 0) {
                    vie_des_fils(fd,pipefdtmp, nb);
                    exit(EXIT_SUCCESS);
                }
            } else {
                if((write(pipefdtmp[1], &nb, sizeof(int))) == -1) {
                    perror("write premier");
                    return -1;
                }
            }
        }
    }

    close(pipefdtmp[1]);
    wait(NULL);
    return 42;
}
