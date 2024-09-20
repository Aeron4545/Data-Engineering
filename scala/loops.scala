object loops {
  def main(args: Array[String]): Unit = {
    var variable = 1

    //A simple while loop syntax that print numbers from 1 to 9
    while (variable < 10) {
      println(variable)
      variable += 1
    }

    // for loop
    val fruits = List("Apples", "Banana", "Cherry", "Oranges", "Pineapple")

    for (fruit <- fruits) {
      println(fruit)
    }

    for (i <- 1 to 10) {
      println(i)
    }

    for (i <- 1 to 10 by 2) {
      println(i)
    }

    val food_list = List("idli", "vada", "dosa", "uttapam", "biryani", "chocolate", "curd")
    for (i <- food_list) {
      println(i)
    }

    //filtering records in for loop using if-condition

    //1.write a scala program that creates a collection of even array
    import scala.collection.mutable.ArrayBuffer
    val evenArray = ArrayBuffer[Int]()
    for (i <- 1 to 20 if i % 2 == 0) {
      evenArray += i
    }
    println()
    println("Even array is ::" + evenArray.mkString(","))

    // 2. Write a scala program to show collection of prime number between 1 to 100
    val prime = ArrayBuffer[Int]()
    for (i <- 2 to 100) {
      var f: Int = 1
      for (j <- 2 to math.sqrt(i).toInt if i % j == 0) { //because we only need to check
        // till below half after that it will be the same
        f = 0
      }
      if (f == 1) {
        prime += i
      }

    }
    println("Prime collection::" + prime.mkString((",")))

    //for loop using until
    print("For loop using 'until'::")
    for (i <- 1 until 5) {
      print(i + ",")
    }
    //3.Fibonacci series using while loop
    var i: Int = 1
    var j: Int = 1
    var s: Int = 0
    println()
    print("Fibonacci:")
    print(0 + "," + 1 + "," + 1)
    while (i < 10) {
      s = i + j
      print("," + (i + j))
      i = j
      j = s
    }
    //4.Find first prime number greater than given number
    import scala.io.StdIn._
    println()
    println("Please enter a value:")
    val a = readInt()
    var p = false
    var k: Int = a+1
    while (p == false) {
      var f: Int = 1
      var j: Int = 2
      while (j < math.sqrt(k).toInt) {
        if (k % j == 0) {
          f = 0
        }
        j = j + 1
      }
      if (f == 1) {
        println("The next greater prime is::"+k)
        p=true
      }
      k=k+1
    }
  }
}
