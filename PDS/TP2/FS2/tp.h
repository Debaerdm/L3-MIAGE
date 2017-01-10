#ifndef lint
static const char *WHAT_STRING = "";
#endif /* lint */

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include "fs.h"

#include "erreurs.h"

typedef struct {
    int libre_chaine;
    int libre_contigu;
    int bloc_system;
#define MAXREF 5
    int nb_ref;
    INOMBRE references_par[MAXREF];
} BLOC_CHECK;

BLOC_CHECK *b_check;

int nb_blocs_libres(SUPER_BLOC *s);
int nb_inoeuds_libres(SUPER_BLOC *s);
void mark_free_blocs(SUPER_BLOC *s);
void mark_ref(INOMBRE *inombre);
