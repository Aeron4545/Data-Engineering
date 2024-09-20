class shape(){
  def area(): Double =0.0

}

//derived class
class Rectangle(val Height: Double,width : Double) extends shape{
  override def area() : Double= Height*width
}

//derived class
class Triangle(val base: Double, val Height: Double) extends shape {
  override def area() : Double=0.5*base*Height
}



object Polymorphism extends App {
  val shapes: List[shape] = List(new Rectangle(10, 11), new Triangle(12, 5))
  shapes.foreach(shape => println(shape.area()))
}

