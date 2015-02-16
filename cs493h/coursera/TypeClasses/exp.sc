import expressions._
import expressions.ExpressionEvaluator._
import expressions.JsonWriter._
import expressions.ExpressionHelper._

object exp {
     val x = Plus(Number(2), Minus(Number(8), Number(4)))
                                                  //> x  : expressions.Plus = Plus(Number(2),Minus(Number(8),Number(4)))
 		value(x)                          //> res0: Int = 6
 		
 		def add (x : Int)(implicit y: Int) = x + y
                                                  //> add: (x: Int)(implicit y: Int)Int
 		
 		implicit val j : Int = 9          //> j  : Int = 9
 		
 		add(2)                            //> res1: Int = 11
 		
 		write(x)                          //> res2: String = { op: "+", lhs: 2, rhs: { op: "-", lhs: 8, rhs: 4 } }
}