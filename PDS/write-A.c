#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>
#define BUFFSIZE 1000000

int main(void) 
{
    int fd;
    if ((fd = open("/home/l3miage/debaerdemaekem/Documents/L3-Miage/PDS/Test", O_CREAT | O_RDWR, S_IRWXU)) == -1) { 
        perror("Open error");
        return 1;
    }

    int i;
    char *tab = "a";
    for( i = 0 ; i < BUFFSIZE; i++){
        if(write(fd, tab, 1) != 1) {
            perror("write error");
            return 1;
        }
    }

    close(fd);
    return 0;
}

