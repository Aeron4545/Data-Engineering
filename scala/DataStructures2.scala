object DataStructures2{
  def main(args: Array[String]): Unit= {
    //Scala Collection - Map
    //Map : Collection of key-value pairs, Map can be either mutable or immutable
    //By default, map is immutable
    val fruitbasket = Map("Apricot" -> 20, "Blueberry" -> 250, "Cherry" -> 100, "Donuts" -> 24, "Eclairs" -> 1)

    //Mutable Maps
    import scala.collection.mutable
    val mutableMap = mutable.Map("Apricot" -> 20, "Blueberry" -> 250, "Cherry" -> 100, "Donuts" -> 24, "Eclairs" -> 1)

    //Basic operations
    val value = fruitbasket("Donuts")
    println("Accesing number of donuts by key Donuts"+fruitbasket.contains("Donuts"))

    val mapSize=fruitbasket.size
    println(mapSize)

    val keys=mutableMap.keys
    val values=mutableMap.values

    //adding and removing in map we can do in mutable map
    //if done on immutable it will not be updated but will work
    //else we need to store

    mutableMap += ("Fig"->24)
    mutableMap -=("Eclairs")

    //apply same on immutable
    val new_fruitbasket =fruitbasket + ("Fig"->24)

    //updating the value in key fig
    mutableMap("Fig")=55

    // Scala Sets - A set is collection in scala which contains
    // no duplicate values. Sets can be mutable or immutable,
    // by default sets are immutable.

        val set1 = Set(1, 2, 3, 4, 5, 6, 7, 8)
        val set2 = Set("Apple", "Banana", "Cheery", "Grapes", "Tomato",
          "Oranges", "Watermelon", "Pineapple")

        // Basic Operations
        println(set1.contains(5))
        println(set1.size)
        println(set1 + 9)

        // Union of sets
        val set3 = Set("Grapes", "Tomato", "Guava", "Oranges", "Banana")
        val fruitBasket = set2 union set3
        println(fruitBasket)

        // Intersect : Common value between Two Sets.
        val interSet = set2 intersect set3

        // Difference
        val diffSet = set2 diff set3
        println(diffSet)

        val diffSet1 = set3 diff set2
        println(diffSet1)

        // subset check
        val isSubset = set2.subsetOf(set3)
        println(isSubset)

        // Transformation - map, filter, reduce
        println(set3.map(_.toLowerCase()).mkString(","))
        println(set1.map(_ * 2).mkString(","))
        println(set3.filter(_.startsWith("G")).mkString(","))

        // mutable Sets
        val set4 = mutable.Set(10, 20, 30, 40, 50, 60, 70)
        set4 += 10
        set4 ++= Set(80, 90)
        set4 --= Set(10, 20)

        // clear Sets
        set4.clear()

        // create a new collection
        val fruitList = List("apple", "apricot", "banana", "chocolate", "coconut")
        val mapFruits = fruitList.groupBy(_.head)
        val newmapFruits: mutable.Map[Char, List[String]] = mutable.Map(mapFruits.toSeq: _*)

    print(newmapFruits.mkString(","))

    newmapFruits ++=Map('d' -> List("Dragon Fruit"),'e'->List("Eclairs"))
    println(newmapFruits.mkString(","))

    // Tuple Datatype
    // Tuple: Collection of immutable datatype, fixed size, heterogenous
    val tuple1= (1,"Hello Tuple",3.14,"Scala",9876543210L) //L denotes large number
    //index position starts from 1
    val firstValue=tuple1._1
    val secondValue=tuple1._2
    val thirdValue=tuple1._3

    //pattern matching in tuple
    val(var1,var2,var3) = (1,"Scala",3.14)

    println("Value 1"+var1)
    println("Value 2"+var2)
    println ("Value 3" + var3)

    //Returns number of elements present in tuple
    println(tuple1.productArity)

    //Returns datatype of variable
    println(tuple1.getClass)

    //copy : allows you to copy tuple with some elements replaced
    val newtuple=tuple1.copy(_4 = "Tuple")
    println(newtuple)

    //=>(Arrow function)
    //In scala, => is used to denote a lambda expression or anonymous function
    //(parameter) => expression
    tuple1.productIterator.foreach{
      (element => println(s"Element: $element"))
      
    }

  }
}
