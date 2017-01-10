/*
 * fs.c 
 */
static const char *WHAT_STRING = "@(#)fs.c	1.6 (C) P. Durif 1994" ;
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "fs.h"
#include "erreurs.h"

#ifdef __TURBOC__
static void bzero (void *z, unsigned nb)
{
  while (nb--) {
    *(char *)z = 0 ; z = (char *)z + 1 ;
  }
}
#endif

#define message(m) printf ("%s\n", m) ;

#define MAXPILE 100
static INOMBRE tpile [MAXPILE] ;
static int spile = 0 ;

static void empiler (INOMBRE i_nombre)
{
  tpile [spile++] = i_nombre ;
}

static void depiler (void)
{
  spile-- ;
}

static INOMBRE sommet (void)
{
   return tpile [spile-1] ;
}

static void vider (void)
{
  spile = 0 ;
}

static int est_en_pile (INOMBRE i_nombre)
{
  int p = 0 ;
  while (p < spile && i_nombre != tpile [p]) p++ ;
  return p < spile ;
}

#define lire_inoeuds(i_nombre, b)    vol_lire   (IBLOC (i_nombre), b)
#define ecrire_inoeuds(i_nombre, b)  vol_ecrire (IBLOC (i_nombre), b)

int lire_inoeud (INOMBRE i_nombre, INOEUD *inoeud)
{
  BLOC b ;

  /* verifier que le i_nombre n'est pas debile ... */
  lire_inoeuds (i_nombre, b.opaque) ;
  *inoeud = b.inoeuds [INDICE (i_nombre)] ;
  return 0 ;
}

static NUM_BLOC allouer_bloc (void)
{
  BLOC b ;
  SUPER_BLOC *s = &b.super_bloc ;
  NUM_BLOC n = NUM_NULL ;
  
  vol_lire (SUPER, b.opaque) ;
  if ((n = s->b_contigu) < s->nb_blocs) {
    s->b_contigu++ ;
    vol_ecrire (SUPER, b.opaque) ;
  } else if ((n = s->b_chaine) != NUM_NULL) {
    BLOC bb ;
    
    vol_lire (n, bb.opaque) ;
    s->b_chaine = bb.bloc_libre.b_suiv ;
    vol_ecrire (SUPER, b.opaque) ;
  } else {
    erreur = SYSTEME_DE_FICHIER_SATURE ;
   }
  return n ;
}

static int liberer_bloc (NUM_BLOC n)
{
  BLOC b ;
  SUPER_BLOC *s = &b.super_bloc ;
  
  vol_lire (SUPER, b.opaque) ;
  {
    BLOC bn ;
    
    bn.bloc_libre.b_suiv = s->b_chaine ;
    vol_ecrire (n, bn.opaque) ;
  }
  s->b_chaine = n ;
  vol_ecrire (SUPER, b.opaque) ;
  return 0 ;
}

static INOMBRE allouer_inoeud (void)
{
  BLOC b ;
  SUPER_BLOC *s = &b.super_bloc ;
  INOMBRE i_nombre = NUM_NULL ;
   
  /* message ("allouer_inoeud") ; */
  
  vol_lire (SUPER, b.opaque) ;
  if ((i_nombre = s->i_contigu) < s->nb_inoeuds) {
    s->i_contigu ++ ;
    vol_ecrire (SUPER, b.opaque) ;
  } else if ((i_nombre = s->i_chaine) != NUM_NULL) {
    BLOC bi ;
    INOEUD_LIBRE *il = &bi.inoeuds [INDICE (i_nombre)].libre ;
    
    lire_inoeuds (i_nombre, bi.opaque) ;
    s->i_chaine = il->i_suiv ;
    vol_ecrire (SUPER, b.opaque) ;
  } else {
    erreur = TABLE_INOEUDS_SATUREE ;
  }
  return i_nombre ;
}

