// case classes are special classes in that are immutable
// and compared by value. They are idea use in pattern matching

case class Person(name: String, age: Int)
  object CaseClass extends App{
    // Create an instance of case class
    val person1=Person("Tom",10)
    val person2=Person("Jerry",3)

    println(person1)
    println(person2)

    //copy a case class
    val person3 = person1.copy(age=26)
    println(person3)

    //pattern matching with case class
    person1 match {
      case Person(name, age) => println(s"Name: $name, Age:$age")
    }
  }

