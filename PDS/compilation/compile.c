#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <string.h>

int main(int argc, char *argv[], char *envp[]) {
    pid_t pid;
    int i, status;
    char *tmp[argc];

    if(argc <= 1) {
        fprintf(stderr, "Not enought argument!\n");
        exit(EXIT_FAILURE);
    }

    tmp[0] = "gcc";

    for(i = 1; i < argc; i++) {
        if(access(argv[i], F_OK) == 0) {    
        tmp[i] = argv[i]; 
            if((pid = fork()) == -1) {
                perror("fork");
                exit(EXIT_FAILURE);
            }

            if(pid == 0) {
                if((execlp("gcc", "gcc", "-c", argv[i], NULL)) == -1) {
                    perror("execvp");
                    exit(EXIT_FAILURE);
                }

            }

        } else {
            fprintf(stderr, "%s : Not a file\n", argv[i]);
            exit(EXIT_FAILURE);
        }
    }


    tmp[argc] = NULL;

    for(i = 1; i < argc; i++) {
        tmp[i][strlen(argv[i]) - 1] = 'o';
    }

    if((wait(&status)) != -1) {
        if((WIFEXITED(status) && WEXITSTATUS(status)) == EXIT_SUCCESS) {
            if((execvp("gcc", tmp)) == -1) {
                perror("execvp");
                exit(EXIT_FAILURE);
            }
        } else {
            fprintf(stderr, "Error with the compilation! \n");
            exit(EXIT_FAILURE);
        }
    }

    return 0;
}
