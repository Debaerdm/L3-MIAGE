/*
 * erreurs.c
 * "@(#)erreurs.c	1.1 (C) P. Durif 1994"
 */
#include <stdio.h>
#include "erreurs.h"

enum ERREUR erreur = OK ;

void perreur (const char *chunk)
{
   fprintf (stderr, "%s: %s\n", chunk,
      erreur == OK ?                        "OK" :
      erreur == PARAMETRES_INCONSISTANTS ?  "PARAMETRES_INCONSISTANTS" :
      erreur == TABLE_INOEUDS_SATUREE ?     "TABLE_INOEUDS_SATUREE" :
      erreur == SYSTEME_DE_FICHIER_SATURE ? "SYSTEME_DE_FICHIER_SATURE" :
      erreur == LIEN_SUR_REPERTOIRE ?       "LIEN_SUR_REPERTOIRE" :
      erreur == REPERTOIRE_INEXISTANT ?     "REPERTOIRE_INEXISTANT" :
      erreur == VOLUME_INEXISTANT ?         "VOLUME_INEXISTANT" :
      erreur == VOLUME_DEJA_MONTE ?         "VOLUME_DEJA_MONTE" :
      erreur == VOLUME_NON_MONTE ?          "VOLUME_NON_MONTE" :
      erreur == EXISTE_DEJA ?               "EXISTE_DEJA" :
      erreur == FICHIER_INEXISTANT ?        "FICHIER_INEXISTANT" :
      erreur == PAS_UN_REPERTOIRE ?         "PAS_UN_REPERTOIRE" :
      erreur == PAS_UN_ORDINAIRE ?          "PAS_UN_ORDINAIRE" :
      erreur == PAS_UN_SYSTEME_DE_FICHIERS? "PAS_UN_SYSTEME_DE_FICHIERS" :
      erreur == REPERTOIRE_ACTIF ?          "REPERTOIRE_ACTIF" :
      erreur == REPERTOIRE_NON_VIDE ?       "REPERTOIRE_NON_VIDE" :
      erreur == LECTURE_IMPOSSIBLE ?        "LECTURE_IMPOSSIBLE" :
      erreur == ECRITURE_IMPOSSIBLE ?       "ECRITURE_IMPOSSIBLE" :
      erreur == ACCES_FICHIER_HORS_LIMITE ? "ACCES_FICHIER_HORS_LIMITE" :
      erreur == OPERATION_IMPOSSIBLE ?      "OPERATION_IMPOSSIBLE" :
      erreur == MEMOIRE_INSUFFISANTE ?      "MEMOIRE_INSUFFISANTE" :
      erreur == NYI ?      		    "NON IMPLANTE" :
                                            "erreur inconnue ??"
   ) ;
   erreur = OK ;
}
