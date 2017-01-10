/*-* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
                                        Philippe Marquet --- <marquet@lifl.fr>
                                        05 Mar 1998
    File:  mkbadbloc.c

    Creation d'un systeme de fichiers avec erreurs pour test de fsck.
    
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

#ifndef lint
static const char *WHAT_STRING = "PhM, mar 1998" ;
#endif /* lint */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include "erreurs.h"
#include "fs.h"
#include "fichier.h"

/*
	% ./mkbadbloc
	sizeof (NUM_BLOC) = 2
	sizeof (INOMBRE)  = 2
	INOEUDS_PAR_BLOC  = 2
	NUMEROS_PAR_BLOC  = 32
	ENTREES_PAR_BLOC  = 4
	2..22 : blocs de la table des inoeuds,
	27 blocs utilisables
	3200 taille totale (octets)
	Systeme de fichiers inconsistant badbloc cree

	% ./shell badbloc
	> ls .
	    2 d   4    64 .
	    2 d   4    64 ..
	    3 d   2    64 tmp
	    4 d   2    64 var
	> ls tmp
	    3 d   2    64 .
	    2 d   4    64 ..
	    6 -   2   864 toto
	    7 -   1   240 tata
	> ls var
	    4 d   2    64 .
	    2 d   4    64 ..
	    6 -   2   864 titi
	>    
*/

