longueur' xs = case xs of 
 [] -> 0
 _:xs' -> 1 + longueur' xs'
