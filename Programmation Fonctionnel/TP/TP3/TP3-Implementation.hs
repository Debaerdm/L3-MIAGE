type Symbole = Char
type Mot = [Symbole]
type Axiome = Mot
type Regles = Symbole -> Mot
type LSysteme = [Mot]

regle :: Regles
regle r 
 | r == 'F' = "F-F++F-F"
 | r == '+' = "+"
 | r == '-' = "-"
 | otherwise = ""

motSuivant :: Regles -> Mot -> Mot
motSuivant r (x:xs) = r x ++ motSuivant r xs
motSuivant _ [] = []

motSuivant' :: Regles -> Mot -> Mot
motSuivant' _ [] = []
motSuivant' r xs = concat [r x | x <- xs]

motSuivant'' :: Regles -> Mot -> Mot
motSuivant'' _ [] = []
motSuivant'' r xs = concat (map r xs)

lsysteme :: Axiome -> Regles -> LSysteme
lsysteme [] _ = []
lsysteme xs r = xs : lsysteme (motSuivant r xs) r
