liste_sommes []     []     = []
liste_sommes (x:xs) (y:ys) = x+y : liste_sommes xs ys
