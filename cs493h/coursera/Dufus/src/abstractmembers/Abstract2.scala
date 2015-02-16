package abstractmembers

class Food
	
abstract class Animal {
	def eat(food: Food)
}

class Grass extends Food

class Cow extends Animal {
	def eat(food: Grass) {} 
}
 
class Fish extends Food {
	val bessy: Animal = new Cow
	bessy eat (new Fish)
}

