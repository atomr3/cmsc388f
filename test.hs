module RedBlackSet (RedBlackSet) where import Set
data Color = R |B
data RedBlackSet a = E | T Color (RedBlackSet a) a (RedBlackSet a)
balance B (T R (T R a x b) y c) z d = T R (T B a x b) y (T B c z d) balance B (T R a x (T R b y c)) z d = T R (T B a x b) y (T B c z d) balance B a x (T R (T R b y c) z d) = T R (T B a x b) y (T B c z d) balanceBax (TRby (TRcz d))=TR(TBax b)y (J Bcz d) balance color ax b=T color ax b
instance Ord a => Set RedBlackSet a where empty = E
member x E = False member x(T_ay/?) =
if x < y then member x a
else if x > y then member x b else True
insertxs = TBayb where ins E = T R E x E
ins s@(T co/or ay b) =
if x < y then balance color (ins a) y b else if x > y then balance color a y (ins b) else s
T _ a y b = inss