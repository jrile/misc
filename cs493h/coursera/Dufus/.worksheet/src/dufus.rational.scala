package dufus

object rational {;import org.scalaide.worksheet.runtime.library.WorksheetSupport._; def main(args: Array[String])=$execute{;$skip(63); 
  

	val r = new Rational(3,4);System.out.println("""r  : dufus.Rational = """ + $show(r ));$skip(7); val res$0 = 
	3 + r;System.out.println("""res0: dufus.Rational = """ + $show(res$0))}
	 
}
