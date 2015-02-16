package philosophy

trait Philosophical {
  def philosophize() {
    println("I consume memory, therefore I am!")
  }
}

/*class Frog extends Philosophical {
  override def toString = "green"
}*/

class Animal
trait HasLegs
class Frog extends Animal with Philosophical with HasLegs {
  override def toString = "green"
  override def philosophize() { // override is mandatory
    println("It ain't easy being " + toString + "!")
  }
}

class Rational(n: Int, d: Int) extends Ordered[Rational] {
  val numer = n
  val denom = d
  def compare(that: Rational) =
    (this.numer * that.denom) - (that.numer * this.denom)
}


