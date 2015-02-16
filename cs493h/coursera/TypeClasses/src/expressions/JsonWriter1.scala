package expressions

object JsonWriter1 {

  def write (value : JsonValue) : String =
    value match {
    case JsonObject(entries) => {
      val serializedEntries = 
        for((key, value) <- entries) yield key + ": " + write(value)
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
  
  /* 
   * def write(value : ???) : String = write(value.???)
   */
  
  def write(value : JsonConvertible) : String = 
    write (value.convertToJson)
}