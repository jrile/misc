
package expressions2

sealed trait Expression [A] {
  def value(a : A) : Int
}



object ExpressionEvaluator {
  def evaluate[A:Expression] (a : A) : Int =
    implicitly[Expression[A]].value(a)
}

object Expression {
  implicit val intExpression = new Expression[Int]{
    def value( n : Int) = n
  }
  
  implicit def pairExpression [T1 : Expression, T2 :Expression] =
    new Expression[(T1, T2)] {
    def value (pair: (T1,T2)) =
      implicitly [Expression[T1]].value(pair._1) +
      implicitly [Expression[T2]].value(pair._2)
  }
  
}

  
  
 