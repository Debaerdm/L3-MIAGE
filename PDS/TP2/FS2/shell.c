/*
 * shell.c  (C) P.Durif
 */
static const char *WHAT_STRING = "@(#)shell.c	1.2 (C) P. Durif 1994" ;
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include "erreurs.h"
#include "fs.h"
#include "fichier.h"

void usage (void)
{
  printf ("usage: shell [nom_de_volume]\n") ;
}

struct CMD {
  char *nom ;
  void (*fun) (struct CMD *c) ;
  char *commentaire ;
} ;

void df (struct CMD *c) ;
void fsck (struct CMD *c) ;

void ls (struct CMD *c) ;
void cd (struct CMD *c) ;
void md (struct CMD *c) ;
void rd (struct CMD *c) ;

void cp (struct CMD *c) ;
void rm (struct CMD *c) ;
void mv (struct CMD *c) ;
void ln (struct CMD *c) ;
void cat (struct CMD *c) ;
void import (struct CMD *c) ;
void export (struct CMD *c) ;

void help (struct CMD *c) ;
void inconnu (struct CMD *c) ;
void yes(struct CMD *c);

struct CMD CMDS [] = {
  /* nlle commandes pour le TP */
  {"df", df,     "                   -- affiche etat utilisation du systeme"},
  {"fsck", fsck,     "                   -- teste le systeme de fichiers"},
  
  /* manipulationde repertoire */
  {"ls", ls,     "nom                -- listage de fichier, format :\n"
                 "\t                   -- i-nombre categorie liens taille nom"},
   {"cd", cd,    "nom                -- changer de repertoire courant"},
   {"mkdir", md, "nom                -- creer un repertoire"},
   {"rmdir", rd, "nom                -- detruire un repertoire vide"},

  /* manipulations de fichiers */
   {"cp", cp,    "source cible       -- copie de fichier"},
   {"rm", rm,    "nom                -- destruction de fichier"},
   {"mv", mv,    "ancien nouveau     -- mouvement de fichier"},
   {"ln", ln,    "cible nouveau      -- creation de lien"},
   {"cat", cat,  "nom                -- visualisation de fichier"},
   {"import", import,
                 "nom_unix nom_local -- importe un fichier depuis Unix"},
   {"export", export,
                 "nom_local nom_unix -- exporte un fichier vers Unix"},

   {"help", help,
                 "                   -- aide en ligne"},
   {0,    inconnu, "-- commande inconnue (tapez help pour une liste)"},
   {"yes", yes, "                    -- while infinie LOOOOl"},
} ;

void executer (const char *nom)
{
  struct CMD *p = CMDS ;
  
  while (p->nom && strcmp (nom, p->nom)) p++ ;
  (* p->fun) (p) ;
}

void dialoguer (void)
{
  char nom [100] ;
  
  while (printf ("> "), scanf ("%s", nom) == 1) {
    executer (nom) ;
  }
}

int main (int argc, char *argv [])
{
  char * volume = "root" ;
  
  if (argc == 1) volume = "root" ;
  else if (argc == 2) volume = argv [1] ;
  else {
    usage () ; exit (1) ;
  }
  if (monter (volume) == -1) {
    perreur (volume) ; exit (1) ;
  }
  dialoguer () ;
  demonter () ;
  return 1 ;
}

/* manipulations de repertoires */

static void imprime (const char *nom, const char *simple)
{
   INFO info ;
   
   get_info (nom, &info) ;
   printf ("%5d %c %3d%6d %s\n",
	   info.i_nombre,
	   info.type == REPERTOIRE ? 'd' :
	   info.type == ORDINAIRE  ? '-' : '?',
	   info.liens,
	   info.taille,
	   simple
	   ) ;
}

void ls (struct CMD *c)
{
  char arg [300] ;
  INFO info ;
  
  scanf ("%s", arg) ;
  if (get_info (arg, &info) == -1) {
    perreur (arg) ; return ;
  }
  if (info.type == ORDINAIRE) {
    imprime (arg, arg) ;
  } else if (info.type == REPERTOIRE) {
    FICHIER *f ;
    ENTREE e ;
    unsigned offset = strlen (arg), pos = offset ;
    
    if ((f = ouvrir (arg, LECTURE, OUVERTURE)) == 0) {
      perreur (arg) ; return ;
    }
    
    if (pos && arg [pos - 1] != '/') arg [pos]='/', pos++ ;
    
    while (lire (f, &e, sizeof (ENTREE)) == sizeof (ENTREE)) {
      if (e.i_nombre != NUM_NULL) {
	strcpy (arg+pos, e.nom) ; 
	imprime (arg, e.nom) ; 
      }
    }
    arg [offset] = 0 ;
    fermer (f) ;
  } else {
    fprintf (stderr, "%s : categorie de fichier inconnue !!\n", arg) ;
    exit (1) ;
  }
}

