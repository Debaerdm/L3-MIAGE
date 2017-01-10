create table client (
    id number(5),
    nom varchar2(20),
    solde number(6,2),
    constraint client_pk primary key (id)
);

insert into client values (1, 'toto', 200.0);
insert into client values (2, 'titi', 20.0);
insert into client values (3, 'titi', 20.0);
insert into client values (5, 'tata', 120.0);
insert into client values (15, 'bof', 150.0);
insert into client values (16, 'bif', 150.0);

-- Connaître les tables et description d'une table --
select * from tab;
desc client;

-- Question 1.1 --
select solde from client;
select nom,solde from client;

-- SQL manipule aussi des ensembles. --

-- Question 1.2 --
select distinct solde from client;
select distinct nom,solde from client;
select distinct solde, nom from client;

-- Les distinct sert a supprimer les doublons --

-- Question 1.3 --
-- 1)
select nom from client where solde >= 150.0;
-- 2)
select nom from client where mod(id, 2) = 0;
-- 3)
select id, nom from client where nom like '%o%';

-- Question 1.4 --
insert into client values (20, 'riri', null);
insert into client(id, nom) values (21, 'fifi');
insert into client(id, solde) values (22, 150.0);

select * from client;

-- Il possède des values null dans les colonnes non informés.

-- Question 1.5 --
insert into client(nom) values ('loulou');

-- Le serveur nous autorise pas a inserer null, celà peut venir de la clef primaire car celui-ci ne peut être null.

-- Question 1.6 --
select count(*) from client;
select count(nom) from client;
select avg(solde) from client;

-- Les valeurs null ne sont pas pris en compte quand on selection une colonne précise.

-- I.I --

update client set solde = solde + 10.0;

-- Question 1.7 --
update client set solde = solde - 30.0, nom ='toto' where id = 2;

-- 1) Car on précise l'id du client ainsi que son nom mais comme l'id est unique cela ne modifiera que celui donné.

update client set solde = solde + 30.0
where solde between 100.0 and 180.0;
-- 2) Car on choisi un ensemble de valeurs il peut donc avec 0, 1 ou plusieurs solde dans cette intervalle.

-- Question 1.8 --
delete from client where id = 4;
delete from client where id = 1;

-- Aucun déclenche d'erreur alors que l'id 4 n'est pas inscrit dans la table.

-- A faire attention :
-- delete from client; Supprime toute les lignes de la table.
-- drop table client; Supprime la table.
-- flashback table client to before drop; Permet de recupere une table supprimer.
-- purge recyclebin; vide la corbeille.

-- II --

create table producteur (
      id number(5),
      nom varchar2 (20),
      constraint producteur_pk primary key (id)
);

create table produit (
     id number(5),
      nom varchar2(20),
      prix_unitaire number(8,2),
      producteur number(5),
      constraint produit_producteur_fk foreign key (producteur) references producteur(id),
      constraint produit_pk primary key(id)
);

insert into producteur values (1, 'Bricolot');
insert into producteur values (2, 'Fruit''n Fibre');
insert into produit(id, nom, prix_unitaire, producteur) values (1, 'clou', 11.0, 1);
insert into produit(id, nom, prix_unitaire, producteur) values (2, 'robinet', 30.0, 1);
insert into produit(id, nom, prix_unitaire, producteur) values (3, 'kiwi', 0.3, 2);

-- Question 2.1 --
-- 1)
select * from client, producteur;

-- 2)
select p1.*, p2.* from producteur p1 cross join producteur p2;

-- Question 2.2 --
-- 1)
select producteur.NOM as producteur_nom, produit.NOM as produit_nom
from producteur inner join produit on produit.ID = producteur.ID;

-- 2)
select p1.nom, p2.nom, p1.prix_unitaire, p2.prix_unitaire from 
produit p1 cross join produit p2 where p1.prix_unitaire < p2.prix_unitaire;

-- III --

create table Commande (
      idClient number(5),
      idProduit number(5),
      quantite number(5),
      constraint commande_pk primary key (idClient, idProduit),
      constraint Commande_client_fk foreign key (idClient) references client(id),
      constraint commande_produit_fk foreign key (idProduit) references produit(id)
);

insert into commande values (2 ,2 ,3);
insert into commande values (2 ,3 ,20);
insert into commande values (5 ,1 ,100);
insert into commande values (5 ,3 ,10);

-- Question 3.1 --
select client.nom, produit.nom, quantite 
from commande join client on client.ID = commande.IDCLIENT
join produit on commande.IDPRODUIT = produit.id;

-- Question 3.2 --
select client.nom from client inner join commande on client.id = commande.IDCLIENT;

select client.nom
from client
where client.id = (select idclient from commande);
