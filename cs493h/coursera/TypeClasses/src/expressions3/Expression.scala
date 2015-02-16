package expressions3

sealed trait Expression[E] {
  def value (e : E) : Int
}


object ExpressionEvaluator  {
  def evaluate [E : Expression] (expr : E) : Int = 
    implicitly [Expression[E]].value(expr)
  
}

object Expression {
  implicit def intExpression = new Expression [Int] {
    def value( a : Int) = a
  }
  
  implicit def pairPlusExpression[T1 : Expression, T2 : Expression] = 
    new Expression[(T1, T2)] {
	  def value (pair : (T1,T2)) :  Int = {
	     implicitly[Expression[T1]].value(pair._1) +
	     implicitly[Expression[T2]].value(pair._2)
	  }
	  }
}