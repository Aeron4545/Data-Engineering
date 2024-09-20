class Animal (val name: String){
  def makesound():Unit={
    println(s"$name make sound")
  }
}

//subClass

class Dog(name: String) extends Animal(name){
  override def makesound(): Unit = {
    println(s"$name make sound: woof!")
  }
}

object InheritanceExample extends App{
  val animal = new Animal("Generic Name")
  animal.makesound()

  val dog= new Dog("Spike")
  dog.makesound()
}