/*-* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
                                        Philippe Marquet --- <marquet@lifl.fr>
                                        13 Feb 1998
    File:  fstp.c
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifndef lint
static const char *WHAT_STRING = "" ;
#endif /* lint */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "fs.h"
#include "erreurs.h"

static NUM_BLOC get_numero_logique (NUM_BLOC numRel, INOEUD_OCCUPE
				    *inoeud)  
{
  if(numRel < 0) {
    erreur = ACCES_FICHIER_HORS_LIMITE;
    return NUM_NULL;
  }

  if (numRel < NB_BLOCS_DIRECTS)
    return inoeud->direct[numRel];

  numRel -= NB_BLOCS_DIRECTS;

  if(numRel < NUMEROS_PAR_BLOC) {
    BLOC b;
    
    if(inoeud->indirect == NUM_NULL)
      return NUM_NULL;

    if(vol_lire(inoeud->indirect, b.opaque) == -1) {
      return NUM_NULL;
    }

    return b.blocs[numRel];
  }

  numRel -= NUMEROS_PAR_BLOC;

  if(numRel < (NUMEROS_PAR_BLOC * NUMEROS_PAR_BLOC)) {
    BLOC b_prem_niv, b_deux_niv;
    NUM_BLOC ind_prem, ind_deux;

    if(inoeud->double_indirect == NUM_NULL) {
      return NUM_NULL;
    }

    if(vol_lire(inoeud->double_indirect, b_prem_niv.opaque) == -1)
      return NUM_NULL;

    ind_prem = numRel / NUMEROS_PAR_BLOC;
    if(b_prem_niv.blocs[ind_prem] == NUM_NULL)
      return NUM_NULL;

    if (vol_lire(b_prem_niv.blocs[ind_prem], b_deux_niv.opaque) == -1)
      return NUM_NULL;

    ind_deux = numRel % NUMEROS_PAR_BLOC;

    return b_deux_niv.blocs[ind_deux];
  }
  return NUM_NULL ;
}

int lire_bloc (INOMBRE i_nombre, BLOC *b, NUM_BLOC numRel)
/* lit dans "b", le bloc RELATIF "numRel" c'est-a-dire le "numRel"ieme
 *  bloc du inoeud "i_nombre". Il faut donc d'abord transformer ce
 *  numero relatif en numero de bloc volume. */
/* S'il n'y a pas de bloc volume alloue au bloc alors la zone "b" est
 *  mise a zero et tout se passe normalement. */
/* Renvoie le nombre d'octets significatifs lus ou -1 si erreur. */ 

{
  NUM_BLOC blocs;
  INOEUD inoeud;
  int nb_blocs;

  if((lire_inoeud(i_nombre, &inoeud)) == -1) {
          return -1;
  }
    
  nb_blocs = inoeud.occupe.taille - numRel * BLOC_SIZE;

  if(nb_blocs <= 0)
      return 0;
  if(nb_blocs > BLOC_SIZE)
      nb_blocs = BLOC_SIZE;

  blocs = get_numero_logique(numRel, &inoeud.occupe);

  if(blocs == 0) {
    if(erreur == OK) {
        memset(b,'0', BLOC_SIZE);
    } else {
        return -1;
    }
  } else {
    if(vol_lire(blocs, b->opaque) == -1) {
        return -1;
    }
  }
  return nb_blocs; 
}

