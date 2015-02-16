package cs493actors

import akka.actor._
import scala.collection.immutable.Queue

object BinarySearchTree {

  type ??? = Nothing

  trait Operation {
    def requester: ActorRef
    def id: Int
    def elem: Int
  }

  trait OperationReply {
    def id: Int
  }

  /**
   * Request with identifier `id` to insert an element `elem` into the tree.
   * The actor at reference `requester` should be notified when this operation
   * is completed.
   */
  case class Insert(requester: ActorRef, id: Int, elem: Int) extends Operation

  case class Contains(requester: ActorRef, id: Int, elem: Int) extends Operation

  case class Remove(requester: ActorRef, id: Int, elem: Int) extends Operation

  /** Request to perform garbage collection*/
  case object GC

  /**
   * Holds the answer to the Contains request with identifier `id`.
   * `result` is true if and only if the element is present in the tree.
   */
  case class ContainsResult(id: Int, result: Boolean) extends OperationReply

  /** Message to signal successful completion of an insert or remove operation. */
  case class OperationFinished(id: Int) extends OperationReply

}

class BinarySearchTree extends Actor {
  import BinarySearchTree._
  import BinaryTreeNode._

  def createRoot: ActorRef = context.actorOf(BinaryTreeNode.props(0, initiallyRemoved = true))

  var root = createRoot

  // optional
  var pendingQueue = Queue.empty[Operation]

  // optional
  def receive = normal

  // optional
  /** Accepts `Operation` and `GC` messages. */
  val normal: Receive = {
    case c: Operation => root ! c
    case c: GC => {
      var n = createRoot
      context.become(garbageCollecting(n))
      root ! CopyTo(n)
    }
  }

  // optional
  /**
   * Handles messages while garbage collection is performed.
   * `newRoot` is the root of the new binary tree where we want to copy
   * all non-removed elements into.
   */
  def garbageCollecting(newRoot: ActorRef): Receive = {
    case c: Operation => pendingQueue = pendingQueue.enqueue(msg)
    case c: GC => ??? // ignore
    case c: CopyFinished => {
      while (!pendingQueue.isEmpty) {
        val (msg, q) = pendingQueue.dequeue
        n ! msg
        pendingQueue = q
      }
      root ! PoisonPill
      root = n
      context.become(normal)
    }

  }

}

object BinaryTreeNode {
  trait Position

  case object Left extends Position
  case object Right extends Position

  case class CopyTo(treeNode: ActorRef)
  case object CopyFinished

  def props(elem: Int, initiallyRemoved: Boolean) = Props(classOf[BinaryTreeNode], elem, initiallyRemoved)
}

class BinaryTreeNode(val elem: Int, initiallyRemoved: Boolean) extends Actor {
  import BinaryTreeNode._
  import BinarySearchTree._

  // optional
  var subtrees = Map[Position, ActorRef]()

  var removed = initiallyRemoved

  // optional
  def receive = normal

  // optional
  /** Handles `Operation` messages and `CopyTo` requests. */
  val normal: Receive = {
    case message @ Contains(requester, id, item) => {
      if (item == elem) requester ! ContainsResult(id, !removed)
      else if (item < elem) {
        if (subtrees.contains(Left)) subtrees(Left) ! message
        else requester ! ContainsResult(id, false)
      } else {
        if (subtrees.contains(Right)) subtrees(Right) ! message
        else requester ! ContainsResult(id, false)
      }
    }
    case message @ Insert(requester, id, item) => {
      if (item == elem) {
        if (removed) removed = false
        requester ! OperationFinished(id)
      } else {
        //TODO: refactor this 
        if (item < elem) {
          if (subtrees contains Left) subtrees(Left) ! message
          else {
            subtrees += (Left, context.actorOf(props(item, false)))
            requester ! OperationFinished(id)
          }
        } else {
          if (subtrees contains Right) subtrees(Right) ! message
          else {
            subtrees += (Right, context.actorOf(props(item, false)))
            requester ! OperationFinished(id)
          }
        }
      }
    }
    case message @ Remove(requester, id, item) => {
      if (item == elem) {
        removed = true
        requester ! OperationFinished(id)
      } else if (item < elem) {
        if (subtrees contains Left)
          subtrees(Left) ! message
        else requester ! OperationFinished(id)
      } else {
        if (subtrees contains Right) subtrees(Right) ! message
        else requester ! OperationFinished(id)
      }
    }
    case message @ CopyTo(treeNode) => {
      val c = subtrees.values.toSet
      if (c.isEmpty && removed) context.parent ! CopyFinished
      else {
        if (!removed) treeNode ! Insert(self, elem, elem)
        children.foreach(x ! copy)
        context.become(copying(children, removed))
      }
    }
    case _ => throw new Exception()
  }

  // optional
  /**
   * `expected` is the set of ActorRefs whose replies we are waiting for,
   * `insertConfirmed` tracks whether the copy of this node to the new tree has been confirmed.
   */
  def copying(expected: Set[ActorRef], insertConfirmed: Boolean): Receive = {
    case OperationFinished(id) => {
      if (expected.isEmpty) context.parent ! CopyFinished
      context.become(copying(expected, true))
    }
    case CopyFinished => {
      val n = expected - sender
      if (n.isEmpty && insertConfirmed) {
        context.parent ! CopyFinished
        context.become(normal)
      } else {
        context.become(copying(n, insertConfirmed))
      }
    }
  }
  /* or maybe something else */

}