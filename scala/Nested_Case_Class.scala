
object Nested_Case_Class {
  def main(args: Array[String]): Unit = {

    //case class sides(x: Int, y: Int)
    case class Employee(name: String, id: Int)

    // Define a case classs for a Department, which contains a list of employee
    case class Department(deptname: String, employees: List[Employee])

    //create an instance of Employee
    val emp1 =Employee("John",123456)
    val emp2=Employee("Thomas",789056)
    val emp3=Employee("Norea",74444444)

    //Create Instance of Department

    val dept1=Department("HR",List(emp1,emp2))
    val dept2=Department("I1",List(emp3))

    //Pattern Matching with another case class

    dept1 match {
      case Department(deptname,employees) =>
        println(s"Department: $deptname")
        employees.foreach{
          case Employee(name, id)=>
            println(s"Employee:$name, id: $id")
        }
    }

    dept2 match {
      case Department(deptname, employees) =>
        println(s"Department: $deptname")
        employees.foreach {
          case Employee(name, id) =>
            println(s"Employee:$name, id: $id")
        }
    }

  }

}