int main(void)
{
  const char *volume = "badbloc" ;

  {
    u_short nb_blocs = 50 ;
    u_short nb_inoeuds = 40 ;
    
    fairefs (volume, nb_blocs, nb_inoeuds) ;
  }
  
  /* creation de quelques repertoires et fichiers */

  /* /tmp */
  if (creer_entree_repertoire (I_ROOT, "tmp") == -1) {
    fprintf (stderr, "Probleme de creation de /tmp !\n") ;
    exit (-1) ;
  }
  
  /* var */
  if (creer_entree_repertoire (I_ROOT, "var") == -1) {
    fprintf (stderr, "Probleme de creation de /var !\n") ;
    exit (-1) ;
  }
  
  /* /tmp/toto */
  {
    FICHIER *ftoto ;
    if ((ftoto = ouvrir ("/tmp/toto", ECRITURE, CREATION)) == 0) {
      perreur ("creation de /tmp/toto") ;
      exit (-1) ;
    }
    {
      char buf [] = "abcdefghijklmnopqrstuvwxyz\n" ;
      int i ;
      
      for (i=0 ; i< 18 ; i++) 
	if (ecrire (ftoto, buf, strlen (buf)) == -1) {
	  perreur ("ecriture de /tmp/toto") ;
	  exit (-1) ;
	}
    }
    fermer (ftoto) ;
  }

  /* on detruit /tmp/toto */
  if (detruire_lien ("/tmp/toto") == -1) {
    perreur ("destruction de /tmp/toto") ;
    exit (-1) ;
  }
  
  /* on recree /tmp/toto */
  {
    FICHIER *ftoto ;
    if ((ftoto = ouvrir ("/tmp/toto", ECRITURE, CREATION)) == 0) {
      perreur ("re-creation de /tmp/toto") ;
      exit (-1) ;
    }
    {
      char buf [] = "abcdefghijklmnopqrstuvwxyz\n" ;
      int i ;
      
      for (i=0 ; i<32  ; i++) 
	if (ecrire (ftoto, buf, strlen (buf)) == -1) {
	  perreur ("re-ecriture de /tmp/toto") ;
	  exit (-1) ;
	}
    }
    fermer (ftoto) ;
  }
     
  /* on cree un nouveau lien que l'on supprime */  
  if (creer_lien ("/var/null", "/tmp/toto") == -1) {
    perreur ("creation de /var/null") ;
    exit (-1) ;
  }
  if (detruire_lien ("/var/null") == -1) {
    perreur ("destruction de /var/null") ;
    exit (-1) ;
  }

  /* /var/titi est un lien sur /tmp/toto */
  if (creer_lien ("/var/titi", "/tmp/toto") == -1) {
    perreur ("creation de /var/titi") ;
    exit (-1) ;
  }

  /* on cree /tmp/tata */
  {
    FICHIER *ftata ;
    if ((ftata = ouvrir ("/tmp/tata", ECRITURE, CREATION)) == 0) {
      perreur ("creation de /tmp/tata") ;
      exit (-1) ;
    }
    {
      char buf [] = "0123456789*123456789+123456789" ;
      int i ;
      
      for (i=0 ; i<8 ; i++) 
	if (ecrire (ftata, buf, strlen (buf)) == -1) {
	  perreur ("ecriture de /tmp/tata") ;
	  exit (-1) ;
	}
    }
    fermer (ftata) ;
  }
  /* QQ problemes... */
  {
    BLOC super ;
    SUPER_BLOC *s = &super. super_bloc ;
    
    vol_lire (SUPER, super. opaque) ;

    /* Probleme dans la table des inoeud ! */
    {
      /*      s-> i_contigu-- ;       
	      s-> i_chaine  = NUM_NULL ; */
    }

    /* Les blocs aussi ont qq Pb ! */ 
    {
      /* Trois blocs libres ne le sont plus... */
      BLOC bloc ;
      NUM_BLOC n ; 
      int i ;

      n = s-> b_chaine ; 
      for (i=0 ; i<3 ; i++) {
	vol_lire (n, bloc. opaque) ;
	n = bloc. bloc_libre. b_suiv ;
      }
      s-> b_chaine = n ;
    }

    {
      /* /tmp/tata pert ses references vers qq blocs */
      BLOC bloc ;
      INOMBRE itata ;
      
      if (!(itata = localiser ("/tmp/tata"))) {
	perreur ("localisaton de /tmp/tata") ;
	exit (-1) ;	;
      }

      vol_lire (IBLOC(itata), bloc. opaque) ;
      bloc. inoeuds [INDICE (itata)]. occupe. direct [2] = NUM_NULL ;
      vol_ecrire (IBLOC(itata), bloc. opaque) ;  
    }

    {
      /* /tmp/toto des blocs de donnees references deux fois par le
	 meme inoeuds */
      BLOC bloc, ibloc ;
      INOMBRE itoto ; 

      if (!(itoto = localiser ("/tmp/toto"))) {
	perreur ("localisaton de /tmp/toto") ;
	exit (-1) ;	;
      }

      vol_lire (IBLOC(itoto), bloc. opaque) ;
      vol_lire (bloc. inoeuds [INDICE (itoto)]. occupe. indirect,
		ibloc. opaque) ;
      ibloc. blocs [2] =
	bloc. inoeuds [INDICE (itoto)]. occupe. direct [2] ; 
      vol_ecrire (bloc. inoeuds [INDICE (itoto)]. occupe. indirect,
		ibloc. opaque) ;
    }
    
    {
      /* le bloc d'indirection de /tmp/toto reference comme bloc de
	 donnees par /tmp/tata */
      BLOC btoto, btata ;
      INOMBRE itoto, itata ;

      if (!(itoto = localiser ("/tmp/toto"))) {
	perreur ("localisaton de /tmp/toto") ;
	exit (-1) ;	;
      }
      if (!(itata = localiser ("/tmp/tata"))) {
	perreur ("localisaton de /tmp/tata") ;
	exit (-1) ;	;
      }

      vol_lire (IBLOC(itoto), btoto. opaque) ;
      vol_lire (IBLOC(itata), btata. opaque) ;
      
      btata. inoeuds [INDICE (itata)]. occupe. direct [1] =
	btoto. inoeuds [INDICE (itoto)]. occupe. indirect ;
      vol_ecrire (IBLOC(itata), btata. opaque) ;
    }

    {
      /* Un bloc systeme reference par /tmp/toto comme des donnees */
      BLOC btoto ;
      INOMBRE itoto ; 

      if (!(itoto = localiser ("/tmp/toto"))) {
	perreur ("localisaton de /tmp/toto") ;
	exit (-1) ;	;
      } 

      vol_lire (IBLOC(itoto), btoto. opaque) ;
      btoto. inoeuds [INDICE (itoto)]. occupe. direct [3] = 6 ;
      vol_ecrire (IBLOC(itoto), btoto. opaque) ;

    }
    
    vol_ecrire (SUPER, super.opaque) ;
   }


  /* On termine ... */
  demonter () ;
  fprintf (stderr,
	   "Systeme de fichiers inconsistant %s cree\n",
	   volume) ;

  exit (0) ; 
}

