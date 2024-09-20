object DataStructures{
  def main(args:Array[String]): Unit={

    //Collection of data types
    //In scala , a list is an immutable, heterogeneous ordered
    //sequence of elements. Lists are fundamental parts of scala programming
    //Lists: Immutable, homogenous, Variable Length,
    val valList : List[String]=List("Apricot","Blueberry","Cherry","Donuts","Eclairs")
    print(valList)
    //collection.foreach(println) it takes print newline
    valList.foreach(println)
    //Empty List Declaration
    val emptyList:List[Nothing]=List()

    //methods of list

    val firstelement=valList.head

    val restOfList=valList.tail

    val lastValue=valList.last

    val secondValue=valList(3)

    val length=valList.length

    //print all values

    println("Display first value:"+firstelement)
    println("Display rest of values:"+restOfList)
    println("Display last value:"+lastValue)
    println("Display second value:"+secondValue)
    println("Display length:"+length)

    // val appendList= valList:+"Fig" - append in existing list is not possible
    //due to its immutability

    val newList=valList :+ "Fig"
    println("New list after appending fig"+newList)

    //to check if list is empty
    println("Is valList empty ? "+valList.isEmpty)

    val newValList=List("Fig","Grapes","Hazelnut")

    //concatenation of list
    val fruitBasket=valList++newValList
    println(fruitBasket)

    //Transformation of list
    val list_1=List(1,2,3,4,5,6,7,8,9,10)
    println(list_1.map(_*3))
    val evenNum=list_1.filter(_%2==0)
    print("Even number: "+evenNum)

    val nestedList=List(List("Delhi","Kochi","Bengaluru"),
                        List("Pune","Mumbai","Varkala"),
                        List("Trivandrum","Visakhapatnam","Kottayam"))

    //identity is predefined function A=>A
    println(nestedList)
    println(nestedList.flatMap(identity))
    println(list_1.filter(_%2==0).reduce(_+_))

    //Returns list of characters Length fromm input List
    println(fruitBasket.map(_.length))

    //Returns boolean value if string starts with String "A"
    println(fruitBasket.map(_.startsWith("A")))

    //sort the list by word length
    val sortedList=fruitBasket.sortWith(_.length<_.length)
    println(sortedList)

    val sortedCity=nestedList.flatten.sortBy(_.length)
    println(sortedCity)

    //Display list of city that begins with letter K
    val city_start_K=nestedList.flatten.filter(_.startsWith("K"))

    //alternate method
    //val city_start_K=nestedList.flatten.filter(_.head=='K'))

    println("City that start with A:"+city_start_K)

    //subset and slicing

    val city=nestedList.flatten

    //subset and slicing
    val city_1= nestedList.flatten
    println("Original list::"+city_1)
    println("First 5::"+city.take(5))
    println("First 5 from right::"+city.takeRight(5))
    println("Dropping first::"+city.drop(1))
    println("Dropping 2 from right::"+city.dropRight(2))

    //slicing the lists using start index and last position
    println("Slicing 1 to 6::"+city.slice(1,6))

    //slicing using random index position (0,2,4,5,7,9)
    val indices= List(0,2,4,5,7,9)
    //lift(): It is method that retrieves an element at specified index
    println(indices.flatMap(index=> city.lift(index)))

    val population= List(30290936, 743000, 13450000, 3124451, 20867900, 20800, 904000, 1910000, 115000)

    val pairedlist=city_1.zip(population)
    println(pairedlist)



    //Arrays: Mutable Collection, indexed with sequence
    //Array provides fast access and modification comparitively. making them useful
    //useful, for performance critical applications.

    val emptyArray=Array[Int]()
    val Array1=Array(1,2,3,4,5,6)


    val firstElement=Array(0)
    val secondElement=Array(0)

    //update the existing value

    Array1(0)=10

    Array1.foreach(println)

    //getting length of an array

    println(Array1.length)

    //adding or removing values from an array
    //Array1 += 7
    //Array -= 3
    //cannot do this as it has a fixed length here

    import scala.collection.mutable.ArrayBuffer
    val arrayBuffer=ArrayBuffer(1,2,3,4,5,6,7,8,9,10)

    arrayBuffer +=1
    arrayBuffer -=1

    val newArray=arrayBuffer.toArray

    newArray.foreach(println)

    //apply mkstring to collection of array, lists, etc

    println(newArray.mkString(","))

    //creating an Array Buffer passing arrays as elements

    //val Array2=ArrayBuffer(Array1:_*)
    //Array2.foreach(Array2)

    //map,filter,

    val a=Array(Array(1,2,3),Array(4,5,6),Array(7,8,9))

    //array transformations
    //apply flatten
    println("Flatten")
    println(a.flatten.mkString(","))
    //applying map
    println("Map")
    println(a.flatten.map(_*2).mkString(","))
    //applying filter
    println("Filter")
    println(a.flatten.filter(_%2==0).mkString(","))
    //applying reduce
    println("Reduce")
    println(a.flatten.reduce(_+_))


    //subset and slicing
    val a_flattened = a.flatten
    println("Original list::" + a_flattened.mkString(","))
    println("First 5::" + a_flattened.take(5).mkString(","))
    println("First 5 from right::" +  a_flattened.takeRight(5).mkString(","))
    println("Dropping first::" +  a_flattened.drop(1).mkString(","))
    println("Dropping 2 from right::" +  a_flattened.dropRight(2).mkString(";"))
    println(a_flattened.mkString(",")) //here drop and all will work as the array is not being
    // altered if int is to be saved it
    // has to be don eon a buffer or into a buffer


    //slicing the lists using start index and last position
    println("Slicing 1 to 6::" + a_flattened.slice(1, 6).mkString(","))

    val unsorted=Array(200,100,199,50,1)
    print("Sorted array:"+unsorted.sorted.mkString(","))
  }
}