void cd (struct CMD *c)
{
  char arg [300] ;
  
  scanf ("%s", arg) ;
  if (changer_de_chemin_courant (arg) == -1) perreur (arg) ;
}

void md (struct CMD *c)
{
   char arg [300] ;
   
   scanf ("%s", arg) ;
   if (creer_repertoire (arg) == -1) perreur (arg) ;
}

void rd (struct CMD *c)
{
  char arg [300] ;
  
  scanf ("%s", arg) ;
  if (detruire_repertoire (arg) == -1) perreur (arg) ;
}


/* Nlles commandes pour le TP */
void df (struct CMD *c)
{
  extern void fs_df (void) ; 
  fs_df () ;
}

void fsck (struct CMD *c)
{
  extern void fs_fsck (void) ; 
  fs_fsck () ;
}

/* manipulations de fichiers */

void cp (struct CMD *c)
{
  char source [300], cible[300] ;
  FICHIER *fsource, *fcible ;
  
  scanf ("%s%s", source, cible) ;
  if ((fsource = ouvrir (source, LECTURE, OUVERTURE)) == 0) {
    perreur (source) ; return ;
  }
  if ((fcible = ouvrir (cible, ECRITURE, CREATION)) == 0) {
    perreur (cible) ; fermer (fsource) ; return ;
  }
  {
    char buf [512] ; int lg ;
    
    while ((lg = lire (fsource, buf, 512)) > 0)
      if (ecrire (fcible, buf, lg) == -1) {
	perreur ("ecrire()") ; break ;
      }
  }
  fermer (fsource) ;
  fermer (fcible) ;
}

void yes (struct CMD *c){
    char line[300];
    scanf("%s", line);
    while(1) {
        printf("yes %s", line);
    }
}

void rm (struct CMD *c)
{
  char fichier [300] ;
  
  scanf ("%s", fichier) ;
  if (detruire_lien (fichier) == -1) perreur (fichier) ;
}

void mv (struct CMD *c)
{
  char cible [300], nouveau_lien [300] ;
  
  scanf ("%s%s", cible, nouveau_lien) ;
  if (creer_lien (nouveau_lien, cible) == -1) {
    char mess [800] ;
    
    sprintf (mess, "creer_lien (%s, %s)", nouveau_lien, cible) ;
    perreur (mess) ; return ;
  }
  detruire_lien (cible) ;
}

void ln (struct CMD *c)
{
  char nouveau_lien [300], cible[300] ;
  
  scanf ("%s%s", cible, nouveau_lien) ;
  if (creer_lien (nouveau_lien, cible) == -1) perreur ("creer_lien()") ;
}

void cat (struct CMD *c)
{
  char fichier [300] ;
  FICHIER *f ;
  
  scanf ("%s", fichier) ;
  if ((f = ouvrir (fichier, LECTURE, OUVERTURE)) == 0) {
    perreur (fichier) ; return ;
  }
  {
    char buf [512] ; int lg ;
    
    while ((lg = lire (f, buf, 512)) > 0)
      write (1, buf, lg) ;
    if (lg == -1) perreur ("lire()") ;
  }
  fermer (f) ;
}

void import (struct CMD *c)
{
  char funix [300], ffs [300] ;
  FILE *fu ;
  FICHIER *f ;
  
  scanf ("%s%s", funix, ffs) ;
  if ((fu = fopen (funix, "r")) == 0) {
    perror (funix) ; return ;
  }
  if ((f = ouvrir (ffs, ECRITURE, CREATION)) == 0) {
    perreur (ffs) ; fclose (fu) ; return ;
  }
  {
    char buf [512] ; int lg ;
    
    while ((lg = fread (buf, 1, 512, fu)) > 0)
      if (ecrire (f, buf, lg) == -1) {
	perreur ("ecrire()") ; break ;
      }
  }
  fermer (f) ; fclose (fu) ;
}

void export (struct CMD *c)
{
  char funix [300], ffs [300] ;
  
  scanf ("%s%s", ffs, funix) ;
  printf ("non implemente\n") ;
}

void help (struct CMD *c)
{
  struct CMD *p = CMDS ;
  
  while (p->nom) {
    printf ("%s\t%s\n", p->nom, p->commentaire) ;
    p++ ;
  }
}

void inconnu (struct CMD *c)
{
  printf ("%s\n", c->commentaire) ;
}
