--Examples taken from https://en.wikibooks.org/wiki/Haskell/Continuation_passing_style#Example:_Implementing_pattern_matching

add :: Int -> Int -> Int
add x y = x + y

square :: Int -> Int
square x = x * x

pythagoras :: Int -> Int -> Int
pythagoras x y = add (square x) (square y)



add_cps :: Int -> Int -> ((Int -> r) -> r)
add_cps x y = \k -> k (add x y)

square_cps :: Int -> ((Int -> r) -> r)
square_cps x = \k -> k (square x)

pythagoras_cps :: Int -> Int -> ((Int -> r) -> r)
pythagoras_cps x y = \k ->
 square_cps x $ \x_squared ->
 square_cps y $ \y_squared ->
 add_cps x_squared y_squared $ k




--ChurchEncodingBool is a suspended computation.  
type ChurchEncodingBool r = r -> r -> r

true :: ChurchEncodingBool r
true x _ = x

false :: ChurchEncodingBool r
false _ x = x

isTrue :: ChurchEncodingBool String -> String
isTrue bool = bool "Yes" "No"

myNot :: (ChurchEncodingBool Bool) -> Bool
myNot bool = bool False True