static int liberer_inoeud (INOMBRE i_nombre)
{
  BLOC b ;
  SUPER_BLOC *s = &b.super_bloc ;
  INOEUD *inoeud = &b.inoeuds [INDICE (i_nombre)] ;
  INOMBRE ancien ;
  
  vol_lire (SUPER, b.opaque) ;
  ancien = s->i_chaine ;
  s->i_chaine = i_nombre ;
  vol_ecrire (SUPER, b.opaque) ;
  
  lire_inoeuds (i_nombre, b.opaque) ;
  inoeud->libre.i_suiv = ancien ;
  ecrire_inoeuds (i_nombre, b.opaque) ;
  return 0 ;
}

static NUM_BLOC get_numero_logique (NUM_BLOC numRel, INOEUD_OCCUPE
				     *inoeud)  
     /* traduit le numero relatif en numero logique */
{
  if (0 <= numRel  &&  numRel < NB_BLOCS_DIRECTS) {
    return inoeud->direct [numRel] ;
  }
  numRel -= NB_BLOCS_DIRECTS ;
  if (0 <= numRel && numRel < NUMEROS_PAR_BLOC) {
    /* lire le numero logique dans le bloc d'indirection */
    BLOC b ;
    
    if (inoeud->indirect == NUM_NULL)
      return NUM_NULL ;
    vol_lire (inoeud->indirect, b.opaque) ;
    return b.blocs [numRel] ;
  }
  numRel -= NUMEROS_PAR_BLOC ;
  if (0 <= numRel && numRel < NUMEROS_PAR_BLOC * NUMEROS_PAR_BLOC) {
    BLOC b ;
    NUM_BLOC premier_niveau = numRel / NUMEROS_PAR_BLOC ;
    
    numRel %= NUMEROS_PAR_BLOC ;
    if (inoeud->double_indirect == NUM_NULL)
      return NUM_NULL ;
    vol_lire (inoeud->double_indirect, b.opaque) ;
    if (b.blocs [premier_niveau] == NUM_NULL)
      return NUM_NULL ;
    vol_lire (b.blocs [premier_niveau], b.opaque) ;
    return b.blocs [numRel] ;
  } else {
    erreur = ACCES_FICHIER_HORS_LIMITE ;
    return NUM_NULL ;
  }
}

static NUM_BLOC allouer_numero_logique (NUM_BLOC numRel,
					INOEUD_OCCUPE *inoeud) 
     /* retrouve ou alloue un numero logique de bloc (pour une ecriture)
      * construit eventuellement les blocs d'indirection
      *
      * retourne 0 si plus de place
      */
{
  BLOC b ;
  
  if (0 <= numRel  &&  numRel < NB_BLOCS_DIRECTS) {
    if (inoeud->direct [numRel] == NUM_NULL) {
      inoeud->direct [numRel] = allouer_bloc () ;
    }
    return inoeud->direct [numRel] ;
  }
  
  numRel -= NB_BLOCS_DIRECTS ;
  if (0 <= numRel && numRel < NUMEROS_PAR_BLOC) {
    if (inoeud->indirect == NUM_NULL) {
      if ((inoeud->indirect = allouer_bloc ()) == NUM_NULL)
	return NUM_NULL ;
      bzero (&b, BLOC_SIZE) ;
    } else {
      vol_lire (inoeud->indirect, b.opaque) ;
    }
    if (b.blocs [numRel] == NUM_NULL) {
      b.blocs [numRel] = allouer_bloc () ;
      vol_ecrire (inoeud->indirect, b.opaque) ;
    }
    return b.blocs [numRel] ;
  }
  
  numRel -= NUMEROS_PAR_BLOC ;
  if (0 <= numRel && numRel < NUMEROS_PAR_BLOC * NUMEROS_PAR_BLOC) {
    NUM_BLOC premier_niveau = numRel / NUMEROS_PAR_BLOC ;
    NUM_BLOC second ;
    
    numRel %= NUMEROS_PAR_BLOC ;
    if (inoeud->double_indirect == NUM_NULL) {
      if ((inoeud->double_indirect = allouer_bloc ()) == NUM_NULL)
	return NUM_NULL ;
      bzero (&b, BLOC_SIZE) ;
    } else {
      vol_lire (inoeud->double_indirect, b.opaque) ;
    }
    second = b.blocs [premier_niveau] ;
    if (second == NUM_NULL) {
      second = b.blocs [premier_niveau] = allouer_bloc () ;
      vol_ecrire (inoeud->double_indirect, b.opaque) ;
      if (second == NUM_NULL) return NUM_NULL ;
      bzero (&b, BLOC_SIZE) ;
    } else {
      vol_lire (second, b.opaque) ;
    }
    if (b.blocs [numRel] == NUM_NULL) {
      b.blocs [numRel] = allouer_bloc () ;
      vol_ecrire (second, b.opaque) ;
    }
    return b.blocs [numRel] ;
  } else {
    erreur = ACCES_FICHIER_HORS_LIMITE ;
    return NUM_NULL ;
  }
}

