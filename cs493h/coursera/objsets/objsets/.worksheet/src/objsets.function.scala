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
	};import org.scalaide.worksheet.runtime.library.WorksheetSupport._; def main(args: Array[String])=$execute{;$skip(943); 
	
	val x = new Empty();System.out.println("""x  : objsets.function.Empty = """ + $show(x ));$skip(11); val res$0 = 
	x.incl(1);System.out.println("""res0: objsets.function.IntSet = """ + $show(res$0))}
	
}
