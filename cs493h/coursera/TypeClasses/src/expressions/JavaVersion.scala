package expressions

trait JsonConvertible {
  def convertToJson : JsonValue
}


sealed trait ExpressionJ extends JsonConvertible

case class NumberJ (value : Int)  extends ExpressionJ {
  def convertToJson : JsonValue = JsonNumber(value)
  
}
case class PlusJ (lhs: ExpressionJ, rhs : ExpressionJ) extends ExpressionJ{
  def convertToJson : JsonValue = JsonObject (
      Map("op" -> JsonString("+"),
          "lhs" -> lhs.convertToJson,
          "rhs" -> rhs.convertToJson))
  
}
case class MinusJ (lhs: ExpressionJ, rhs : ExpressionJ) extends ExpressionJ {
  def convertToJson : JsonValue = JsonObject (
      Map("op" -> JsonString("-"),
          "lhs" -> lhs.convertToJson,
          "rhs" -> rhs.convertToJson))
}

