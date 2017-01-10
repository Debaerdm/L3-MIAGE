#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(void) {
    int i;
    for(i = 0; i < 3; i++){
        if(fork() != 0){
            printf("a");
            if(fork() == 0){
                printf("c");
            } else {
                printf("d");
                exit(0);
            }
        } else {
            printf("b");
        }
    }

}
