import scala.io.StdIn.*
object Calculator_Match_Case {
  def main(args: Array[String]): Unit = {
    println("Enter first number::")
    val a = readInt()
    println("Enter second number::")
    val b = readInt()
    val op = readLine("Enter operation::")

    def Calculator(day: String, a: Float, b: Float): Any = day match {
      case "+" => a + b
      case "-" => a - b
      case "*" => a * b
      case "/" => if b != 0 then (a / b) else "Division by zero not allowed"
      case "^" => math.pow(a, b)
      case _ => "Invalid Choice"
    }
    println("Result=" + Calculator(op, a, b))
  }
}


