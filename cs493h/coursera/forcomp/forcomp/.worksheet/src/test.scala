import forcomp.Anagrams._

object test {;import org.scalaide.worksheet.runtime.library.WorksheetSupport._; def main(args: Array[String])=$execute{;$skip(84); 
  println("Welcome to the Scala worksheet");$skip(42); 
 
    val abba = List(('a', 2), ('b', 2));System.out.println("""abba  : List[(Char, Int)] = """ + $show(abba ));$skip(266); 
    val abbacomb = List(
      List(),
      List(('a', 1)),
      List(('a', 2)),
      List(('b', 1)),
      List(('a', 1), ('b', 1)),
      List(('a', 2), ('b', 1)),
      List(('b', 2)),
      List(('a', 1), ('b', 2)),
      List(('a', 2), ('b', 2))
     
    );System.out.println("""abbacomb  : List[List[(Char, Int)]] = """ + $show(abbacomb ));$skip(23); val res$0 = 
    combinations(abba);System.out.println("""res0: List[forcomp.Anagrams.Occurrences] = """ + $show(res$0))}
}
