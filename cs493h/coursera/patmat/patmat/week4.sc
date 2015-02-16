import patmat.Huffman._
object week4 {
  println("Welcome to the Scala worksheet")       //> Welcome to the Scala worksheet
  
  abstract class Nat {
  	def isZero: Boolean
  	def predecessor: Nat
  	def successor = new Succ(this)
  	def + (that: Nat): Nat
  	def - (that: Nat): Nat
  }
  
  object Zero extends Nat {
  	def isZero = true
  	def predecessor = throw new Exception()
  	def + (that: Nat): Nat = that
  	def - (that: Nat): Nat =
  		if (that.isZero) this
  		else throw new Exception()
  }
  
  class Succ(n: Nat) extends Nat {
  	def isZero = false
  	def predecessor = n

  	def + (that: Nat): Nat = new Succ(n + that)
  	def - (that: Nat): Nat =
  		if (that.isZero) this
  		else n - that.predecessor
  }
  
	  val sampleTree = makeCodeTree(
	  makeCodeTree(Leaf('x', 1), Leaf('e', 1)),
	  Leaf('t', 2)
)                                                 //> sampleTree  : patmat.Huffman.Fork = Fork(Fork(Leaf(x,1),Leaf(e,1),List(x, e)
                                                  //| ,2),Leaf(t,2),List(x, e, t),4)

}