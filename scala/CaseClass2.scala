

object CaseClass2 {
  def main(args: Array[String]): Unit = {
    //Define a case class
    case class Employee(name: String, age: Int)

    //Create an Instance (Object) of case class

    val obj = Employee("Aeron", 22)

    //Access fields
    println(obj.name)
    println(obj.age)


    //Pattern Matching
    obj match {
      case Employee(name, age) => println(s"Name: $name, Age: $age")
    }


    //Create copy with modified fields
    val olderObj = obj.copy(name="John", age=31)
    println()
  }
}