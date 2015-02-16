package variance


class Queue[+T] private(
  private val leading: List[T],
  private val trailing: List[T]) {
  def this() = this(Nil, Nil)
  def this (ls : List[T])  = this(ls, Nil)
  private def mirror =                        
    if (leading.isEmpty)
      new Queue(trailing.reverse, Nil)
    else
      this
  def head = mirror.leading.head
  def tail = {
    val q = mirror
    new Queue(q.leading.tail, q.trailing)
  }
  def enqueue(x: T) =
    new Queue(leading, x :: trailing)
}

class StrangeIntQueue extends Queue[Int]   {
  override def enqueue(x: Int) = {
    println(math.sqrt(x))
    super.enqueue(x)
  }
}

//object StrangeIntQueue {
//  val x : Queue[Any] = StrangeIntQueue
//  x.enqueue ("hello")
//}