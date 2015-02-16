import dufus._
 
case class Blech (a :String, b :String)
 
 
object duf {;import org.scalaide.worksheet.runtime.library.WorksheetSupport._; def main(args: Array[String])=$execute{;$skip(98); 
  println ("helloworld");$skip(37); 
  
  var  x : List[Int]= List(1,2,3);System.out.println("""x  : List[Int] = """ + $show(x ));$skip(22); 
  val y = List(4,5,6);System.out.println("""y  : List[Int] = """ + $show(y ));$skip(13); val res$0 = 
  
  x ::: y;System.out.println("""res0: List[Int] = """ + $show(res$0));$skip(12); 
 x= List(1);$skip(32); 
 
 
 val b = new Blech("x","y");System.out.println("""b  : Blech = """ + $show(b ))}
}
