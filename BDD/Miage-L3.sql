select client.nom from client inner join commande on client.id = commande.IDCLIENT;

select client.nom
from client
where client.id = (select idclient from commande);