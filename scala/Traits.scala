// Traits:
// A trait is special type of class used to define collection of methods
// and field names that can be reused across different classes.

//Traits Usage: Code Reusability in scala, Instead of duplicating code in multiple
//classes, you can define common functionality in a trait then mix it with any class

//scala does not support multiple inheritance
// (A class inherited from more than one class)
//But traits help you to achieve this. A class can extend one class and
//mix it in multiple traits.

trait Drivable{
  def drive(): Unit
}

trait Flyable{
  def fly(): Unit={
    println("Flying in the sky")
  }
}

class car(val make: String,val model: String) extends Drivable{
  override def drive(): Unit = {
    println(s"Driving a $make $model")
  }
}

class Airplane(val make: String,val model: String) extends Flyable with Drivable{
  override def drive(): Unit = {
    println(s"Driving a $make $model")
  }
  override def fly(): Unit = {
    println("Airplane is flying at 30000 feet")
  }
}

object Trait extends App{
  val carobj=car("Maruti","Ignis")
  val aeroplaneobj=Airplane("AirIndia","f43")
  carobj.drive()
  aeroplaneobj.fly()
}


