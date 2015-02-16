package forcomp

object week5 {;import org.scalaide.worksheet.runtime.library.WorksheetSupport._; def main(args: Array[String])=$execute{;$skip(75); 
  println("Welcome to the Scala worksheet");$skip(73); 
  
  def removeAt(n: Int, xs: List[Int]) = (xs take n) ::: (xs drop n+1);System.out.println("""removeAt: (n: Int, xs: List[Int])List[Int]""");$skip(30); val res$0 = 
  
  removeAt(2, List(1,2,3));System.out.println("""res0: List[Int] = """ + $show(res$0));$skip(122); 
  
  def squareList(xs: List[Int]): List[Int] = xs match {
  	case Nil => xs
  	case y :: ys => y*y :: squareList(ys)
  };System.out.println("""squareList: (xs: List[Int])List[Int]""");$skip(77); 
  
  def squareList2(xs: List[Int]): List[Int] =
  	xs map ((x: Int) => x*x);System.out.println("""squareList2: (xs: List[Int])List[Int]""");$skip(26); 

	val l = List(1,2,3,4,5);System.out.println("""l  : List[Int] = """ + $show(l ));$skip(15); val res$1 = 
	squareList(l);System.out.println("""res1: List[Int] = """ + $show(res$1));$skip(16); val res$2 = 
	squareList2(l);System.out.println("""res2: List[Int] = """ + $show(res$2));$skip(164); 
	
	def pack[T](xs: List[T]): List[List[T]] = xs match {
		case Nil => Nil
		case x :: xs1 =>
			val (first, rest) = xs span (y => y == x)
			first :: pack(rest)
	};System.out.println("""pack: [T](xs: List[T])List[List[T]]""");$skip(179); 
	
	def encode[T](xs: List[T]): List[(T, Int)] = xs match {
		case Nil => Nil
		case x :: xs1 =>
			val (first, rest) = xs span (y => y == x)
			(x, first.size) :: encode(rest)
	};System.out.println("""encode: [T](xs: List[T])List[(T, Int)]""");$skip(54); 
	
	val data = List("a", "a", "a", "b", "c", "c", "a");System.out.println("""data  : List[String] = """ + $show(data ));$skip(12); val res$3 = 
	pack(data);System.out.println("""res3: List[List[String]] = """ + $show(res$3));$skip(91); 
	def encode2[T](xs: List[T]): List[(T, Int)] =
		pack(xs) map (ys => (ys.head, ys.length));System.out.println("""encode2: [T](xs: List[T])List[(T, Int)]""");$skip(15); val res$4 = 

	encode(data);System.out.println("""res4: List[(String, Int)] = """ + $show(res$4));$skip(15); val res$5 = 
	encode2(data);System.out.println("""res5: List[(String, Int)] = """ + $show(res$5));$skip(67); 
	
	def sum(xs: List[Int]) = (0 :: xs) reduceLeft ((x, y) => x + y);System.out.println("""sum: (xs: List[Int])Int""");$skip(9); val res$6 = 

	sum(l);System.out.println("""res6: Int = """ + $show(res$6));$skip(56); 
	
	def product(xs: List[Int]) = (xs foldLeft 1) (_ * _);System.out.println("""product: (xs: List[Int])Int""");$skip(12); val res$7 = 
	product(l);System.out.println("""res7: Int = """ + $show(res$7))}
	
	

}
