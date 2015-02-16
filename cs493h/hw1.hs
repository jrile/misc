import Data.List
import Data.Maybe

-- homework 1 
-- jonathan rile 
-- 701085173

-- 1a
onea i
	| i <= 0 = 0
	| otherwise = (2*i-1) + onea (i-1)
	
-- 1b
oneb i
	| i <= 0 = 0
	| otherwise = (1 / sqrt i) + oneb (i-1)
	
-- 1c
onec i
	| i <= 0 = 0
	| otherwise = (1 / ((2 * i + 1) * (2 * i - 1))) + onec (i-1) 

-- helper for 2
factorial :: Integer -> Integer
factorial 1 = 1
factorial n = n * factorial (n-1)

-- 2a
sin' :: (Num a, Fractional a) => a -> a
sin' x = sum [sinHelper x i | i <- [1..33]]

sinHelper :: (Num a, Fractional a) => a -> Integer -> a
sinHelper x i = (x^term / fromIntegral (factorial term)) *(-1)^(i-1) where term = 2*i - 1

-- 2b
ln' :: (Num a, Fractional a) => a -> a
ln' x = 2* sum[lnHelper x i | i <- [1..33]]

lnHelper :: (Num a, Fractional a) => a -> Integer -> a
lnHelper x i =  (1/fromIntegral term)*(((x-1)/(x+1))^term) where term = 2*i - 1

-- 3	
revInt :: Integer -> Integer
revInt = read . reverse . show

-- 4a
count xs = sum [ 1 | _ <- xs ]

-- 4b
greatest :: (Ord a) => [a] -> a
greatest [x] = x
greatest (x:xs)
	| x > maxTail = x
	| otherwise = maxTail
	where maxTail = greatest xs

-- 4c
last' :: (Ord a) => [a] -> a
last' [x] = x
last' (x:xs) = last' xs

-- 4d
isOrdered :: (Enum a, Eq a) => [a] -> Bool
isOrdered [] = True
isOrdered (x:[]) = True
isOrdered (x:y:zs) | y == succ x = isOrdered (y:zs) 
isOrdered _ = False

-- 5a
contains' xs element = element `elem` xs

-- 5b
count' xs element = sum [ 1 | x <- xs, x == element]

-- 5c
location (xs) item = fromMaybe (-1) (findIndex (==item) xs)

-- 5d
toEnd xs x = xs ++ [x]

-- 6
insert' xs x n =
	let (ys, zs) = splitAt n xs in ys ++ [x] ++ zs
	

-- 7
sortedInsert :: (Ord a) => [a] -> a -> [a]
sortedInsert [] a = [a]
sortedInsert xs a
	| isOrdered xs = addInOrder xs a
	| otherwise = xs

addInOrder :: (Ord a) => [a] -> a -> [a]
addInOrder [] y = [y]
addInOrder (x:xs) y 
	| y > x = x : insert y xs
	| otherwise = y : x : xs

-- 8a
containsAll :: (Enum a, Eq a) => [a] -> [a] -> Bool
containsAll x y = all (`elem` y) x 

-- 8b
isSubList :: (Enum a, Eq a) => [a] -> [a] -> Bool
isSubList sub xs = sub `isInfixOf` xs

-- 9
isPalindrome :: String -> Bool
isPalindrome x = x == reverse x

-- 10
rotate' :: [a] -> Int -> [a]
rotate' [] _ = []
rotate' xs n 
	| n >= 0 = cs ++ bs 
	| otherwise = es ++ ds 
		where
			(bs, cs) = splitAt n xs
			(ds, es) = splitAt (length xs + (n)) xs