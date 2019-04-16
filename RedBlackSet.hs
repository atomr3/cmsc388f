
module RedBlackSet(RedBlackSet) where
	import Set

	data Color = Red | Black
	data RedBlackSet a = Empty | T Color (RedBlackSet a) a (RedBlackSet a)


	balance Black (T Red (T Red a x b) y c) z d = T Red (T Black a x b) y (T Black c z d) 
	balance Black (T Red a x (T Red b y c)) z d = T Red (T Black a x b) y (T Black c z d) 
	balance Black a x (T Red (T Red b y c) z d) = T Red (T Black a x b) y (T Black c z d) 
	balanceBax (T Red b y (T Red c z d)) = T Red (T Black a x b) y (T Black c z d) 
	balance color a x b =T color a x b



	instance Ord a -> Set RedBlackSet a where
		empty = Empty
		member x Empty = False
		member x $ T _ l y r = 
			if x < y then member x l
			else if x > y then member x r
			else True

		insert x s = T Black a y b
			where ins Empty = T Red Empty x Empty
				  ins s@(T color a y b) = 
				  	if x < y then balance color (ins a) y b 
				  	else if x > y then balance color a y (ins b) 
				  	else s
				  T _ a y b = ins s
