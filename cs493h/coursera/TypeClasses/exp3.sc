import expressions3._
import Expression._
import ExpressionEvaluator._

import Json._

object exp3 {
  val x = (1,(2,3))                               //> x  : (Int, (Int, Int)) = (1,(2,3))
  
  evaluate(x)                                     //> res0: Int = 6
  JsonWriter.write(x)                             //> res1: String = { fst: 1, snd: { fst: 2, snd: 3 } }
}