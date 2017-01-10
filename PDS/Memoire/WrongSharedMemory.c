#include <errno.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <sys/wait.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include "sharedMemory.h"
#include <string.h>

int main(void) {

    int pid ;
    char *mem ;
    int shmid ;     /* l'identificateur du segment de m\'emoire partag\'ee */
    int flag = 0 ;  /* un drapeau attach\'e au segment */
    char *name ;

    /* cr\'eation du segment de m\'emoire partag\'ee */

    name = "WrongSharedMemory.c" ;
    shmid = creerSegment(100,name,1) ;

    /* mutation */

    switch(pid =fork()) 
    { 
        case -1 :
            {
                perror("impossible de creer un fils") ;
                return -1 ;
            }
        case 0 :
            {

                printf("Salut, je suis le fils %d\n",getpid()) ;
                printf("Je commence par m'attacher le segment de memoire\n") ;
                mem = shmat(shmid,0,flag) ;

                if (mem ==(char*)-1)
                {
                    perror("attachement impossible") ;
                    exit(1) ;
                }
                printf("je vais ecrire un message que papa va afficher\n") ;
                strcpy(mem,"La vie est belle") ;

                printf("Bon, c'est pas tout ca mais il est temps de mourir\n") ;
                printf("avant tout detachons le segment partage\n") ;

                if(shmdt(mem)==-1)
                {
                    perror("detachement impossible") ;
                    exit(1) ;
                }

                printf("maintenant que c'est fait, bye bye\n") ;
                printf("Le fils se suicide\n") ;
                return 1 ;
            }
        default :
            {
                printf("Je suis le pere\n") ;
                printf("Je commence par m'attacher le segment de memoire\n") ;
                mem = shmat(shmid,0,flag) ;

                if (mem ==(char*)-1)
                {
                    perror("attachement impossible") ;
                    exit(1) ;
                }

                printf("je vais afficher un message que mon fils a ecrit\n") ;
                printf("%s\n",mem) ;
                printf("Sacre plaisantin ce fiston\n") ;

                printf("Bon, c'est pas tout ca mais il est temps de mourir\n") ;
                printf("avant tout detachons le segment partage") ;

                if(shmdt(mem)==-1)
                {
                    perror("detachement impossible") ;
                    exit(1) ;
                }
            }
    }

    printf("Le pere attend la mort de son fils\n") ;
    wait(0) ;
    printf("Bon, faisons le menage et supprimons le segment partagee\n") ;
    detruitSegment(shmid) ;
    printf("Le pere se suicide\n") ;


    return 1  ;
} 
