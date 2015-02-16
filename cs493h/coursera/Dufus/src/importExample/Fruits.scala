package importExample

// easy access to Fruit
import bobsdelights.Fruits
// easy access to all members of bobsdelights
import bobsdelights._
// easy access to all members of Fruits
import bobsdelights.Fruits._

package bobsdelights {
  abstract class Fruit  {
    val name: String
    val color: String
  }

  object Fruits {
    object Apple extends Fruit{val name = "apple"; val color = "red"}
    object Orange extends Fruit{val name ="orange";val color =  "orange"}
    object Pear extends Fruit{val name = "pear"; val color = "yellowish"}
    val menu = List(Apple, Orange, Pear)
  }
}

class Blech {
  
  def showFruit(fruit: Fruit) {
    import fruit._
    println(name + "s are " + color)
  }
}
