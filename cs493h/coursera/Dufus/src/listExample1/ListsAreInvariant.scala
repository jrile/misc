package listExample1

object ListsAreInvariant extends App {
  
  val x : List[String] = List("a","b", "c")
  
  val x2 = 2 :: x
  
  val y : List[Any] = List(1, "blech")
  
  val z = x ++ y
  
  2 :: z
  
  // careful -- Type eraser
  
  z match {
    case _ : List[String] => println ("string")
    case _ : List[Int] => println("int")
  	
  }
}