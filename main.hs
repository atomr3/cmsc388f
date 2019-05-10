{-
   Honor Pledge

   I pledge on my honor that I have not given or received any
   unauthorized assistance on this assignment.

   Anand Raghu
   Nelson Le
   Andrew Witten

   Module      :  <File name or $Header$ to be replaced automatically>
   Description :  An implementation of a simple form of concurrency - cooperative multithreading. Project inspired 
   				  by the Scheme implentation of coroutines provided by instructor Cameron Moy.
-} 
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
-- Since we defined an abstract type with newtype Thread, we want to make a derived instance of some of the below reps,
-- and they aren't stock derivable classes. Kinda just added this on so it compiles

import Control.Applicative
import Control.Monad.State
import Control.Monad.Cont


-- We create a combined Monad Thread from the various base monad transformers. Thread is a ContT building 
-- from a StateT which holds all the states of operations that have been paused.
-- ContT is the continuation monad transformer and adds continuation handling to a constructor
-- StateT is the state transformer monad param'ed by the state (s) and the inner monad (m)
newtype Thread r m a = Thread {runThread' :: ContT r (StateT [Thread r m ()] m) a}
    deriving (Functor,Applicative,Monad,MonadCont,MonadIO)   

-- Used to manipulate the coroutine queue.
-- putsts :: Monad m => [Thread r m ()] -> Thread r m ()
-- putsts = Thread . lift . put 

-- Our yield func definition, which essentially pauses the current, running routine.
-- It generates the function arg for CallCC, k, in which you queue k () by appending it to a list, and then dequeue, 
-- thus allowing for a routine to be run
y :: Monad m => Thread r m ()
y = callCC $ \k -> do
    -- lift 'lifts' a function into a monad, or in this case a base monad into a compound monad, which is necessary 
    -- since that is the composition of Thread, and we are attempting to enqueue the current state
    sts <- Thread $ lift get
    Thread $ lift $ put (sts++[k ()])
    -- We are dequeueing? here, pattern matching the queue (again the lift is necessary) in order 
    -- to put the rest of the queue back, and keep the head or next paused execution state
    sts <- Thread $ lift get
    case sts of [] -> return ()
                (x:xs) -> do
                       Thread $ lift $ put xs 
                       x
-- Our fork func definition, which should add the paused current routine to our queue
-- Again, another callCC function "generator" in which we queue the applied k () and then ret the state before 
-- dequeueing yet again
f :: Monad m => Thread r m () -> Thread r m ()
f p = callCC $ \k -> do
    sts <- Thread $ lift get
    Thread $ lift $ put (sts++[k ()])
    p
    -- more pattern matching to modify our queue
    sts <- Thread $ lift get
    case sts of [] -> return ()
                (x:xs) -> do
                       Thread $ lift $ put xs
                       x

--mapping over paused coroutines until all are finished
driver :: Monad m => Thread r m ()
driver = do
    bool <- fmap null (Thread $ lift get)
    if not bool
        then y >>= \_ -> driver
        else return ()

-- Evaluate a state computation with the given initial state and ret final value, not final state
-- Run driver 
runThread :: Monad m => Thread r m r -> m r
runThread = flip evalStateT [] . flip runContT return . runThread' . (<* driver)

{-printStr str = do
    liftIO (print str)
    y

test = runThread $ do
    f $ replicateM_ 5 (printStr "Hello")
    f $ replicateM_ 6 (printStr "World")
        replicateM_ 7 (printStr "!")-}





