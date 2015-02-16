import scala.language.postfixOps
import scala.util._
import scala.util.control.NonFatal
import scala.concurrent._
import scala.concurrent.duration._
import ExecutionContext.Implicits.global
import scala.async.Async.{async, await}

package object cs493 {

  implicit class FutureCompanionOps[T](val f: Future.type) extends AnyVal {

    def always[T](value: T): Future[T] = Promise.successful(value).future

    def never[T]: Future[T] = Promise.failed(new Exception).future

    def all[T](fs: List[Future[T]]): Future[List[T]] = ???

    def any[T](fs: List[Future[T]]): Future[T] = ???

    def delay(t: Duration): Future[Unit] = ???

    def userInput(message: String): Future[String] = Future {
      readLine(message)
    }

    def run()(f: CancellationToken => Future[Unit]): Subscription = ???

  }

  implicit class FutureOps[T](val f: Future[T]) extends AnyVal {

    def now: T = ???

    def continueWith[S](cont: Future[T] => S): Future[S] = ???

    def continue[S](cont: Try[T] => S): Future[S] = ???

  }

  trait Subscription {
    def unsubscribe(): Unit
  }

  object Subscription {
    def apply(s1: Subscription, s2: Subscription) = new Subscription {
      def unsubscribe() {
        s1.unsubscribe()
        s2.unsubscribe()
      }
    }
  }

  trait CancellationToken {
    def isCancelled: Boolean
    def nonCancelled = !isCancelled
  }

  trait CancellationTokenSource extends Subscription {
    def cancellationToken: CancellationToken
  }

  object CancellationTokenSource {
    def apply(): CancellationTokenSource = ???
  }

}

