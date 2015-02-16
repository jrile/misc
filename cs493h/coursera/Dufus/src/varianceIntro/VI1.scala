package varianceIntro

class Fruit
class Apple extends Fruit
class MacIntosh extends Apple

object Intro1 {
  var x = new Apple
  var y = new MacIntosh
  
  x = y
//  y = x
}


class A {
  def eat (a : Apple) = 1
}

class B {
  def eat (m : MacIntosh) = 1
}

class C {
  def sell :  Apple = new Apple
}

class D {
  def sell : MacIntosh = new MacIntosh
}
