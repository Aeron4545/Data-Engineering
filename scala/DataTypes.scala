//Primitive data types
object DataTypes { //singleton object
  def main(args: Array[String]): Unit = {

    //Primitive Data Types
    //Numeric Types
    // Immutable Datatype

    var intValue: Int = 25
    var doubleValue: Double = 23.234234324
    var longIntValue: Long = 9495434706L
    var myFloatValue: Float = 123.23F

    var charValue: Char = 'A'
    var message: String = "hello Scala"
    var byteValue: Byte = 127

    //val byteValue: Byte = 127
    val booleanValue: Boolean = true

    println("Integer Values:"+intValue)
    println("Double Data Type:"+doubleValue)
    println("String Datatype:"+message)
    println("Boolean Datatype:"+booleanValue)

    //Re initialize value
    charValue='B'

    //intValue=101 //cannot be reassigned to intValue

    println("Char New Value: "+charValue)

  }
}



