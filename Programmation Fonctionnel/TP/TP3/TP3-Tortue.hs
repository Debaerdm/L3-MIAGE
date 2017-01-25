import Graphics.Gloss

type Symbole = Char
type Mot = [Symbole]
type Axiome = Mot
type Regles = Symbole -> Mot
type LSysteme = [Mot]
type EtatTortue = (Point, Float)
type Config = (EtatTortue, Float, Float, Float, [Symbole])
type EtatDessin = (EtatTortue, Path)

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
avance c ((x,y),z) = ((x + longueurPas c + cos(z), y + longueurPas c + sin(z)), z)

tourneAGauche :: Config -> EtatTortue -> EtatTortue
tourneAGauche c ((x,y),z) = ((x,y), z + angle(c))

tourneADroite :: Config -> EtatTortue -> EtatTortue
tourneADroite c ((x,y),z) = ((x,y), z - angle(c))

filter' :: [Symbole] -> Symbole -> Bool
filter' [] s = False
filter' (x:xs) s | s==x = True
 | otherwise = filter' xs s

filtreSymbolesTortue :: Config -> Mot -> Mot
filtreSymbolesTortue c [] = []
filtreSymbolesTortue c m = [ x | x <- m, filter' (symbolesTortue c) x]

interpreteSymbole :: Config -> EtatDessin -> Symbole -> EtatDessin
interpreteSymbole c (((x,y),z), hs) s | not (filter' (symbolesTortue c) s) = (((x,y),z), hs)
 | s == 'F' = (((x,y), z), path : hs)
	 where path = fst(avance c ((x,y),z))
 | s == '+' = (tourneAGauche c ((x,y),z), hs)
 | s == '-' = (tourneADroite c ((x,y),z), hs)

