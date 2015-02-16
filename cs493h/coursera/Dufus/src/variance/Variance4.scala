package variance

class QueueFinal[-T] private (
  private[this] var leading: List[T],
  private[this] var trailing: List[T]) {
  private def mirror() =
    if (leading.isEmpty) {
      while (!trailing.isEmpty) {
        leading = trailing.head :: leading
        trailing = trailing.tail
      }
    }
  def head: T = {
    mirror()
    leading.head
  }
  def tail: QueueFinal[T] = {
    mirror()
    new QueueFinal(leading.tail, trailing)
  }
  def enQueueFinal[U >: T](x: U) =
    new QueueFinal[U](leading, x :: trailing)
}