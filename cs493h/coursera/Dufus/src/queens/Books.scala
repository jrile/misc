package queens

case class Book(title: String, authors: String*)

object Book {

  val books: List[Book] = List(
    Book(
      "Structure and Interpretation of Computer Programs",
      "Abelson, Harold", "Sussman, Gerald J."),
    Book(
      "Principles of Compiler Design",
      "Aho, Alfred", "Ullman, Jeffrey"),
    Book(
      "Programming in Modula-2",
      "Wirth, Niklaus"),
    Book(
      "Elements of ML Programming",
      "Ullman, Jeffrey"),
    Book(
      "The Java Language Specification", "Gosling, James",
      "Joy, Bill", "Steele, Guy", "Bracha, Gilad"))

  val x = for (
    b <- books;
    a <- b.authors if a startsWith "Gosling"
  ) yield b.title

  val v = for (b <- books if (b.title indexOf "Program") >= 0)
    yield b.title
}