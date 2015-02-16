import expressions._
import expressions.ExpressionEvaluator._
import expressions.JsonWriter._
import expressions.ExpressionHelper._

object exp {;import org.scalaide.worksheet.runtime.library.WorksheetSupport._; def main(args: Array[String])=$execute{;$skip(203); 
     val x = Plus(Number(2), Minus(Number(8), Number(4)));System.out.println("""x  : expressions.Plus = """ + $show(x ));$skip(12); val res$0 = 
 		value(x);System.out.println("""res0: Int = """ + $show(res$0));$skip(50); 
 		
 		def add (x : Int)(implicit y: Int) = x + y;System.out.println("""add: (x: Int)(implicit y: Int)Int""");$skip(32); 
 		
 		implicit val j : Int = 9;System.out.println("""j  : Int = """ + $show(j ));$skip(14); val res$1 = 
 		
 		add(2);System.out.println("""res1: Int = """ + $show(res$1));$skip(16); val res$2 = 
 		
 		write(x);System.out.println("""res2: String = """ + $show(res$2))}
}
