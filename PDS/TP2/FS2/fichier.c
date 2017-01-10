/*
 * fichier.c
 */
static const char *WHAT_STRING = "@(#)fichier.c	1.2 (C) P. Durif 1994" ;
#include <string.h>
#include <malloc.h>
#include <memory.h>

#include "fichier.h"
#include "erreurs.h"


#ifdef __TURBOC__
extern char *strdup (const char *s) ;
#endif

static INOMBRE i_rep (const char *nom, const char **simple)
/* renvoie le INOMBRE du repertoire,
 * dans *simple : le nom de la derniere entree de "nom"
 */
{
   char *dup = strdup (nom), *chemin = dup ;
   INOMBRE ichemin ;

   *simple = strrchr (nom, '/') ;
   if (! *simple) {
      *simple = nom ; chemin = "." ;
   } else {
      (*simple)++ ; *strrchr (chemin, '/') = 0 ;
   }
   if (! **simple) *simple = "." ;
   ichemin = localiser (chemin) ;
   free (dup) ;
   if (ichemin == NUM_NULL) return NUM_NULL ;
   {
       INOEUD i ;
       lire_inoeud (ichemin, &i) ;
       if (i.occupe.type != REPERTOIRE) {
	  erreur = REPERTOIRE_INEXISTANT ;
	  return NUM_NULL ;
       }
   }
   return ichemin ;
}

int get_info   (const char *nom, INFO *info)
{
   INOMBRE i ;
   INOEUD in ;

   i = localiser (nom) ;
   if (i == NUM_NULL) return -1 ;
   lire_inoeud (i, &in) ;
   info->i_nombre = i ;
   info->taille = in.occupe.taille ;
   info->liens  = in.occupe.liens ;
   info->type   = in.occupe.type ;
   return 0 ;
}

int creer_repertoire (const char *nom)
{
   const char *simple ;
   INOMBRE ichemin, ientree ;

   ichemin = i_rep (nom, &simple) ;
   if (ichemin == NUM_NULL) return -1 ;
   return creer_entree_repertoire (ichemin, simple) ;
}

int detruire_repertoire (const char *nom)
/* "nom" doit etre un repertoire vide (sauf "." et "..") qui ne se trouve
 * pas sur le chemin du repertoire courant
 */
{
   const char *simple ;
   INOMBRE ichemin, ientree ;

   ichemin = i_rep (nom, &simple) ;
   if (ichemin == NUM_NULL) return -1 ;
   return supprimer_entree_repertoire (ichemin, simple) ;
}

int creer_lien (const char *source, const char *cible)
/*
 * ajoute un lien sur "cible" dont le nom est "source"
 *   "source" ne doit pas deja exister
 *   "cible" doit etre un ORDINAIRE
 */
{
   INOMBRE ichemin ;
   INOMBRE icible = localiser (cible) ;
   const char *simple ;

   if (icible == NUM_NULL) return -1 ;
   ichemin = i_rep (source, &simple) ;
   if (ichemin == NUM_NULL) return -1 ;
   return creer_entree_ordinaire (ichemin, icible, simple) ;
}



int detruire_lien   (const char *nom)
/*
 * supprime un lien sur le INOEUD designe par nom
 *   "nom" doit etre ORDINAIRE
 *   si le nombre de liens devient nul, le fichier est effectivement
 *   detruit
 */
{
   INOMBRE ichemin ;
   const char *simple ;

   ichemin = i_rep (nom, &simple) ;
   if (ichemin == NUM_NULL) return -1 ;
   return supprimer_entree_ordinaire (ichemin, simple) ;
}


FICHIER *ouvrir (const char *nom, enum MODE mode, enum OPERATION o)
/*
 * en CREATION, le fichier est ORDINAIRE et ne peut ecraser
 * qu'un fichier ORDINAIRE
 * en OUVERTURE, ce peut etre un ORDINAIRE ou un REPERTOIRE (mais
 * seulement en LECTURE).
 */
{
   FICHIER *f ;
   INFO info ;

   if (o == CREATION && mode == LECTURE) {
      erreur = PARAMETRES_INCONSISTANTS ;
      return 0 ;
   }

   if (get_info (nom, &info) == -1) {/* inexistant */
      const char *simple ;
      INOMBRE ichemin, isimple ;
 
      if (o != CREATION) {
         erreur = FICHIER_INEXISTANT ; return 0 ;
      }
      if ((ichemin = i_rep (nom, &simple)) == NUM_NULL) return 0 ;
      if ((isimple = creer_inoeud_ordinaire ()) == NUM_NULL) return 0 ;
      if (creer_entree_ordinaire (ichemin, isimple, simple) == -1) return 0 ;
      get_info (nom, &info) ;
   }
   if (info.type == REPERTOIRE && mode != LECTURE) {
      erreur = OPERATION_IMPOSSIBLE ; return 0 ;
   }
   if (o == CREATION) vider_inoeud_ordinaire (info.i_nombre) ;

   f = (FICHIER *) malloc (sizeof (struct FICHIER)) ;
   f->i = info.i_nombre ;
   f->mode = mode ;
   f->pointeur = 0 ;
   return f ;
}

int fermer (FICHIER *f)
{
   free (f) ;
   return 0 ;
}

#define MIN(a, b) ((a) > (b) ? (b) : (a))

int lire   (FICHIER *f, void *zone, u_long taille)
{
   NUM_BLOC nb = f->pointeur / BLOC_SIZE ;
   long debit = f->pointeur % BLOC_SIZE ;
   u_long te = 0 ;

   if (! (f->mode & LECTURE)) {
      erreur = LECTURE_IMPOSSIBLE ; return -1 ;
   }
   while (taille) {
      BLOC b ;
      long taille_lue ;

      if ((taille_lue = lire_bloc (f->i, &b, nb)) == -1) {
         return -1 ;
      }
      taille_lue -= debit ;
      if (taille_lue <= 0) break ;
      taille_lue = MIN (taille, taille_lue) ;
      memcpy ((char *) zone, b.opaque + debit, taille_lue) ;
      nb++ ;
      zone = (char *)zone + taille_lue ;
      taille -= taille_lue ;
      te += taille_lue ;
      debit = 0 ;
   }
   f->pointeur += te ;
   return te ;
}

int ecrire (FICHIER *f, const void *zone, u_long taille)
{
   NUM_BLOC nb = f->pointeur / BLOC_SIZE ;
   long debit = f->pointeur % BLOC_SIZE ;
   u_long te = 0 ;

   if (! (f->mode & ECRITURE)) {
      erreur = ECRITURE_IMPOSSIBLE ; return -1 ;
   }
   while (taille) {
      BLOC b ;
      long taille_a_ecraser = MIN (taille, BLOC_SIZE-debit) ;

      if (lire_bloc (f->i, &b, nb) == -1) return -1 ;
      memcpy (b.opaque + debit, (const char *) zone, taille_a_ecraser) ;
      if (ecrire_bloc (f->i, &b, nb, debit + taille_a_ecraser) == -1)
         return -1 ;
      nb++ ;
      zone = (const char *)zone + taille_a_ecraser ;
      taille -= taille_a_ecraser ;
      te += taille_a_ecraser ;
      debit = 0 ;
   }
   f->pointeur += te ;
   return te ;
}

int positionner (FICHIER *f, u_long pointeur)
{
   f->pointeur = pointeur ;
   return 0 ;
}
