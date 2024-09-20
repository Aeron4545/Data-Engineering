//Define case class
//Case classes in scala are special kind of class that is used for
//modelling immutable data structure
//case classes will automatically provide useful methods:
//toSting, equals, hashCode,copy built-in support for pattern matching.

// Case class are immutable 


case class Person1(name: String, age:Int)


//Main Object
object Main extends App{
  val person=Person1("Tom",100)

  //Define a function to describe a Person
  //create object of case class
  def describePerson(person: Any): String=person match{
    case Person1(name,age)=>s"Person Name: $name, age: $age"
}
  //Test functionality
  println(describePerson(person))
}





