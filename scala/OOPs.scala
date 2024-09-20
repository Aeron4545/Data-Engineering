 // Define a class
 class  Car(val make: String, val model:String, var year:Int) {
   def displayInfo(): Unit = {
     println(s"Car Info: $year $make $model")
   }
 }


 //Create an object of class Car
 // singleton object extends App (trait) which does not need main() anymore
 //i.e when main is not defined this SimpleClass need to be defined
 // and trait known as app will make it unnecessary to define main
 object SimpleClass extends App{
   val car=new Car("Hyundai","Creta",2023)
   car.displayInfo()
 }
