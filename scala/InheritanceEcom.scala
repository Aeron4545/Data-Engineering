class Ecom (val name: String, val quantity: Float, val price: Float){
  def displayDetails(): Unit={

  }
}

//Inheritance - Electronics
class Electronics(name: String,quantity: Float,price: Float) extends Ecom(name,quantity,price){
  override def displayDetails(): Unit = {
    val total: Float = quantity * price
    println(s"Footwear Product Name: $name\nQuantity:$quantity\nPrice:$price\nTotal Price=$total")

  }
}


// Inheritance - Books

class Books(name: String,quantity: Float,price: Float) extends Ecom(name,quantity,price){
  override def displayDetails(): Unit = {
    val total: Float = quantity * price
    println(s"Books Product Name: $name\nQuantity:$quantity\nPrice:$price\nTotal Price=$total")

  }
}

//Inheritance - Footwear
class Footwear(name: String,quantity: Float,price: Float) extends Ecom(name,quantity,price){
  override def displayDetails(): Unit = {
    val total: Float=quantity*price
    println(s"Footwear Product Name: $name\nQuantity:$quantity\nPrice:$price\nTotal Price=$total")

  }
}

object ecomSample extends App{
  val electronics=new Electronics("Phone",2,30000)
  val book=new Books("News Paper",5,10)
  val footwear=new Footwear("Flip Flops",3,500)

  electronics.displayDetails()
  println()
  book.displayDetails()
  println()
  footwear.displayDetails()
}



















