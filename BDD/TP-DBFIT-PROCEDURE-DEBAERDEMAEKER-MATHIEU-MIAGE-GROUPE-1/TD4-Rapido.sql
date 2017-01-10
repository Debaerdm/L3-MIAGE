---------------------------------
-- creation du schema 'Rapido' --
---------------------------------
create table PRODUIT_RAPIDO(
  p_ref number(2) constraint produit_rapido_pkey PRIMARY KEY,
  nom varchar2(15) not null,
  prix number(5,2),
  taille varchar2(5) not null,
  constraint nom_unique unique(nom), -- pas 2 produits avec le meme nom
  constraint enum_taille check (taille in ('petit','moyen','grand')),
  constraint prix_positif check (prix >= 0)
);

create table SIMPLE(
  s_ref number(2) constraint simple_pkey PRIMARY KEY
  constraint simple_produit_fkey REFERENCES PRODUIT_RAPIDO on delete cascade,
  categ varchar2(15),
  constraint enum_categ check (categ in ('boisson','dessert','salade','accompagnement','sandwich'))
);

create table MENU(
  m_ref number(2) constraint menu_pkey PRIMARY KEY
  constraint menu_produit_fkey REFERENCES PRODUIT_RAPIDO on delete cascade,
  promo varchar2(20)
);

create table CONSTITUE(
  ref_menu number(2) constraint constitue_menu_fkey REFERENCES MENU,
  ref_simple number(2) constraint constitue_simple_fkey REFERENCES SIMPLE,
  constraint constitue_pkey PRIMARY KEY(ref_menu, ref_simple)
);

create table MAGASIN(
  m_ref number(2) constraint magasin_pkey PRIMARY KEY,
  nom varchar2(10) not null,
  ville varchar2(10) not null
);

create table CONSOMMATION(
  estampille TIMESTAMP not null,
  ref_produit number(2) not null constraint consom_produit_fkey REFERENCES PRODUIT,
  ref_magasin number(2) not null constraint consom_magasin_fkey REFERENCES MAGASIN
);

create table stock(
	s_ref number(2),
	m_ref number(2),
	quantite number(5),
	constraint stock_pk primary key(s_ref,m_ref),
	constraint stock_simple_fk foreign key(s_ref) references simple(s_ref) on delete cascade,
	constraint stock_magasin_fk foreign key(m_ref) references magasin(m_ref) on delete cascade
);


-- Les prototypes des procedures
create or replace PACKAGE PAQ_PRODUITS AS 

procedure addProduct(nom in PRODUIT_RAPIDO.NOM%type, prix in PRODUIT_RAPIDO.PRIX%type, taille in PRODUIT_RAPIDO.TAILLE%type, categ in SIMPLE.categ%type);
procedure removeProduct(s_ref in PRODUIT_RAPIDO.P_REF%type);
procedure updateQuantiteProduct(m_ref in MAGASIN.M_REF%type, s_ref in PRODUIT_RAPIDO.P_REF%type, qte in STOCK.QUANTITE%type);
procedure updateQuantiteMenu(m_ref in MAGASIN.M_REF%type, s_ref in PRODUIT_RAPIDO.P_REF%type, qte in STOCK.QUANTITE%type);
procedure addMenu(promo MENU.PROMO%type, nom in PRODUIT_RAPIDO.NOM%type, prix in PRODUIT_RAPIDO.PRIX%type, taille in PRODUIT_RAPIDO.TAILLE%type);
procedure removeMenu(m_ref MENU.M_REF%type);
procedure ajouterProduitSimpleMenu(ref_ps SIMPLE.S_REF%type, ref_menu MENU.M_REF%type);
procedure removeProduitSimpleMenu(ref_ps SIMPLE.S_REF%type, ref_menu MENU.M_ref%type);
procedure conso(ref_produit in PRODUIT_RAPIDO.p_ref%type, ref_magasin in MAGASIN.m_ref%type, estampille date);

parametre_indefini exception ;
PB_COHERENCES_TAILLES exception;
PRODUIT_INCONNU exception;
PB_COMPOSITION exception;
MAGASIN_INCONNU exception;

pragma exception_init(parametre_indefini,-20111);
pragma exception_init(PB_COHERENCES_TAILLES, -20001);
pragma exception_init(PRODUIT_INCONNU, -20002);
pragma exception_init(PB_COMPOSITION, -20003);
pragma exception_init(MAGASIN_INCONNU, -20004);

-- Le developpement des procedures
END PAQ_PRODUITS;

