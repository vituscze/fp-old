-- In this file you can read a short overview of some Haskell features, discussed on the second and third lecture (FP 2016/17).

-- The following line shows how to activate a language extension: 
{-# LANGUAGE InstanceSigs #-}

-- This is how modules are imported:
import Data.Char
import Data.Foldable

{- 
   Programming is all about describing algorithms manipulating data structures. 
   Functional programming is all about writing function definitions, 
   and also about defining data types (and typeclasses).
-}


-- But first of all, let's start with the hello world:

helloWorld = putStrLn "Hello World!"

-- If you would like to compile the source you need a main inside the source file.

main = helloWorld

-- But we will be using just the interpreter for the rest of this file.


 
-- We start by exploring the Haskell syntax, 
-- with more appropriate functional programming "Hello world": 
-- The factorial function.

fac :: Integer -> Integer
fac n = if n <= 1 then 1 else n * fac (n-1)

-- First line is the type signature, it is not mandatory 
-- (compiler will try to deduce most general type on its own), 
-- yet it is a good practice to write them: as a documentation and they also help when things get wrong.
-- It says that factorial is a function which takes an Integer and returns an Integer.

-- Some built-in types

--  - Int       is an integer with at least 30 bits of precision.
--  - Integer   is an integer with unlimited precision.
--  - Float     is a single precision floating point number.
--  - Double    is a double precision floating point number.
--  - Rational  is a fraction type, with no rounding error.
--  - Char

-- The second line is the function definition,
-- we use safe version of factorial defined also for the negative numbers.



-- We can use line-breaks and indentation to make the IF-THEN-ELSE more familiar:

fac' :: Integer -> Integer
fac' n = 
  if n <= 1 then 
    1 
  else 
    n * fac' (n-1)

-- However, be careful with the indentation: It has meaning,
-- so there is no need for curly braces (similarly as in Python). 
-- Generally, Haskell style tends to avoid parentheses (e.g. f x instead of f(x)). 

-- You can see that single quote symbol (pronounced "prime") is a legal symbol in Haskell identifiers,
-- Haskell tends to borrow notions from math.


-- We can also define factorial in the terms of lambda function (the \ stands for λ)
-- (\x -> M) stands for (λx . M) in lambda calculus.

fac2 :: Integer -> Integer
fac2 = \n -> if n <= 1 then 1 else n * fac2 (n-1)


-- The IF-THEN-ELSE can be replaced by Guards notation, resembling the math notation for defining functions.
-- It is a nice syntactic sugar to avoid nested IFs. 
-- This is a reoccurring theme in Haskell, lot of fancy syntax that can be reduced to equivalent form in a much
-- simpler underlying language.

fac3 :: Integer -> Integer
fac3 n | n <= 1    = 1
       | otherwise = n * fac3 (n-1)

-- (Note: the 'otherwise' is not a language keyword, it is just a constant equal to True. 
-- First guard that evaluates to True is the one that gives the result, so this is a trick 
-- ensuring that there is at least one guard that will succeed.)



-- Another option is to have the definition split into multiple sub-definitions 
-- powered by the pattern matching mechanism.
-- (Note: here the definition is no longer safe since it does not handle the negative cases).

fac4 :: Integer -> Integer
fac4 0 = 1
fac4 n = n * fac4 (n-1)


-- This is yet another syntactic sugar, this time for case expression.

fac5 :: Integer -> Integer
fac5 input = case input of
  0 -> 1
  n -> n * fac5 (n-1)

-- The case expression is a more powerful cousin of the classical switch statement.
-- We will see more illustrative examples of patter matching 
-- in the examples dealing with more structured data types.



-- BOOLS

-- Let's have a closer look on the Haskell Bool type and on IF-THEN-ELSE. 
-- The (if p then x else y) in Haskell is more similar to 
-- the ternary (p ? x : y) in ordinary languages, because:
--  (a) the else part is mandatory
--  (b) it is an expression rather than statement, i.e. it has a value.

-- Another surprising feature of Haskell is that Bool type is not a built-in type,
-- but rather a "user-defined" type imported from the standard module (called Prelude).


-- It is defined as:

-- GHCi> :i Bool
-- data Bool = False | True

-- This means that Bool has two possible simple values False and True.
 

-- Even more surprising fact is that we can easily define our own "if-function":

if' :: Bool -> a -> a -> a
if' p x y = case p of
  True  -> x
  False -> y

-- In the type signature, we see some new stuff: 

--  (a) a type variable 'a',
--  (b) three arrows instead of one.

-- ad (b): The type (Bool -> a -> a -> a) can be thought of as of type ((Bool, a, a) -> a),
--         that is as having 3 inputs with types Bool, a, a; and returning result with type a.
--           
--         More precisely it is a type (Bool -> (a -> (a -> a))) compliant with the notion that
--         all functions have precisely one input. The -> associates to the right so we can omit
--         the parentheses.
--  
--         This is compatible with second convention stating that (f x y z) stands for (((f x) y) z),
--         The standard notation wold be f(x,y,z). 
--         Notice that the application associates to the left. 
--         (This is because we write f(x) instead of (x)f,
--          which would be more compatible
--          with the convention for writing -> types)

-- ad (a): the type variable in the type means that the value having the type is polymorphic,
--         which means that if an arbitrary type is substituted for it, then it is still a valid
--         definition for the more specific type.
--  
--         For example, in the following case: 

fac6 :: Integer -> Integer
fac6 n = if' (n <= 0) 1 (n * fac6 (n-1))



-- if' :: Bool -> Integer -> Integer -> Integer.  


-- The definition is possible thanks to the lazy evaluation:
-- simply put, lazy evaluation means that the evaluation of an expression standing for the function input
-- is delayed until it is forced to be need to show you a result.
-- If it wasn't this way, than both branches of if' would be evaluated, resulting in inefficiencies at best,
-- but also in the infinite loops, as is the case of factorial (thanks to the recursion). 






-- LISTS


-- Let's have a closer look on Lists:

-- GHCi> :i [] 
-- data [] a = [] | a : [a]

-- This may seem as a rather cryptic stuff.
-- We can define our own equivalent to see what is going on:

data MyList a = Empty | MkList a (MyList a)



sum' :: Num a => [a] -> a
sum' [] = 0
sum' (x:xs) = x + sum' xs

product' :: Num a => [a] -> a
product' [] = 1
product' (x:xs) = x * product' xs


fac7 :: Integer -> Integer
fac7 n = product' [1..n]



length' :: [a] -> Int
length' [] = 0
length' (_:xs) = 1 + length' xs

(+++) :: [a] -> [a] -> [a]
(+++) [] ys = ys
(+++) (x:xs) ys = x : (xs +++ ys)

concat' :: [[a]] -> [a]
concat' [] = []
concat' (xs:xss) = xs +++ (concat' xss)






