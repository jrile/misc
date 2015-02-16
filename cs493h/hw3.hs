-- Jonathan Rile
-- CS 493H HW 3
-- 701085173

-- 1
tail' :: [a] -> [a]
tail' (x:xs) = xs

-- 2
setHead :: [a] -> a -> [a]
setHead (x:xs) element = element : xs

-- 3
take' :: [a] -> Integer -> [a]
take' (x:xs) n 
	| n == 0 = []
	| otherwise = x : take' xs (n-1)
	
-- 4
takeWhile' :: (a -> Bool) -> [a] ->  [a]
takeWhile' _ [] = []
takeWhile' f (x:xs) 
	| f x = x : takeWhile' f xs
	| otherwise = []
	
-- 5
init' :: [a] -> [a]
init' [] = []
init' [x] = []
init' (x:xs) = x : init' xs

-- 6
map' :: (a -> a) -> [a] -> [a]
map' _ [] = []
map' f (x:xs) = f x : map' f xs

-- 9
foldr' :: (x -> y -> y) -> y -> [x] -> y
foldr' _ a [] = a
foldr' f b (x:xs) = f x (foldr' f b xs)

-- 10
foldl' :: (x -> y -> x) -> x -> [y] -> x
foldl' _ a [] = a 
foldl' f b (x:xs) = foldl' f (f b x) xs

-- 11
map2 :: (x -> y) -> [x] -> [x]
map2 _ [] = []
map2 f (x:xs) = foldr (\x y -> f y) x xs : map2 f xs

-- 12
-- ?

-- 13 
length' :: [a] -> Integer
length' [] = 0
length' (x:xs) = foldr (\x y -> y+1) 1 xs

-- 15
reverse' :: [a] -> [a]
reverse' [] = []
reverse' l = foldl (\x y -> y:x) [] l  