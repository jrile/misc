package expressions4

trait Expression [T] {
  def value(t : T) : Int
}



object ExpressionEvaluator {
  def evaluate[T : Expression] (expr : T) : Int = 
    implicitly[Expression[T]].value(expr) 
}

object Expression {
  implicit val intExpression = new Expression[Int]  {
    def value(n : Int) :Int = n
  }
  
  implicit def pairExpression[T1:Expression, T2:Expression] =
    new Expression[(T1,T2)] {
	  def value(pair : (T1,T2)) : Int = 
	    implicitly [Expression[T1]].value(pair._1) +
	    implicitly [Expression[T2]].value(pair._2)
  
  }
  
  
}