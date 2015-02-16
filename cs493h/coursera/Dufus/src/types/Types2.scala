package types

// constructor ( 2 lists ) is not obvious -- how to fix:

class Queue2[T]  private (
    private val leading: List[T],
    private val trailing: List[T]
    ) {
  
  def this() = this (Nil, Nil)
  
  def this(elems : T* ) = this(elems.toList, Nil)

}

// another approach

object Queue2 {  // companion object can see into class
  
  def apply[T] (xs : T*) = new Queue2[T] (xs.toList, Nil)
}

// looks like an unattached factory method

object Blech {
  
  val x = Queue2 (1,2,3,4)
  
}


