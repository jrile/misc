package listExample1

object ListMethods {

  val nums = 1 :: 2 :: 3 :: 4 :: Nil

  // pattern matching

  def isort(xs: List[Int]): List[Int] = {
    def insert(x: Int, xs: List[Int]): List[Int] = xs match {
      case List() => List(x)
      case y :: ys if x <= y => x :: xs
      case y :: ys => insert(x, ys)
    }
    xs match {
      case List() => List()
      case x :: xs1 => insert(x, isort(xs1))
    }
  }
 
  // exercise ==> implement ::: aka ++
  def concatenate[T](a: List[T], b: List[T]): List[T] = (a,b) match {   
  	case (Nil, x) => x
  	case (x, Nil) => x
  	case (x::xs, y) => x:: concatenate(xs,y) 
  }
  // length

  List(1, 2, 3).length

  // vs ls.isEmpty

  // head tail init last
  // drop take splitAt

  // flatten
  List("hello", "world", "duh").map(_.toCharArray)

  // zip unzip
  List("hello", "world", "duh").zip(List(1, 2, 3, 4))

  // mkString
  val m = List(1, 2, 3)

  // mergeSort example
  def msort[T](less: (T, T) => Boolean)(xs: List[T]): List[T] = {
    def merge(xs: List[T], ys: List[T]): List[T] =
      (xs, ys) match {
        case (Nil, _) => ys
        case (_, Nil) => xs
        case (x :: xs1, y :: ys1) =>
          if (less(x, y)) x :: merge(xs1, ys)
          else y :: merge(xs, ys1)
      }
    val n = xs.length / 2
    if (n == 0) xs
    else {
      val (ys, zs) = xs splitAt n
      merge(msort(less)(ys), msort(less)(zs))
    }
  }

  val intSort = msort((a: Int, b: Int) => a < b) _

  // map  :  FUNCTOR

  List(2.0, 1.3, 9.2).map(_.toInt)

  // flatMap  : MONAD
  // Like Map, but the function returns a LIST of elements rather than an element
  List("hello", "world").flatMap(_.toCharArray)

  List.range(1, 5).flatMap(i => List.range(1, i).map(j => (i, j)))

  // foreach  -- takes a function that returns a UNIT
  List(1, 2, 3, 4, 5) foreach (x => println(x + 3))

  // filters:  filter , partition , find , takeWhile , dropWhile , span
  List.range(1, 11).filter(_ % 2 == 0)

  // forall exists
  List.range(1, 11).forall(_ > 0)

  // folds
  List.range(1, 11).foldLeft("0")(_.toString + _)
  List.range(1, 11).foldRight("0")((a, b) => a + b.toString)

}