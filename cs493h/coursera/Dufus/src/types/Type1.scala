package types

class SlowAppendQueue[T](elems: List[T]) { // Not efficient
  def head = elems.head
  def tail = new SlowAppendQueue(elems.tail)
  def enqueue(x: T) = new SlowAppendQueue(elems ::: List(x))
}

class SlowHeadQueue[T](smele: List[T]) { // Not efficient
  // smele is elems reversed
  def head = smele.last
  def tail = new SlowHeadQueue(smele.init)
  def enqueue(x: T) = new SlowHeadQueue(x :: smele)
}
















class Queue[T](
  private val leading: List[T],
  private val trailing: List[T]) {
  private def mirror =                        // 'amortized' complexity = O(1)
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