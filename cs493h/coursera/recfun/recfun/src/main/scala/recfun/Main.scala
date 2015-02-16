package recfun
import common._

object Main {
  def main(args: Array[String]) {
    println("Pascal's Triangle")
    for (row <- 0 to 10) {
      for (col <- 0 to row)
        print(pascal(col, row) + " ")
      println()
    }
    println(pascal(-9000,0))
  }
  
  
  def factorial(n: Int): Int = n match {
    case 0 => 1
    case _ => n * factorial(n-1)
  }

  /**
   * Exercise 1
   */
  
  def pascal(c: Int, r: Int): Int = {
    if (c<=0) 1
    else if (c==r) 1
    else pascal(c-1, r-1) + pascal(c, r-1)
  }

  /**
   * Exercise 2
   */
  def balance(chars: List[Char]): Boolean = {
    def inner(chars: List[Char], openParentheses: Int): Boolean = {
      if (chars.isEmpty) {
        openParentheses == 0
      }
      else {
	      val h = chars.head
	      val n = 
	        if (h=='(') openParentheses + 1
	        else if (h==')') openParentheses - 1
	        else openParentheses
	      if (n>=0) inner(chars.tail, n)
	      else false
	  }
    }
    inner(chars, 0)
  }
  

  /**
   * Exercise 3
   */
  def countChange(money: Int, coins: List[Int]): Int = {
    def inner(c: Int, changes: List[Int]): Int = {
      if (c == 0) 1
      else if (c < 0) 0
      else if (changes.isEmpty && c >= 1) 0
      else inner(c, changes.tail) + inner(c - changes.head, changes)
    }
    inner(money, coins)
  }
}
