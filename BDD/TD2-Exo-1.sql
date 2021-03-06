create table auteur (
    id_auteur number(10) not null,
    nom varchar2(20),
    prenom varchar2(20),
    constraint auteur_pk primary key(id_auteur)
);

create table editeur(
    id_editeur number(10) not null,
    nom varchar(50),
    constraint editeur_pk primary key(id_editeur)
);

create table Livre (
    ref_livre number(10) not null,
    titre varchar2(50),
    id_editeur number(10),
    constraint livre_editeur_fk foreign key(id_editeur) references editeur(id_editeur),
    constraint livre_pk primary key(ref_livre)
);

create table ecrit(
    id_auteur number(10),
    ref_livre number(10),
    constraint ecrit_auteur_fk foreign key(id_auteur) references auteur(id_auteur),
    constraint ecrit_livre_fk foreign key(ref_livre) references livre(ref_livre),
    constraint ecrit_pk primary key(id_auteur, ref_livre)

);

create table diplome (
    code number(10) not null,
    libelle varchar2(50),
    constraint diplome_pk primary key(code)
);

create table matiere(
    mno number(10) not null,
    titre varchar2(50),
    code number(10),
    constraint matiere_diplome_fk foreign key(code) references diplome(code),
    constraint matiere_pk primary key(mno, code)
);

create table enseignant(
    id_enseignant number(10) not null,
    nom varchar2(20),
    prenom varchar2(20),
    telephone number(10),
    email varchar2(40),
    constraint enseignant_pk primary key (id_enseignant)
);

create table conseil(
    ref_livre number(10),
    mno number(10),
    code number(10),
    id_enseignant number(10),
    constraint conseil_livre_fk foreign key (ref_livre) references livre(ref_livre),
    constraint conseil_matiere_fk foreign key (mno, code) references matiere(mno, code),
    constraint conseil_enseignant_fk foreign key (id_enseignant) references enseignant(id_enseignant),
    constraint conseil_pk primary key (ref_livre,mno,code)
);

insert into editeur values(1, 'Editions Eyrolles');
insert into editeur values(2, 'Edition O''Reilly');
insert into editeur values(3, 'Editions Générales First');

insert into auteur values(1, 'Soutou', 'Christian');
insert into auteur values(2, 'Teste', 'Olivier');
insert into auteur values(3, 'Freeman', 'Eric');
insert into auteur values(4, 'Freeman', 'Elisabeth');
insert into auteur values(5, 'Engels', 'Jean');
insert into auteur values(6, 'Rigaux', 'Philippe');
insert into auteur values(7, 'Fabre', 'Fabien');

insert into livre values(1, 'SQL pour Oracle', 1);
insert into livre values(2, 'Design Patterns, Tête la première', 2);
insert into livre values(3, 'PHP5 cours et exercices', 1);
insert into livre values(4, 'MySQL et PHP', 2);
insert into livre values(5, 'Les Bases de données pour les nuls', 3);

insert into ecrit values(1,1);
insert into ecrit values(2,1);
insert into ecrit values(3,2);
insert into ecrit values(4,2);
insert into ecrit values(5,3);
insert into ecrit values(6,4);
insert into ecrit values(7,5);

insert into enseignant(id_enseignant, nom, prenom) values(1, 'Caron','Anne-Cécile');
insert into enseignant(id_enseignant, nom, prenom) values(2, 'Bogaert','Bruno');
insert into enseignant(id_enseignant, nom, prenom) values(3, 'Roos', 'Yves');

insert into diplome values(123456, 'Licence MIAGE');
insert into diplome values(123232, 'L2 informatique');

insert into matiere values(1, 'Base de données', 123456);
insert into matiere values(2, 'CDAW', 123456);
insert into matiere values(3, 'Technologie du web', 123232);
insert into matiere values(4, 'Conception Orientée Objet', 123456);

insert into conseil values(1, 1, 123456, 1);
insert into conseil values(5, 1, 123456, 1);
insert into conseil values(3, 2, 123456, 2);
insert into conseil values(4, 2, 123456, 2);
insert into conseil values(5, 2, 123456, 2);
insert into conseil values(3, 3, 123232, 2);
insert into conseil values(4, 3, 123232, 2);
insert into conseil values(5, 3, 123232, 2);
insert into conseil values(2, 4, 123456, 3);

select ref_livre, titre, nom from livre inner join editeur on livre.ID_EDITEUR = editeur.ID_EDITEUR;

select distinct nom, prenom from enseignant
where EMAIL is not null;

select livre.titre 
from livre 
  inner join ecrit on livre.REF_LIVRE = ecrit.REF_LIVRE 
  inner join auteur on ecrit.ID_AUTEUR = auteur.ID_AUTEUR
where auteur.NOM = 'Rigaux' and auteur.PRENOM = 'Philippe';

select distinct livre.titre 
from livre 
  inner join ecrit on livre.REF_LIVRE = ecrit.REF_LIVRE 
  inner join auteur on ecrit.ID_AUTEUR = auteur.ID_AUTEUR
where auteur.NOM like 'F%';

select livre.titre, count(auteur.nom)
from livre 
  inner join ecrit on livre.REF_LIVRE = ecrit.REF_LIVRE 
  inner join auteur on ecrit.ID_AUTEUR = auteur.ID_AUTEUR
group by auteur.NOM, livre.titre;

select AVG(count(*)) as nombre_moyen_auteurs
from livre 
  inner join ecrit on livre.REF_LIVRE = ecrit.REF_LIVRE 
  inner join auteur on ecrit.ID_AUTEUR = auteur.ID_AUTEUR
group by livre.titre;

select livre.ref_livre, livre.titre, count(conseil.ref_livre) as nb_livres
from livre inner join conseil on livre.REF_LIVRE = conseil.REF_LIVRE
group by livre.ref_livre, livre.titre;

select livre.ref_livre, livre.titre, count(conseil.ref_livre) as nb_livres
from livre inner join conseil on livre.REF_LIVRE = conseil.REF_LIVRE
group by livre.ref_livre, livre.titre
having count(mno) >= 3;

select livre.ref_livre, livre.titre
from livre
where livre.ref_livre not in (select conseil.ref_livre from conseil);

select editeur.nom, count(editeur.nom) 
from editeur natural join livre group by editeur.nom 
having count(editeur.nom) = (
select max(max_editeur) from (
select livre.id_editeur, count(*) max_editeur
from livre
group by livre.id_editeur));


select avg(count(conseil.ref_livre)) nb_moyen_conseil
from conseil
inner join enseignant 
on conseil.ID_ENSEIGNANT = enseignant.ID_ENSEIGNANT
group by enseignant.id_enseignant;

Select fi_titre, count(*) as nb FROM TD2_FILM Natural join TD2_SEANCE natural join TD2_ASSISTE  WHERE SE_AVIS = 'tres bon'
group by fi_titre having count(*) >= all (Select count(*) FROM TD2_FILM Natural join TD2_SEANCE natural join TD2_ASSISTE  WHERE SE_AVIS = 'tres bon'
    group by fi_titre);
