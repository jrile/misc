package forcomp

object week5 {
  println("Welcome to the Scala worksheet")       //> Welcome to the Scala worksheet
  
  def removeAt(n: Int, xs: List[Int]) = (xs take n) ::: (xs drop n+1)
                                                  //> removeAt: (n: Int, xs: List[Int])List[Int]
  
  removeAt(2, List(1,2,3))                        //> res0: List[Int] = List(1, 2)
  
  def squareList(xs: List[Int]): List[Int] = xs match {
  	case Nil => xs
  	case y :: ys => y*y :: squareList(ys)
  }                                               //> squareList: (xs: List[Int])List[Int]
  
  def squareList2(xs: List[Int]): List[Int] =
  	xs map ((x: Int) => x*x)                  //> squareList2: (xs: List[Int])List[Int]

	val l = List(1,2,3,4,5)                   //> l  : List[Int] = List(1, 2, 3, 4, 5)
	squareList(l)                             //> res1: List[Int] = List(1, 4, 9, 16, 25)
	squareList2(l)                            //> res2: List[Int] = List(1, 4, 9, 16, 25)
	
	def pack[T](xs: List[T]): List[List[T]] = xs match {
		case Nil => Nil
		case x :: xs1 =>
			val (first, rest) = xs span (y => y == x)
			first :: pack(rest)
	}                                         //> pack: [T](xs: List[T])List[List[T]]
	
	def encode[T](xs: List[T]): List[(T, Int)] = xs match {
		case Nil => Nil
		case x :: xs1 =>
			val (first, rest) = xs span (y => y == x)
			(x, first.size) :: encode(rest)
	}                                         //> encode: [T](xs: List[T])List[(T, Int)]
	
	val data = List("a", "a", "a", "b", "c", "c", "a")
                                                  //> data  : List[String] = List(a, a, a, b, c, c, a)
	pack(data)                                //> res3: List[List[String]] = List(List(a, a, a), List(b), List(c, c), List(a))
                                                  //| 
	def encode2[T](xs: List[T]): List[(T, Int)] =
		pack(xs) map (ys => (ys.head, ys.length))
                                                  //> encode2: [T](xs: List[T])List[(T, Int)]

	encode(data)                              //> res4: List[(String, Int)] = List((a,3), (b,1), (c,2), (a,1))
	encode2(data)                             //> res5: List[(String, Int)] = List((a,3), (b,1), (c,2), (a,1))
	
	def sum(xs: List[Int]) = (0 :: xs) reduceLeft ((x, y) => x + y)
                                                  //> sum: (xs: List[Int])Int

	sum(l)                                    //> res6: Int = 15
	
	def product(xs: List[Int]) = (xs foldLeft 1) (_ * _)
                                                  //> product: (xs: List[Int])Int
	product(l)                                //> res7: Int = 120
	
	

}