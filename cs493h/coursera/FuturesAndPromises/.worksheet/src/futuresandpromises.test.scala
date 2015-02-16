package futuresandpromises
import scala.language.postfixOps
import scala.util._
import scala.util.control.NonFatal
import scala.concurrent._
import scala.concurrent.duration._
import ExecutionContext.Implicits.global
import scala.async.Async.{async, await}
import futuresandpromises._

object test {;import org.scalaide.worksheet.runtime.library.WorksheetSupport._; def main(args: Array[String])=$execute{;$skip(321); val res$0 = 
	
	Future.always(156);System.out.println("""res0: scala.concurrent.Future[Int] = """ + $show(res$0))}
}
