#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <sys/types.h>
#include "sharedMemory.h"

/*int main(void){
    int shmid = 0;
    if((shmid = creeSegment(1024, "segment.c", 42)) == -1) {
        perror("segment");
        return EXIT_FAILURE;
    }

    if((infoSegment(shmid)) == -1){
        perror("info");
        return EXIT_FAILURE;
    }

    if((detruitSegment(shmid)) == -1){
        perror("shmid destroy");
        return EXIT_FAILURE;
    }

    return 0;
}*/

int creerSegment(size_t size, char *file, int key) {
    key_t key_sh;
    int sh = 0;

    if((key_sh = ftok(file, key)) == -1) {
        perror("ftok");
        return -1;
    }

    if((sh = shmget(key_sh, size, IPC_CREAT | IPC_EXCL | SHM_R | SHM_W)) == -1) {
        perror("shmget");
        return -1;
    }

    printf("ID : %d\nKEY : %d\n", sh, key);
    return sh;
}


int infoSegment(int shmid) {
  struct shmid_ds shminfo;
    
    if((shmctl(shmid, SHM_STAT ,&shminfo)) == -1) {
        perror("shmctl");
        return -1;
    }
    printf("shm_perm_uid : %u\nshm_perm_gid : %u\nshm_perm_cuid : %u\nshm_perm_cgid : %u\nshm_segsz : %lu\nshm_atime : %lu\nshm_dtime : %lu\nshm_ctime : %lu\nshm_cpid : %u\nshm_lpid : %u\n", shminfo.shm_perm.uid, shminfo.shm_perm.gid, shminfo.shm_perm.cuid, shminfo.shm_perm.cgid, shminfo.shm_segsz, shminfo.shm_atime, shminfo.shm_dtime, shminfo.shm_ctime, shminfo.shm_cpid, shminfo.shm_lpid);

    return 0;
}


int detruitSegment(int shmid) {
    if((shmctl(shmid, IPC_RMID, NULL)) == -1) {
        perror("shmctl destroy");
        return -1;
    }

    printf("Destroy\n");

    return 0;
} 