int lire_bloc (INOMBRE i_nombre, BLOC *b, NUM_BLOC numRel)
     /* lit le ieme bloc du inoeud  on suppose que le fichier a une taille
      * suffisante
      */
{
  NUM_BLOC numLog ;
  INOEUD inoeud ;
  int nb_eff ;
  
  lire_inoeud (i_nombre, &inoeud) ;
  
  nb_eff = inoeud.occupe.taille - numRel*BLOC_SIZE ;
  if (nb_eff <= 0) return 0 ;
  if (nb_eff > BLOC_SIZE) nb_eff = BLOC_SIZE ;
  
  numLog = get_numero_logique (numRel, &inoeud.occupe) ;
  
  if (numLog == 0) {
    if (erreur == OK) bzero (b, BLOC_SIZE) ;
    else return -1 ;
  } else {
    vol_lire (numLog, b->opaque) ;
  }
  return nb_eff ;
}

int ecrire_bloc (INOMBRE i_nombre, BLOC *b, NUM_BLOC numRel, u_short lg)
{
  NUM_BLOC numLog ;
  BLOC ib ;
  INOEUD_OCCUPE *inoeud = &ib.inoeuds [INDICE (i_nombre)].occupe ;
  int nouvelle_taille ;
  
  lire_inoeuds (i_nombre, ib.opaque) ;
  nouvelle_taille = BLOC_SIZE*numRel + lg ;
  
  numLog = allouer_numero_logique (numRel, inoeud) ;
  if (numLog == NUM_NULL) {
    if (erreur == OK) return 0 ;
    else return -1 ;
  }
  if (nouvelle_taille > inoeud->taille) inoeud->taille = nouvelle_taille ;
  ecrire_inoeuds (i_nombre, ib.opaque) ;
  vol_ecrire (numLog, b->opaque) ;
  return lg ;
}


static INOMBRE chercher (ENTREE *e, const char *nom)
{
  int n = 0 ;
  
  while (n < ENTREES_PAR_BLOC) {
    if (e->i_nombre != NUM_NULL && ! strncmp (e->nom, nom, LONGMAXNOM))
      return e->i_nombre ;
    e++, n++ ;
  }
   return NUM_NULL ;
}

static int effacer (ENTREE *e, const char *simple)
{
  int n = 0 ;
  
  while (n < ENTREES_PAR_BLOC) {
    if (e->i_nombre != NUM_NULL && ! strncmp (e->nom, simple, LONGMAXNOM)) {
      e->i_nombre = NUM_NULL ;
      return 1 ;
    }
    e++, n++ ;
  }
  return 0 ;
}

static void initialiser_entrees (ENTREE *e)
{
  int n = 0 ;
   
  while (n < ENTREES_PAR_BLOC) {
    e [n].i_nombre = NUM_NULL ;
    strncpy (e [n].nom, "UNUSED", LONGMAXNOM) ;
    n++ ;
  }
}

static int creer (ENTREE *e, INOMBRE i_nombre, const char *nom)
{
  int n =  0 ;

  while (n < ENTREES_PAR_BLOC) {
    if (e [n].i_nombre == NUM_NULL) {
      e [n].i_nombre = i_nombre ;
      strncpy (e [n].nom, nom, LONGMAXNOM) ;
      return 1 ;
    }
    n++ ;
  }
  return 0 ;
}

