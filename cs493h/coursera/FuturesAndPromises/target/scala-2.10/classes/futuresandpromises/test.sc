package futuresandpromises
import scala.language.postfixOps
import scala.util._
import scala.util.control.NonFatal
import scala.concurrent._
import scala.concurrent.duration._
import ExecutionContext.Implicits.global
import scala.async.Async.{async, await}
import futuresandpromises._
object test {
	
	Await.result(Future.always(33), 0 second)
}