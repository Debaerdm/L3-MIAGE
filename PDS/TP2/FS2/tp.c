#include "tp.h"

void fs_df (void) {
    BLOC b;
    NUM_BLOC super_bloc_number = 1;
    if((vol_lire(super_bloc_number, b.opaque)) == -1){
        perror("vol_lire");
        exit(EXIT_FAILURE);
    }
    
    int nb = nb_blocs_libres(&b.super_bloc);
    int nb_blocs_max = b.super_bloc.nb_blocs;
    int nb_blocs_utilise = nb_blocs_max - nb;
    int capacite = (nb_blocs_utilise*100)/nb_blocs_max;
    printf("64-blocs utilises libres capacite\n");
    printf("%d\t %d\t  %d\t %d%%\n",nb_blocs_max, nb_blocs_utilise, nb, capacite);

    int nb_inoeud = nb_inoeuds_libres(&b.super_bloc);
    int nb_inoeuds_max = b.super_bloc.nb_inoeuds;
    int nb_inoeuds_utilise = nb_inoeuds_max - nb_inoeud;
    int capacite_inoeud = (nb_inoeuds_utilise*100)/nb_inoeuds_max;
    printf("inoeuds Iutilises Ilibres Icapacite\n");
    printf("%d\t%d\t  %d\t  %d%%\n", nb_inoeuds_max, nb_inoeuds_utilise, nb_inoeud, capacite_inoeud);
}

void fs_fsck(void){
    int i;
    BLOC b;
    NUM_BLOC super_bloc_number = 1;

    if((vol_lire(super_bloc_number, b.opaque)) == -1) {
        perror("vol_lire");
        exit(EXIT_FAILURE);
    }

    SUPER_BLOC super_bloc = b.super_bloc;

    b_check = malloc(super_bloc.nb_blocs * sizeof(BLOC_CHECK));
    
    for(i = 0; i < super_bloc.nb_blocs; i++){
        b_check[i].libre_chaine = 0;
        b_check[i].libre_contigu = 0;
        b_check[i].bloc_system = 0;
        b_check[i].nb_ref = 0;
    }
}

int nb_blocs_libres(SUPER_BLOC *s) {
    int nb = 0;
    NUM_BLOC num;
    BLOC b;

    nb += s->nb_blocs - s->b_contigu;

    num = s->b_chaine;

    while(num != NUM_NULL) {
        nb++;
        if((vol_lire(num, b.opaque)) == -1){
            perror("vol_lire");
            exit(EXIT_FAILURE);
        }

        num = b.bloc_libre.b_suiv;
    }

    return nb;
}

int nb_inoeuds_libres(SUPER_BLOC *s){
    int nb = 0;
    INOMBRE in;
    INOEUD inoeud;

    nb += s->nb_inoeuds - s->i_contigu;

    in = s->i_chaine;

    while(in != NUM_NULL) {
        nb++;
        if((lire_inoeud(in, &inoeud)) == -1){
            perror("lire_inoeuf");
            exit(EXIT_FAILURE);
        } 

        in = inoeud.libre.i_suiv;
    }

    return nb;
}

void mark_free_blocs(SUPER_BLOC *s) {}
