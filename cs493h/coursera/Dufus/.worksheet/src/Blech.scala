import dufus._
 
case class Blech (a :String, b :String)

object Blech{;import org.scalaide.worksheet.runtime.library.WorksheetSupport._; def main(args: Array[String])=$execute{;$skip(156); 
	def apply ( a : String ) : Blech = new Blech(a,a){
		require (a.length > 20)
			
	};System.out.println("""apply: (a: String)Blech""")}
}
 
 
object duf {
  println ("helloworld")
  
  var  x : List[Int]= List(1,2,3)
  val y = List(4,5,6)
  
  x ::: y
 x= List(1)
 
 for ( x <- 1 until 20 if x %2 == 0) {
 
 }
 val b = new Blech("x","y")
 val c = Blech("z", "w")
 
}