INOMBRE chercher_entree (INOMBRE irep, const char *simple)
{
  NUM_BLOC n = 0 ;
  INOEUD rep ;
  u_long reste ;
  INOMBRE i_nombre = NUM_NULL ;
  
  lire_inoeud (irep, &rep) ;
  if (rep.occupe.type != REPERTOIRE) return NUM_NULL ;
  reste = rep.occupe.taille ;
  while (reste) {
    BLOC b ;
    
    lire_bloc (irep, &b, n) ;
    if ((i_nombre = chercher (b.entrees, simple)) != NUM_NULL) break ;
    n++ ; reste -= BLOC_SIZE ;
  }
  return i_nombre ;
}

static int effacer_entree (INOMBRE irep, INOEUD_OCCUPE *rep, const
			   char *simple) 
{
  NUM_BLOC n = 0 ;
  u_long reste ;
  
  reste = rep->taille ;
  while (reste) {
    BLOC b ;
    
    lire_bloc (irep, &b, n) ;
    if (effacer (b.entrees, simple)) {
      ecrire_bloc (irep, &b, n, BLOC_SIZE) ;
      return 1 ;
    }
    n++ ; reste -= BLOC_SIZE ;
  }
  return 0 ;
}

static int nombre_d_entrees_interne (ENTREE *e)
{
  int n = 0 ;
  int nb = 0 ;
  
  while (n < ENTREES_PAR_BLOC) {
    if (e->i_nombre != NUM_NULL) nb++ ;
    e++, n++ ;
  }
  return nb ;
}

static int nombre_d_entrees (INOMBRE irep, INOEUD_OCCUPE *rep)
{
   NUM_BLOC n = 0 ;
   u_long reste ;
   int nb = 0 ;

   reste = rep->taille ;  
   while (reste) {
      BLOC b ;

      lire_bloc (irep, &b, n) ;
      nb += nombre_d_entrees_interne (b.entrees) ;
      n++ ; reste -= BLOC_SIZE ;
   }
   return nb ;
}

static void incrementer_liens (INOMBRE i_nombre)
{
   BLOC b ;
   INOEUD_OCCUPE *inoeud = &b.inoeuds [INDICE (i_nombre)].occupe ;

   lire_inoeuds (i_nombre, b.opaque) ;
   inoeud->liens++ ;
   ecrire_inoeuds (i_nombre, b.opaque) ;
}

static void decrementer_liens (INOMBRE i_nombre)
{
   BLOC b ;
   INOEUD_OCCUPE *inoeud = &b.inoeuds [INDICE (i_nombre)].occupe ;

   lire_inoeuds (i_nombre, b.opaque) ;
   inoeud->liens-- ;
   ecrire_inoeuds (i_nombre, b.opaque) ;
}

static int creer_entree (INOMBRE irep, INOMBRE isimple, const char *simple)
{
   NUM_BLOC n = 0 ;
   u_long reste ;
   BLOC b ;
   INOEUD rep ;

   lire_inoeud (irep, &rep) ;
   reste = rep.occupe.taille ;
   while (reste) {
      int e ;

      lire_bloc (irep, &b, n) ;
      if (creer (b.entrees, isimple, simple)) {
         ecrire_bloc (irep, &b, n, BLOC_SIZE) ;
         incrementer_liens (isimple) ;
         return 0 ;
      }
      n++ ; reste -= BLOC_SIZE ;
   }

   initialiser_entrees (b.entrees) ;
   creer (b.entrees, isimple, simple) ;
   if (ecrire_bloc (irep, &b, n, BLOC_SIZE) != BLOC_SIZE) return -1 ;
   incrementer_liens (isimple) ;
   return 0 ;
}

int creer_entree_ordinaire (INOMBRE irep, INOMBRE isimple, const char *simple)
{
   INOEUD rep, nsimple ;

   lire_inoeud (irep, &rep) ;

   if (rep.occupe.type != REPERTOIRE) {
      erreur = PAS_UN_REPERTOIRE ; return -1 ;
   }

   if (chercher_entree (irep, simple)) {
      erreur = EXISTE_DEJA ; return -1 ;
   }

   lire_inoeud (isimple, &nsimple) ;
   if (nsimple.occupe.type != ORDINAIRE) {
      erreur = PAS_UN_ORDINAIRE ; return -1 ;
   }

   return creer_entree (irep, isimple, simple) ;
}