map' :: (a->b) -> [a] -> [b]
map' _ [] = []
map' f (x:xs) = (f x) : (map' f xs)


filter' :: (a->Bool) -> [a] -> [a]
filter' _ [] = []
filter' pred (x:xs) | pred x = x : filter' pred xs
                    | otherwise  = filter' pred xs  



qsort :: Ord a => [a] -> [a]
qsort [] = []
qsort (x:xs) = let smaller = qsort $ filter (<= x) xs
                   bigger  = qsort $ filter (>  x) xs
                in smaller ++ [x] ++ bigger


qsort' :: Ord a => [a] -> [a]
qsort' [] = []
qsort' (x:xs) = smaller ++ [x] ++ bigger
          where smaller = qsort' [a | a <- xs, a <= x]
                bigger  = qsort' [a | a <- xs, a > x]




my_foldr :: (a -> b -> b) -> b -> [a] -> b
my_foldr f acc [] = acc
my_foldr f acc (x:xs) = f x (my_foldr f acc xs)

my_foldl :: (b -> a -> b) -> b -> [a] -> b
my_foldl f acc [] = acc
my_foldl f acc (x:xs) = my_foldl f (f acc x) xs


map'' :: (a->b) -> [a] -> [b]
map'' f xs = foldr (\x acc-> (f x) : acc) [] xs

map''' :: (a->b) -> [a] -> [b]
map''' f = foldr (\x -> (:) (f x)) []

map'''' :: (a->b) -> [a] -> [b]
map'''' f = foldr ((:) . f) []



filter'' :: (a->Bool) -> [a] -> [a]
filter'' pred = foldr f []
  where f x acc = if pred x then x : acc else acc


sum'' :: Num a => [a] -> a
sum'' = foldr (+) 0 

product'' :: Num a => [a] -> a
product'' = foldr (*) 1

fac8 :: Integer -> Integer
fac8 n = foldr (*) 1 [1..n]


(++++) :: [a] -> [a] -> [a]
(++++) xs ys = foldr (:) ys xs

concat'' :: [[a]] -> [a]
concat'' = foldr (++++) []

length'' :: [a] -> Int
length'' = foldr (\_ acc -> 1 + acc) 0

length''' :: [a] -> Int
length''' = foldr (const (+1)) 0

bitsToInt :: [Bool] -> Int
bitsToInt = foldl f 0
  where f acc x = acc * 2 + (if x then 1 else 0)


zip' :: [a] -> [b] -> [(a,b)]
zip' [] _ = []
zip' _ [] = []
zip' (x:xs) (y:ys) = (x,y) : (zip' xs ys)

zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' f [] _ = []
zipWith' f _ [] = []
zipWith' f (x:xs) (y:ys) = (f x y) : (zipWith' f xs ys)


dotProduct :: Num a => [a] -> [a] -> a
dotProduct xs ys = sum' (zipWith' (*) xs ys)









fix :: (a -> a) -> a
fix f = let x = f x in x 


preFac :: (Integer -> Integer) -> (Integer -> Integer)
preFac recursiveCall = (\n -> if' (n <= 0) 1 (n * recursiveCall (n-1) ))

fac9 :: Integer -> Integer
fac9 = fix preFac



-- foldr :: Foldable t => (a -> b -> b) -> b -> t a -> b

-- "home made List" fold

instance Foldable MyList where
  foldr :: (a -> b -> b) -> b -> MyList a -> b -- Possible thanks to language extension InstanceSigs. Normally types are not written in the instances' code.
  foldr f acc myList = case myList of
    Empty -> acc
    MkList x xs -> f x (foldr f acc xs)


instance Functor MyList where
  fmap :: (a -> b) -> MyList a -> MyList b
  fmap f = foldr (MkList . f) Empty 



myListToList :: MyList a -> [a]
myListToList = foldr (:) []

listToMyList :: [a] -> MyList a
listToMyList = foldr MkList Empty


-------------------