create or replace PACKAGE BODY PAQ_PRODUITS AS

  procedure addProduct(nom in PRODUIT_RAPIDO.NOM%type, prix in PRODUIT_RAPIDO.PRIX%type, taille in PRODUIT_RAPIDO.TAILLE%type, categ in SIMPLE.categ%type) AS
  
  s_ref PRODUIT_RAPIDO.P_REF%type;
  
  BEGIN
    if nom is null or prix is null or taille is null or categ is null then
      raise parametre_indefini;
    end if;
    
    s_ref := se_id.nextval;
    
    insert into PRODUIT_RAPIDO values (s_ref, nom, prix, taille);
    insert into SIMPLE values (s_ref, categ);
  END addProduct;

  procedure removeProduct(s_ref in PRODUIT_RAPIDO.P_REF%type) AS
  
  id_find integer;
  
  BEGIN
    if s_ref is null then
      raise parametre_indefini;
    end if;
    
    select count(*) into id_find from simple where simple.s_ref = s_ref;
    
    if(id_find = 0) then
      raise PRODUIT_INCONNU;
    end if;
    
    delete from PRODUIT_RAPIDO where p_ref = s_ref;
  END removeProduct;
  
  
procedure addMenu(promo MENU.PROMO%type, nom in PRODUIT_RAPIDO.NOM%type, prix in PRODUIT_RAPIDO.PRIX%type, taille in PRODUIT_RAPIDO.TAILLE%type) AS
s_ref PRODUIT_RAPIDO.P_REF%type;

BEGIN
  if promo is null or nom is null or prix is null or taille is null then
      raise parametre_indefini;
    end if;

s_ref := se_id.nextval;


insert into produit_rapido values (s_ref, nom, prix,taille);
insert into Menu values(s_ref, promo);
    
END addMenu;

procedure removeMenu(m_ref MENU.M_REF%type) AS
BEGIN
delete from CONSTITUE where ref_menu = m_ref;
delete from MENU where menu.m_ref = m_ref;
END removeMenu;
  
  
procedure ajouterProduitSimpleMenu(ref_ps SIMPLE.S_REF%type, ref_menu MENU.M_REF%type) as
 tailleProduitSimple PRODUIT_RAPIDO.TAILLE%type;
 tailleProduitMenu PRODUIT_RAPIDO.TAILLE%Type;
 
 cpt integer;
 
 BEGIN
 
 select taille into tailleProduitSimple from produit_rapido where p_ref = ref_ps;
 select taille into tailleProduitMenu from produit_rapido where p_ref = ref_menu;
 if(tailleProduitSimple != tailleProduitMenu) then 
  raise PB_COHERENCES_TAILLES;
  end if;
 
 select count(*) into cpt from simple where s_ref = ref_ps;
 if (cpt = 0) then raise PRODUIT_INCONNU; end if;
 
 select count(*) into cpt from MENU where m_ref = ref_menu;
 if (cpt = 0) then raise PRODUIT_INCONNU; end if;
 
 insert into constitue values(ref_menu, ref_ps);
 
 END ajouterProduitSimpleMenu;

procedure removeProduitSimpleMenu(ref_ps SIMPLE.S_REF%type, ref_menu MENU.M_ref%type) AS

exit integer;

BEGIN

select count(*) into exit from constitue where ref_ps = constitue.ref_simple and ref_menu = constitue.ref_menu;
if exit = 0 then
  raise PB_COMPOSITION;
  end if;

delete from constitue where ref_ps = constitue.ref_simple and ref_menu = constitue.ref_menu;
END removeProduitSimpleMenu;

procedure conso(ref_produit in PRODUIT_RAPIDO.p_ref%type, ref_magasin in MAGASIN.m_ref%type, estampille date) as
timestampTmp timestamp;
begin
  if ref_produit is null or ref_magasin is null then
    raise parametre_indefini;
  end if;
  
  if estampille is null then
    timestampTmp := sysdate;
    insert into consommation values(timestampTmp, ref_produit, ref_magasin);
  else 
    insert into consommation values(estampille, ref_produit, ref_magasin);
  end if;
  
end conso;

procedure updateQuantiteProduct(m_ref in MAGASIN.M_REF%type, s_ref in PRODUIT_RAPIDO.P_REF%type, qte in STOCK.QUANTITE%type) AS

BEGIN
  if m_ref is null or s_ref is null or qte is null then
    raise parametre_indefini;
  end if;

update stock set quantite = quantite + qte where stock.m_ref = m_ref and stock.s_ref = s_ref;

END updateQuantiteProduct;

procedure updateQuantiteMenu(m_ref in MAGASIN.M_REF%type, s_ref in PRODUIT_RAPIDO.P_REF%type, qte in STOCK.QUANTITE%type) AS

BEGIN
  if m_ref is null or s_ref is null or qte is null then
    raise parametre_indefini;
  end if;

update stock set quantite = quantite + qte where stock.m_ref = m_ref and stock.s_ref in (select ref_simple from constitue);

END updateQuantiteMenu;

END PAQ_PRODUITS;

-- Les triggers :

create or replace TRIGGER LIGNESECURESIMPLE 
AFTER INSERT ON SIMPLE 
FOR EACH ROW
BEGIN
  insert into stock select :new.s_ref, m_ref, 0 from magasin;
END;

create or replace TRIGGER LIGNESECUREMAGASIN 
AFTER INSERT ON MAGASIN 
FOR EACH ROW
BEGIN
  insert into stock select s_ref, :new.m_ref, 0 from simple;
END;



