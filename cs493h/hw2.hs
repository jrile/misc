-- Jonathan Rile
-- CS 493H HW 2
-- 701085173

-- 1
data BST a = Empty | Node (BST a) a (BST a) deriving (Show, Eq)

insert :: (Ord a) => BST a -> a -> BST a
insert Empty x = Node Empty x Empty
insert (Node tree1 x tree2) y
	| x == y = Node tree1 x tree2
	| x < y = Node tree1 x (insert tree2 y)
	| otherwise = Node (insert tree1 y) x tree2

-- 2
mkTree :: Ord a => [a] -> BST a
mkTree [] = Empty
mkTree (x:xs) = mkTreeHelper (Node Empty x Empty) xs

mkTreeHelper tr [] = tr
mkTreeHelper tr (x:xs) = mkTreeHelper (insert tr x) xs

-- 3
leafCount :: Ord a => BST a -> Integer
leafCount Empty = 0
leafCount (Node left _ right)
	| left == Empty && right == Empty = 1
	| otherwise = leafCount left + leafCount right + 1
	
-- 4
leaves :: Ord a => BST a -> [a]
leaves Empty = []
leaves (Node left x right)
	| left == Empty && right == Empty = [x]
	| otherwise = [x] ++ leaves left ++ leaves right

-- 5
intNodes :: Ord a => BST a -> [a]
intNodes Empty = []
intNodes (Node Empty _ Empty) = []
intNodes (Node left x right) = [x] ++ intNodes left ++ intNodes right

-- 6
level :: Ord a => BST a -> Integer -> [a]
level Empty _ = []
level (Node left x right) n
	| n == 1 = [x]
	| n > 1 = level left (n-1) ++ level right (n-1)
	| otherwise = []
	
-- 9a
preorder :: Ord a => BST a -> [a]
preorder Empty = []
preorder (Node left x right) = [x] ++ preorder left ++ preorder right

-- 9b
inorder :: Ord a => BST a -> [a]
inorder Empty = []
inorder (Node left x right) = inorder left ++ [x] ++ inorder right

-- 10 
data MWST a = Empty' | Node' (MWST [a]) a deriving (Show, Eq)