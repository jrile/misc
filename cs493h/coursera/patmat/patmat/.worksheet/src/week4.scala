import patmat.Huffman._
object week4 {;import org.scalaide.worksheet.runtime.library.WorksheetSupport._; def main(args: Array[String])=$execute{;$skip(82); 
  println("Welcome to the Scala worksheet")
  
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
  };$skip(699); 
  
	  val sampleTree = makeCodeTree(
	  makeCodeTree(Leaf('x', 1), Leaf('e', 1)),
	  Leaf('t', 2)
);System.out.println("""sampleTree  : patmat.Huffman.Fork = """ + $show(sampleTree ))}

}
