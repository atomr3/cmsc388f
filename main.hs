{-
   Honor Pledge

   I pledge on my honor that I have not given or received any
   unauthorized assistance on this assignment.

   Anand Raghu
   Nelson Le
   Andrew Witten

   Module      :  <File name or $Header$ to be replaced automatically>
   Description :  Based on information taken from `http://www.cs.cmu.edu/~rwh/theses/okasaki.pdf`
-} 
module Main where
import Data.Monoid

--I think this is also acceptable
--newtype Queue a = Queue [a] deriving (Show, Eq, Read)

data Queue a = Empty | Value a (Queue a) deriving (Show, Eq, Read)

push :: a -> Queue a -> Queue a
push x Empty = Value x Empty
push x (Value a pointer) = Value a (push x pointer)

pop :: Queue a -> Maybe (a, Queue a)
pop Empty = Nothing
pop (Value a pointer) = Just (a, pointer)

