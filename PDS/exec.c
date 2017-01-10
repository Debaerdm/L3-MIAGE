#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main(void){
    int pipefd[2], pipefd2[2];
    if((pipe(pipefd)) == -1 || (pipe(pipefd2)) == -1) {
        perror("pipe");
        return EXIT_FAILURE;
    }

    if(fork() == 0) {
            dup2(pipefd[1], 1);
            close(pipefd[0]);
            execlp("ls","ls","-rt","/bin/", NULL);
            return EXIT_FAILURE;
    } else {
        if(fork() == 0) {
            dup2(pipefd[0], 0);
            close(pipefd[1]);
            dup2(pipefd2[1], 1);
            execlp("grep", "grep", "sh", NULL);
            return EXIT_FAILURE;
        } else {
            dup2(pipefd2[0], 0);
            close(pipefd2[1]);
            execlp("wc","wc", "-l", NULL);
            return EXIT_FAILURE;
        }
    }

    return 0;
}
