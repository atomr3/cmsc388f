# CMSC388F  
Group project for 388F Spring 2019, Functional Pearls

## Project Outline
This project discusses the idea of Continuations or Continuation Passing Style in Haskell.

A Continuation itself is essentially the representation of the execution state of a computation, which means that functions don't return values, instead they direct control to a continuation. This is a great way to deal with altering control flow of programs/operations, such as

  * Exceptions
  * Failures
  * Early returns
  * **Simple Concurrency**
  
We're going to explore how CPS is expressed with Monads by implementing a very simple form of concurrency, coroutines, also known as cooperative multithreading. This is a form of threading in which each thread manually `yields` instead of being paused preemptively. Our general description is that we create a Monad which has both the ability to queue the state of a paused operation, as well as suspend the working operation.

## Collaborators
Anand Raghu  
Nelson Le  
Andrew Witten  

### Resources Used  
https://en.wikipedia.org/wiki/Continuation  
https://wiki.haskell.org/Continuation  
http://matt.might.net/articles/programming-with-continuations--exceptions-backtracking-search-threads-generators-coroutines/
http://www.cs.umd.edu/class/spring2019/cmsc388F/lectures/monads.html  
http://hackage.haskell.org/package/mtl-2.2.2/docs/Control-Monad-Cont.html#t:Cont  
https://en.wikipedia.org/wiki/Continuation-passing_style  
http://www.madore.org/~david/computers/callcc.html  

Plus the countless Stackoverfow questions consulted :)
