import scala.language.postfixOps
import scala.util._
import scala.util.control.NonFatal
import scala.concurrent._
import scala.concurrent.duration._
import ExecutionContext.Implicits.global
import scala.async.Async.{ async, await }

/**
 * Contains basic data types, data structures and `Future` extensions.
 */
package object nodescala {
  implicit class FutureCompanionOps[T](val f: Future.type) extends AnyVal {

    def always[T](value: T): Future[T] = Promise.successful(value).future

    def never[T]: Future[T] = Promise.failed(new TimeoutException).future

    def all[T](fs: List[Future[T]]): Future[List[T]] = {
      val promise = Promise[List[T]]
      promise.success(Nil)
      fs.foldRight(promise.future) {
        (f, a) =>
          for {
            x <- f
            xs <- a
          } yield x :: xs
      }

    }

    def any[T](fs: List[Future[T]]): Future[T] = {
      val prom = Promise[T]()
      for (f <- fs) {
        prom.tryCompleteWith(f)
      }
      prom.future
    }

    def delay(t: Duration): Future[Unit] = Await.result(Future.never, t)

    def userInput(message: String): Future[String] = Future {
      readLine(message)
    }

    def run()(f: CancellationToken => Future[Unit]): Subscription = {
      val cancelTokenSource = CancellationTokenSource()
      f(cancelTokenSource.cancellationToken)
      cancelTokenSource
    }

  }

  implicit class FutureOps[T](val f: Future[T]) extends AnyVal {

    def now: T = Await.result(f, 0 seconds)

    def continueWith[S](cont: Future[T] => S): Future[S] = async { cont(f) }

    def continue[S](cont: Try[T] => S): Future[S] = async { cont(f.value.get) }

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
    def apply(): CancellationTokenSource = {
      val p = Promise[Unit]()
      val token = new CancellationToken {
        def isCancelled = p.future.value != None
      }
      def unsubscribe() = p.trySuccess(())
    }
  }

}

