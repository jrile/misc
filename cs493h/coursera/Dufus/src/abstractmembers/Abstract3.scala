package abstractmembers

class Food2

class Grass2 extends Food2

abstract class Animal2 {
  type SuitableFood <: Food2
  def eat(food: SuitableFood)
}




class Cow2 extends Animal2 {
  type SuitableFood = Grass2
  override def eat(food: Grass2) {}
}