import Graphics.Gloss

type Symbole = Char
type Mot = [Symbole]
type Axiome = Mot
type Regles = Symbole -> Mot
type LSysteme = [Mot]
type EtatTortue = (Point, Float)
type Config = (EtatTortue, Float, Float, Float, [Symbole])
type EtatDessin = (EtatTortue, Path)

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

etatInitial :: Config -> EtatTortue
etatInitial (c,_,_,_,_) = c

longueurPas :: Config -> Float
longueurPas (_,c,_,_,_) = c

facteurEchelle :: Config -> Float
facteurEchelle (_,_,c,_,_) = c

angle :: Config -> Float
angle (_,_,_,c,_) = c

symbolesTortue :: Config -> [Symbole]
symbolesTortue (_,_,_,_,c) = c

avance :: Config -> EtatTortue -> EtatTortue 
avance c ((x,y),z) = ((x + longueurPas c * cos z, y + longueurPas c * sin z), z)

tourneAGauche :: Config -> EtatTortue -> EtatTortue
tourneAGauche c ((x,y),z) = ((x,y), z - angle c)

tourneADroite :: Config -> EtatTortue -> EtatTortue
tourneADroite c ((x,y),z) = ((x,y), z + angle c)

filter' :: [Symbole] -> Symbole -> Bool
filter' [] s = False
filter' (x:xs) s | s==x = True
 | otherwise = filter' xs s

filtreSymbolesTortue :: Config -> Mot -> Mot
filtreSymbolesTortue c [] = []
filtreSymbolesTortue c m = [ x | x <- m, filter' (symbolesTortue c) x]

interpreteSymbole :: Config -> EtatDessin -> Symbole -> EtatDessin
interpreteSymbole c (((x,y),z), hs) s | not (filter' (symbolesTortue c) s) = (((x,y),z), hs)
 | s == 'F' = (((x,y), z), (x2,y2) : hs)
 | s == '+' = (tourneADroite c ((x,y),z), hs)
 | s == '-' = (tourneAGauche c ((x,y),z), hs)
 where (x2,y2) = fst(avance c ((x,y),z))

aux :: Config -> EtatDessin -> Mot -> EtatDessin
aux c e [] = e
aux c e (h:hs) = aux c e2 hs
 where e2 = interpreteSymbole c e h

getPath :: EtatDessin -> Path
getPath (e,p) = p

interpreteMot :: Config -> Mot -> Picture
interpreteMot c m = line (getPath (aux c (etatInitial c, [(x,y)]) m))
 where (x,y) = fst (etatInitial c)

enieme instant = round instant `mod` 8

avanceConfig :: Config -> Float -> Config
avanceConfig (a,b,c,d,e) t = (a,b*(c ^ enieme t), c,d,e)

lsystemeAnime :: LSysteme -> Config -> Float -> Picture
lsystemeAnime l c t = interpreteMot (avanceConfig c t) (l !! enieme t)

vonKoch1 :: LSysteme
vonKoch1 = lsysteme "F" regles
    where regles 'F' = "F-F++F-F"
          regles  s  = [s]

vonKoch1Anime :: Float -> Picture
vonKoch1Anime = lsystemeAnime vonKoch1 (((-400, 0), 0), 800, 1/3, pi/3, "F+-")

--dessin = interpreteMot (((-150, 0), 0), 100, 1, pi/3, "F+-") "F+F--F+F"

main = animate (InWindow "lsysteme" (500, 500) (0,0)) white vonKoch1Anime
