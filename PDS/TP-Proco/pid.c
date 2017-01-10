#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <ctype.h>

#define BUFF 80

int main(int argc, char **argv){
    
    int i = 0;
    int j;
    int fd;
    pid_t p;

    char buff[BUFF];

    if((fd = open("listeNbPremier", O_RDONLY)) == -1) {
        perror("open");
        exit(1);
    }

    while(read(fd, buff, 1) != 0){
        //fscanf(fd, "%d", &j);
        printf("PERE : %s\n", buff);
    }

    /*if((p = fork()) == -1) {
        fclose(fd);
        perror("fork");
        exit(EXIT_FAILURE);
    }

    if(p == 0){
        while(read() != 0){
            fscanf(fd, "%d", &j);
            printf("FILS : %d\n", j);
        }
        
        fclose(fd);
        exit(0);
    } else {
        wait(NULL);

        while(!feof(fd)) {
            fscanf(fd, "%d", &j);
            printf("PERE : %d\n", j);
        }
        fclose(fd);
    }*/

    return 0;
}
