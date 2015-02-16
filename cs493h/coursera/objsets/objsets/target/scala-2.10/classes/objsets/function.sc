package objsets

object function {

	abstract class IntSet {
		def contains(x: Int): Boolean
		def incl(x: Int): IntSet
		def union(that: IntSet): IntSet
	}

	class Empty extends IntSet {
		def contains(x: Int): Boolean = false
		def incl(x: Int): IntSet = new NonEmpty(x, new Empty, new Empty)
		def union(that: IntSet) = that
		override def toString = "."
	}
	
	class NonEmpty(elem: Int, left: IntSet, right: IntSet) extends IntSet {
		//def this(elem: Int) = NonEmpty(elem, new Empty, new Empty)
	
		def contains(x: Int): Boolean =
			if (x < elem) left contains x
			else if (x > elem) right contains x
			else true
		def incl(x: Int): IntSet =
			if (x < elem) new NonEmpty(elem, left incl x, right)
			else if (x > elem) new NonEmpty(elem, left, right incl x)
			else this
			
		def union(that: IntSet) =
			((left union right) union that) incl elem
			
		override def toString = "{" + left + elem + right + "}"
	}
	
	val x = new Empty()                       //> x  : objsets.function.Empty = .
	x.incl(1)                                 //> res0: objsets.function.IntSet = {.1.}
	
}