static INOMBRE creer_inoeud (enum CATEGORIE t)
{
   INOMBRE i_nombre ;
   BLOC b ;

/* message ("creer_inoeud") ; */

   i_nombre = allouer_inoeud () ;
   if (i_nombre == NUM_NULL) return i_nombre ;

   lire_inoeuds (i_nombre, b.opaque) ;
   {
      INOEUD_OCCUPE *in = & b.inoeuds [INDICE (i_nombre)].occupe ;
      int i ;

      in->type = t ;
      in->liens = 0 ;
      in->taille = 0 ;
      for (i = 0 ; i < NB_BLOCS_DIRECTS ; i++) {
	 in->direct [i] = NUM_NULL ;
      }
      in->double_indirect = in->indirect = NUM_NULL ;
   }
   ecrire_inoeuds (i_nombre, b.opaque) ;
   return i_nombre ;
}

INOMBRE creer_inoeud_ordinaire (void)
{
   return creer_inoeud (ORDINAIRE) ;
}

static void liberer_recursif (int prof, NUM_BLOC n)
{
   if (n == NUM_NULL) return ;
   if (prof > 0) {
      BLOC b ;
      int i ;

      vol_lire (n, b.opaque) ;
      for (i = 0 ; i < NUMEROS_PAR_BLOC ; i++) {
	 liberer_recursif (prof-1, b.blocs [i]) ;
      }
   }
   liberer_bloc (n) ;
}

static void vider_inoeud_interne (INOEUD_OCCUPE *inoeud)
/* libere tous les blocs du inoeud */
{
   int n ;

   for (n = 0 ; n < NB_BLOCS_DIRECTS ; n++) {
      liberer_recursif (0, inoeud->direct [n]) ;
      inoeud->direct [n] = NUM_NULL ;
   }
   liberer_recursif (1, inoeud->indirect) ;
   inoeud->indirect = NUM_NULL ;
   liberer_recursif (2, inoeud->double_indirect) ;
   inoeud->double_indirect = NUM_NULL ;
   inoeud->taille = 0 ;
}

int creer_entree_repertoire (INOMBRE irep, const char *simple)
{
   INOEUD rep ;
   INOMBRE isimple ;

   lire_inoeud (irep, &rep) ;

   if (rep.occupe.type != REPERTOIRE) {
      erreur = PAS_UN_REPERTOIRE ; return -1 ;
   }

   if (chercher_entree (irep, simple)) {
      erreur = EXISTE_DEJA ; return -1 ;
   }

   if ((isimple = creer_inoeud (REPERTOIRE)) == NUM_NULL) return -1 ;

   if (creer_entree (isimple, isimple, ".") == -1 ||
       creer_entree (irep, isimple, simple) == -1
   ) {
      INOEUD nsimple ;

      lire_inoeud (isimple, &nsimple) ;
      vider_inoeud_interne (&nsimple.occupe) ;
      liberer_inoeud (isimple) ;
      return -1 ;
   }

   creer_entree (isimple, irep, "..") ; /* en principe celui-la doit marcher */
   return 0 ;
}

int vider_inoeud_ordinaire (INOMBRE i_nombre)
/* libere tous les blocs du inoeud */
{
   BLOC b ;
   INOEUD_OCCUPE *inoeud = &b.inoeuds [INDICE (i_nombre)].occupe ;

   lire_inoeuds (i_nombre, b.opaque) ;
   if (inoeud->type != ORDINAIRE) {
      erreur = PAS_UN_ORDINAIRE ;
      return -1 ;
   }
   vider_inoeud_interne (inoeud) ;

   ecrire_inoeuds (i_nombre, b.opaque) ;
   return 0 ;
}

