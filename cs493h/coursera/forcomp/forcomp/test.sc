import forcomp.Anagrams._

object test {
  println("Welcome to the Scala worksheet")       //> Welcome to the Scala worksheet
 
    val abba = List(('a', 2), ('b', 2))           //> abba  : List[(Char, Int)] = List((a,2), (b,2))
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
     
    )                                             //> abbacomb  : List[List[(Char, Int)]] = List(List(), List((a,1)), List((a,2)),
                                                  //|  List((b,1)), List((a,1), (b,1)), List((a,2), (b,1)), List((b,2)), List((a,1
                                                  //| ), (b,2)), List((a,2), (b,2)))
    combinations(abba)                            //> res0: List[forcomp.Anagrams.Occurrences] = List(List((a,2)), List((b,2)), Li
                                                  //| st(), List((b,1)), List(), List((a,1)), List((b,2)), List(), List((b,1)), Li
                                                  //| st())
}