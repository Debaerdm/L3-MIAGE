sommeDeXaY x y = if x > y
 then 0
 else x + sommeDeXaY (x+1) y

somme :: [Int] -> Int
somme [] = 0
somme (x:xs) = x + somme xs

last' :: [a] -> a
last' xs = head (reverse xs)

init' :: [a] -> [a]
init' xs = reverse (tail (reverse xs))

-- Function !!
(!!!) :: [a] -> Int -> a
(!!!) [] n = error "Index too large"
(!!!) (x:xs) n = if (n == 0)
 then x
 else (!!!) xs (n -1)
   
-- Function ++
plus' :: [a] -> [a] -> [a]
plus' [] ys = ys
plus' (x:xs) ys = x:(plus' xs ys)  

-- Function concat
concate' :: [[a]] -> [a]
concate' [] = []
concate' [[]] = []
concate' (xs:xss) = xs ++ concate' xss 


