package expressions

object ExpressionHelper {

  
  implicit val expressionJsonConverter = new JsonConverter[Expression] {
    def convertToJson(expr : Expression) :  JsonValue = 
      expr match {
      case Number(value) => JsonNumber(value)
      case Plus(lhs, rhs) => JsonObject (
          Map("op" -> JsonString("+"),
          "lhs" -> convertToJson(lhs),
          "rhs" -> convertToJson(rhs)))
      case Minus(lhs, rhs) => JsonObject (
          Map("op" -> JsonString("-"),
          "lhs" -> convertToJson(lhs),
          "rhs" -> convertToJson(rhs)))
    }
  }
}