data Arbre coul val = ANoeud coul val (Arbre coul val) (Arbre coul val)
 | AFeuille
 deriving Show

mapArbre :: ((c1,v1) -> (c2,v2)) -> Arbre c1 v1 -> Arbre c2 v2
mapArbre _ AFeuille = AFeuille
mapArbre f (ANoeud a b gauche droite) = ANoeud coul2 val2 (mapArbre f gauche) (mapArbre f droite) 
 where coul2 = fst(f(a,b))
       val2 = snd(f(a,b))


-- Donnée du prof --

data ArbreProf x = Feuille
 | Noeud x (ArbreProf x) (ArbreProf x) 
 deriving Show

mapArbreProf :: (x -> y) -> ArbreProf x -> ArbreProf y
mapArbreProf _ Feuille = Feuille
mapArbreProf f (Noeud x g d) = Noeud (f x) (mapArbreProf f g) (mapArbreProf f d)

foldArbreProf :: (x->y->y->y) -> y -> ArbreProf x -> y
foldArbreProf _ e Feuille = e
foldArbreProf f e (Noeud x g d) = f x (foldArbreProf f e g) (foldArbreProf f e d)

hauteur :: ArbreProf x -> Int
hauteur = foldArbreProf (\x -> \yg -> \yd -> 1 + max yg yd) 0

taille = foldArbreProf (\x -> \yg -> \yd -> 1 + yd + yg) 0 

somme = foldArbreProf (\x -> \yg -> \yd -> x + yg + yd) 0

maxArbre = foldArbreProf(\x -> \yg -> \yd -> max x (max yd yg)) 0

dimension :: 
