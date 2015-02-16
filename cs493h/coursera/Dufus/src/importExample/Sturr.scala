package importExample

object Sturr extends App{
	val f = {for(i <- 1 until 100)
	  yield i * 3}.toList.mkString
    
	  
	 def x : Unit = println(f)
  
	 x
	 
	 val lines : List[String] = List()
	 
	 lines.foreach{x : String => println(x)}
	 lines.foreach(println(_))
	 lines.foreach(println)
}

abstract class Bill {
  def x(a : String) : String
  def y = "y"
}

class Billie extends Bill {
  def x (a: String ) = "x"
  override def y = "z"
}

