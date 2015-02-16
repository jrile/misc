import expressions3._
import Expression._
import ExpressionEvaluator._

import Json._

object exp3 {;import org.scalaide.worksheet.runtime.library.WorksheetSupport._; def main(args: Array[String])=$execute{;$skip(120); 
  val x = (1,(2,3));System.out.println("""x  : (Int, (Int, Int)) = """ + $show(x ));$skip(17); val res$0 = 
  
  evaluate(x);System.out.println("""res0: Int = """ + $show(res$0));$skip(22); val res$1 = 
  JsonWriter.write(x);System.out.println("""res1: String = """ + $show(res$1))}
}