int supprimer_entree_ordinaire (INOMBRE irep, const char *simple)
{
   BLOC b ;
   INOEUD rep, nsimple ;
   INOMBRE isimple ;

   lire_inoeud (irep, &rep) ;
   if (rep.occupe.type != REPERTOIRE) {
      erreur = PAS_UN_REPERTOIRE ;
      return -1 ;
   }

   if ((isimple = chercher_entree (irep, simple)) == NUM_NULL) {
      erreur = FICHIER_INEXISTANT ; return -1 ;
   }

   lire_inoeud (isimple, &nsimple) ;
   if (nsimple.occupe.type != ORDINAIRE) {
      erreur = PAS_UN_ORDINAIRE ; return -1 ;
   }

   effacer_entree (irep, &rep.occupe, simple) ;

   if (--nsimple.occupe.liens == 0) {
      vider_inoeud_interne (&nsimple.occupe) ;
      liberer_inoeud (isimple) ;
   } else {
      decrementer_liens (isimple) ;
   }
   return 0 ;
}

int supprimer_entree_repertoire (INOMBRE irep, const char *simple)
{
   BLOC b ;
   INOEUD rep, nsimple ;
   INOMBRE isimple ;

   lire_inoeud (irep, &rep) ;
   if (rep.occupe.type != REPERTOIRE) {
      erreur = PAS_UN_REPERTOIRE ;
      return -1 ;
   }

   if ((isimple = chercher_entree (irep, simple)) == NUM_NULL) {
      erreur = REPERTOIRE_INEXISTANT ; return -1 ;
   }

   if (est_en_pile (isimple)) {
      erreur = REPERTOIRE_ACTIF ; return -1 ;
   }

   lire_inoeud (isimple, &nsimple) ;
   if (nsimple.occupe.type != REPERTOIRE) {
      erreur = PAS_UN_REPERTOIRE ; return -1 ;
   }

   if (nombre_d_entrees (isimple, &nsimple.occupe) != 2) {
      erreur = REPERTOIRE_NON_VIDE ; return -1 ;
   }

   effacer_entree (irep, &rep.occupe, simple) ;

   decrementer_liens (irep) ;

   vider_inoeud_interne (&nsimple.occupe) ;
   liberer_inoeud (isimple) ;
   return 0 ;
}

#define MIN(a, b) ((a) < (b) ? (a) : (b))

INOMBRE localiser (const char *nom)
/* nom peut etre
 * absolu (il commence par '/') ou relatif (on commence la recherche
 * sur sommet()
 */
{
   char simple [LONGMAXNOM+1] ;
   INOMBRE i_cour = sommet () ;

   if (*nom == '/') {
      nom++ ; i_cour = I_ROOT ;
   }
   while (*nom) {
      if (*nom != '/') {
         const char *POS = strchr (nom, '/') ;
         const int LG = POS ? POS - nom : strlen (nom) ;
         INOEUD rep ;

         lire_inoeud (i_cour, &rep) ;

         if (rep.occupe.type != REPERTOIRE) {
            erreur = PAS_UN_REPERTOIRE ; return NUM_NULL ;
         }

         strncpy (simple, nom, MIN (LONGMAXNOM, LG)) ;
         simple [MIN (LONGMAXNOM, LG)] = 0 ;
         i_cour = chercher_entree (i_cour, simple) ;
         if (i_cour == NUM_NULL) {
            erreur = FICHIER_INEXISTANT ; return NUM_NULL ;
         }
         nom += LG ;
         if (*nom == 0) break ;
      }
      nom ++ ;
   }
   return i_cour ;
}

int changer_de_chemin_courant (const char *nom)
/* nom peut etre
 * absolu (il commence par '/') ou relatif (on commence la recherche
 * sur sommet()
 */
{
   {
      INOEUD rep ;
      INOMBRE cible = localiser (nom) ;

      if (cible == NUM_NULL) return -1 ;
      lire_inoeud (cible, &rep) ;

      if (rep.occupe.type != REPERTOIRE) {
	 erreur = PAS_UN_REPERTOIRE ; return -1 ;
      }
   }

   if (*nom == '/') {
      nom++ ; vider() ; empiler (I_ROOT) ;
   }
   while (*nom) {
      if (*nom != '/') {
	 const char *POS = strchr (nom, '/') ;
	 const int LG = POS ? POS - nom : strlen (nom) ;
	 char simple [LONGMAXNOM+1] ;

	 strncpy (simple, nom, MIN (LONGMAXNOM, LG)) ;
	 simple [MIN (LONGMAXNOM, LG)] = 0 ;
	 if (!strcmp (simple, ".")) {
	    ;
	 } else if (!strcmp (simple, "..")) {
	    if (sommet () != I_ROOT) depiler () ;
	 } else {
	    empiler (chercher_entree (sommet(), simple)) ;
	 }
         nom += LG ;
         if (*nom == 0) break ;
      }
      nom ++ ;
   }
   return 0 ;
}

