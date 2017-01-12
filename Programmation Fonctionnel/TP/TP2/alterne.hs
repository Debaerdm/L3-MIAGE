import Graphics.Gloss

main = animate (InWindow "Dragon" (500, 500) (0, 0)) white (dragonAnime (0,0) (500,450))

dragonAnime a b t = Line (dragon a b !! (round t `mod` 20))

alterne :: [a] -> [a]
alterne [] = []
alterne [a] = [a]
alterne (y:x:xs) = alterne [y] ++ alterne xs

combine :: (a -> b -> c) -> [a] -> [b] -> [c]
combine f x [] = []
combine f [] y = []
combine f (x:xs) (y:ys) = [x `f` y] ++ combine f xs ys

pasPascal :: [Integer] -> [Integer]
pasPascal [] = []
pasPascal [x] = [x] ++ [x]
pasPascal xs = zipWith (+) ([0] ++ xs) (xs ++ [0]) 

pascal :: [[Integer]]
pascal = iterate pasPascal [1] 

--type Point = (Float, Float)
--type Path = [Point]

pointAIntercaler :: Point -> Point -> Point
pointAIntercaler (xa,ya) (xb,yb) = ((xa + xb)/2 + (yb - ya)/2, (ya + yb)/2 + (xa-xb)/2)

pasDragon :: Path -> Path
pasDragon [] = []
pasDragon [x] = [x]
pasDragon (x:y:z:xs) = x : pointAIntercaler x y : y : pointAIntercaler z y : pasDragon ([z] ++ xs)  
pasDragon (x:y:xs) = x : pointAIntercaler x y : pasDragon ([y] ++ xs)

dragon :: Point -> Point -> [Path]
dragon x y = iterate pasDragon ([x] ++ [y])
