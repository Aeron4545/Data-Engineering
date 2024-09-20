
class Employee(private var empname: String, private var salary: Int) {
      //setter
      def setName(newEmpName: String): Unit = {
        if(newEmpName.nonEmpty) empname=newEmpName
      }

      //getter
      def getName: String = empname

      //setter
      def setSalary(newSal: Int): Unit = {
        if (newSal > 0) salary = newSal
      }

      //getter
      def getSalary: Int = salary

}

object Encapsulation extends App {
  val emp1 = new Employee("Tom",23345662)
  println(emp1.getName)
  println(emp1.getSalary)
  emp1.setName("John")
  emp1.setSalary(1000000000)
  println(emp1.getName)
  println(emp1.getSalary)
}