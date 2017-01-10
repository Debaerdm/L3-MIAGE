#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fnctl.h>
#include "mflot.h"

mFILE io_mFlot[MAXFILES] = {{0, NULL, NULL},{1, NULL, NULL},{2, NULL, NULL}};

mFILE *mfopen(const char *name, const char *mode) {
    mFILE flot = malloc(sizeof(mFILE));
    flot->fd = open(name, mode);
    
}

