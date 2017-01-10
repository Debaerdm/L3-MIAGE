/*
 * volume.c
 */
static const char *WHAT_STRING = "@(#)volume.c	1.1 (C) P. Durif 1994" ;
#include <stdio.h>
#include <stdlib.h>

#include "volume.h"
#include "erreurs.h"

static FILE
  *vol = 0,
  *vol_sauve = 0 ;

int vol_debut_creer    (const char *volume)
{
  if (vol_sauve) {
    erreur = VOLUME_DEJA_MONTE ; return -1 ;
  }
  vol_sauve = vol ;
#ifdef __TURBOC__
  if (!(vol = fopen (volume, "w+b"))) {
#else
  if (!(vol = fopen (volume, "w+"))) {
#endif
    vol = vol_sauve ; vol_sauve = 0 ;
    erreur = VOLUME_INEXISTANT ; return -1 ;
  }
  return 0 ;
}
  
int vol_fin_creer    (void)
{
  if (! vol_sauve) {
    erreur = VOLUME_DEJA_MONTE ; return -1 ;
  }
  fclose (vol) ;
  vol = vol_sauve ;
  vol_sauve = 0 ;
  return 0 ;
}

int vol_monter   (const char *volume)
{
  if (vol) {
    erreur = VOLUME_DEJA_MONTE ; return -1 ;
  }
#ifdef __TURBOC__
  if (!(vol = fopen (volume, "r+b"))) {
#else
  if (!(vol = fopen (volume, "r+"))) {
#endif
    erreur = VOLUME_INEXISTANT ; return -1 ;
  }
  return 0 ;
}

int vol_demonter (void)
{
  if (vol == NULL) {
    erreur = VOLUME_NON_MONTE ; return -1 ;
  }
  fclose (vol) ;
  vol = 0 ;
  return 0 ;
}

int vol_lire   (NUM_BLOC n, VOL_BLOC b)
{
#ifdef DEBUG
  printf ("lecture %d\n", n) ;
#endif
  if (vol == NULL) {
    erreur = VOLUME_NON_MONTE ; return -1 ;
  }
  fseek (vol, n*BLOC_SIZE, 0) ;
  if (fread (b, BLOC_SIZE, 1, vol) != 1) {
    perror ("vol_lire.fread") ; 
    exit(EXIT_FAILURE) ;
  }
  return 0 ;
}

int vol_ecrire (NUM_BLOC n, VOL_BLOC b)
{
#ifdef DEBUG
  printf ("ecriture %d\n", n) ;
#endif
   if (vol == NULL) {
     erreur = VOLUME_NON_MONTE ; return -1 ;
   }
   fseek (vol, n*BLOC_SIZE, 0) ;
   if (fwrite (b, BLOC_SIZE, 1, vol) != 1) {
     perror ("vol_ecrire.fwrite") ; exit (1) ;
   }
   return 0 ;
}
