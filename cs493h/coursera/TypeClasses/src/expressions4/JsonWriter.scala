package expressions4

object JsonWriter {

  def write(value: JsonValue): String =
    value match {
      case JsonObject(entries) => {
        val serializedEntries =
          for ((key, value) <- entries) yield key + ": " + write(value)
        "{ " + (serializedEntries mkString ", ") + " }"
      }
      case JsonArray(entries) => {
        val serializedEntries = entries map write
        "[ " + (serializedEntries mkString ", ") + " ]"
      }
      case JsonString(value) => "\"" + value + "\""
      case JsonNumber(value) => value.toString
      case JsonBoolean(value) => value.toString
      case JsonNull => "null"
    }

  //implicit as a hidden parameter
//  def write[A](value : A)(implicit conv : JsonConverter[A]) : String = 
//    write (conv.convertToJson(value))

  // context-bound implicits
  def write[A: Json](value: A): String = {
    val conv = implicitly[Json[A]]
    write(conv.json(value))
  }

}

trait Json[-A] {
  def json(value: A): JsonValue
}

object Json {
  implicit val intJson = new Json[Int] {
    def json(n : Int) : JsonValue = new JsonNumber(n)
  }
  
  implicit def pairJson[T1:Json, T2:Json] = new Json[(T1,T2)] {
    def json (pair : (T1,T2)) : JsonValue = new JsonObject(
    		Map ( "fst" -> implicitly[Json[T1]].json(pair._1),
    				"snd" -> implicitly[Json[T2]].json(pair._2)
    		)
    )
  }
      
  
}




//trait Json[-A] {
//  def json(value: A) : JsonValue
//}
