/*
 * ffs.c  ffs nom taille_blocs
 */
static const char *WHAT_STRING = "@(#)ffs.c	1.1 (C) P. Durif 1994" ;
#include <stdlib.h>
#include <stdio.h>

#include "erreurs.h"
#include "fs.h"

void usage (void)
{
   printf ("usage: ffs volume blocs inoeuds\n") ;
}

int main (int argc, char *argv [])
{
   if (argc != 4) {
      usage () ; exit (1) ;
   }
   if (fairefs (argv [1], atoi (argv[2]), atoi (argv [3])) == -1) perreur("") ;
   return 1 ;
}
