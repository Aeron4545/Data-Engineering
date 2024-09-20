//In scala programming switch is referred as Match.

object MatchCase {
  def main(args: Array[String]): Unit = {
    def DayOfWeek(day: Int): String = day match {
      case 1 => "Sunday"
      case 2 => "Monday"
      case 3 => "Tuesday"
      case 4 => "Wednesday"
      case 5 => "Thursday"
      case 6 => "Friday"
      case 7 => "Saturday"
      case _ => "Invalid Day"
    }

    println(DayOfWeek(1))
    println(DayOfWeek(2))
    println(DayOfWeek(3))
    println(DayOfWeek(10))

    def StringMatch(day: String): String = day match {
      case "Varun" => "Hello Varun"
      case "John" => "Hello John"
      case "Kiran" => "Hello Kiran"
      case "Sam" => " Hello Sam"
      case _ => "Hello Stranger"
    }
    println(StringMatch("Varun"))
    
    }
  }