int monter (const char *fs)
{
   if (vol_monter (fs) == -1) return -1 ;
   {
      BLOC super ;

      vol_lire (SUPER, super.opaque) ;
      if (super.super_bloc.magique [0] != 0x55) {
         erreur = PAS_UN_SYSTEME_DE_FICHIERS ;
         vol_demonter () ;
         return -1 ;
      }
   }
   empiler (I_ROOT) ;
   return 0 ;
}

int demonter (void)
{
   if (vol_demonter () == -1) return -1 ;
   vider () ;
   return 0 ;
}

int fairefs (const char *nom, u_short nb_blocs, u_short nb_inoeuds)
/* il faut au moins de la place pour . et .. */
{
/* quelques info ... */
   printf ("sizeof (NUM_BLOC) = %lu\n", sizeof (NUM_BLOC)) ;
   printf ("sizeof (INOMBRE)  = %lu\n", sizeof (INOMBRE)) ;
   printf ("INOEUDS_PAR_BLOC  = %lu\n", INOEUDS_PAR_BLOC) ;
   printf ("NUMEROS_PAR_BLOC  = %lu\n", NUMEROS_PAR_BLOC) ;
   printf ("ENTREES_PAR_BLOC  = %lu\n", ENTREES_PAR_BLOC) ;
/* le bloc 0 (boot) est inutilise */

   if (BLOC_SIZE != sizeof (BLOC)) {
      fprintf (stderr, "BLOC_SIZE est different de sizeof (BLOC) !\n") ;
      return -1 ;
   }
   printf ("%lu..%lu : blocs de la table des inoeuds,\n%lu blocs utilisables\n%ld taille totale (octets)\n",
	   IBLOC (0),
	   IBLOC (nb_inoeuds),
	   nb_blocs - (IBLOC (nb_inoeuds) + 1),
           nb_blocs * (long) BLOC_SIZE) ;

   if (IBLOC (nb_inoeuds) + 1 + 1 > nb_blocs || nb_inoeuds <= I_ROOT) {
      fprintf (stderr, "parametres de taille incompatible\n") ;
      return -1 ;
   }
   if (vol_debut_creer (nom) == -1) return -1 ;
   {
       BLOC super ;
       SUPER_BLOC *s = &super.super_bloc ;

       s->nb_blocs = nb_blocs ;
       s->nb_inoeuds = nb_inoeuds ;
       s->i_contigu = I_ROOT ; /* I_ROOT est reserve pour la racine */
       s->i_chaine  = NUM_NULL ;
       s->b_contigu = IBLOC (nb_inoeuds) + 1 ;
       s->b_chaine  = NUM_NULL ;
       s->magique [0] = 0x55 ;

       vol_ecrire (SUPER, super.opaque) ;
   }
   {
       BLOC inoeuds ;
       int i ;

       for (i = SUPER+1 ; i <= IBLOC (nb_inoeuds) ; i++) {
	  vol_ecrire (i, inoeuds.opaque) ;
       }
   }
   {
      INOMBRE i_root = creer_inoeud (REPERTOIRE) ; /* doit allouer I_ROOT !! */

      if (i_root != I_ROOT) {
	 fprintf (stderr, "Le noeud racine n'est pas I_ROOT !\n") ;
         return -1 ;
      }
      creer_entree (i_root, i_root, ".") ;
      creer_entree (i_root, i_root, "..") ;
   }
   vol_fin_creer () ;
   return 0 ;
}
