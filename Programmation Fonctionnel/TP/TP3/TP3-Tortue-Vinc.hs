import Graphics.Gloss;

type Symbole    = Char
type Mot        = [Symbole]
type Axiome     = Mot
type Regles     = Symbole -> Mot
type LSysteme   = [Mot]

type EtatTortue = (Point, Float)
		type Config     =   (EtatTortue     -- Etat initial de la tortue
						, Float         -- Longueur initiale d'un pas
						, Float         -- Facteur d'echelle
						, Float         -- Angle pour les rotations de la tortue
						, [Symbole])    -- Liste des symboles compris par la tortue

		etatInitial :: Config -> EtatTortue
		etatInitial     (ei,_,_,_,_)    = ei
		longueurPas :: Config -> Float
		longueurPas     (_,lp,_,_,_)    = lp
		facteurEchelle :: Config -> Float
		facteurEchelle  (_,_,fe,_,_)    = fe
		angle :: Config -> Float
		angle           (_,_,_,an,_)    = an
		symbolesTortue  :: Config -> [Symbole]
		symbolesTortue ( _,_,_,_,ss)    = ss

		avance :: Config -> EtatTortue -> EtatTortue 
avance c ((x,y), cap)      = ((x + longueurPas c * cos cap, y + longueurPas c * sin cap), cap)  

		tourneAGauche :: Config -> EtatTortue -> EtatTortue
tourneAGauche c ((x,y), cap) = ((x, y), cap - angle c)

		tourneADroite :: Config -> EtatTortue -> EtatTortue
tourneADroite c ((x,y), cap) = ((x, y), cap + angle c)

		-- pour filtreSymboleTortue
		estComprisDans :: Symbole -> [Symbole] -> Bool
		estComprisDans s [] = False
		estComprisDans s (m:ms) | s == m = True
		| otherwise = estComprisDans s ms

		filtreSymboleTortue :: Config -> Mot -> Mot
		filtreSymboleTortue c [] = []
		-- regardez la méthode de Mathieu
		filtreSymboleTortue c (m:ms) | estComprisDans m (symbolesTortue c) = m : filtreSymboleTortue c ms
		| otherwise = filtreSymboleTortue c ms

type EtatDessin = (EtatTortue, Path)

		-- revoir where
		interpreteSymbole :: Config -> EtatDessin -> Symbole -> EtatDessin
interpreteSymbole c (((x,y),cap),path) s	| not (estComprisDans s (symbolesTortue c)) = (((x,y),cap),path)
		| s == 'F' = (((x2,y2),cap)               ,(x2,y2):path)
														   | s == '+' = (tourneADroite c ((x,y),cap) , path)
		| s == '-' = (tourneAGauche c ((x,y),cap) , path)
	 where (x2,y2) = fst (avance c ((x,y),cap))

-- Question 9

interpreteMot :: Config -> Mot -> Picture
interpreteMot c (m:ms) = Line ( interpreteSymbole c (  ) m ++ interpreteMot c ms ) 
