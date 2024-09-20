object Functions {
  def main(args: Array[String]): Unit = {
    // Function: Function is block of coder which must do a certain task
    //1. Create function which takes user name as input anf prints greetings
    // Declare a function - UDF (User Defined Function)

    import scala.io.StdIn.*
    // Function takes one parameter
//    def greetings(name: String): Unit= {
//      print(s"Hello, $name welcome to UST.")
//
//    }
//
//    println("Please enter a username::")
//    val username = readLine()
//    // call a function with user's input
//    greetings(username)
//
//    // 2. Create a basic function which takes more than one user
//
//    println("Enter 2 numbers::")
//    var a=readInt()
//    var b=readInt()
//
//    def add(a: Int, b:Int): Int ={
//      a+b
//    }
//
//    println(add(a,b))
//
//    //Alternative : Using readLine()
//
//
//    println("Enter 2 numbers::")
//    var p = readLine("Enter first value::").toInt
//    var q = readLine("Enter second value::").toInt
//
//    def add1(p: Int, q: Int): Int = {
//      p+q
//    }
//
//    println(add1(p, q))
//
//
//    def calculator(a: Int, b: Int, op: String): Any = {
//      if (op=="+"){
//        return a+b
//      }else if(op=="-"){
//        return a-b
//      }else if(op=="*"){
//        return a*b
//      }else if(op=="/"){
//        return a/b
//      }
//    }
//
//    var x = readLine("Enter first value::").toInt
//    var y = readLine("Enter second value::").toInt
//    val op=readLine("Enter operations:: ")
//    println(calculator(x,y,op))
//
//    def divide(a:Int, b: Int=1): Float = {
//      return a/b
//    }
//    p= readLine("Enter first value: ").toInt
//    q=readLine("Enter a second value: ").toInt
//
//    println(divide(p))
//    println(divide(p,q))
//
//    // 5. Lambda Function Anonymous Function
//    val addition = (a: Int, b: Int) => a+b
//    println(addition(p,q))
//
//    //6. Higher Order Function: Function passed as parameter
//    // that takes another function as a parameter
//    def applyFunction(f: (Int,Int) => Int, value1: Int, value2: Int): Int = {
//      f(value1,value2)
//    }
//    applyFunction(add,p,q)

    //write a program to check and remove duplicate entry from a list
    var l=List(1,2,2,3,3,4)

    def duplicate(l: List[Int]): List[Int] = {
      var newlist = l.distinct
      newlist
    }
    println(duplicate1(l))
    //alternate method
    def duplicate1(l:List[Int]): List[Int] = {
      var s=l.toSet
      var newlist=s.toList
      newlist
    }
    println(duplicate(l))

    // Write a program to implement palindrome
    def palindrome(s:String): Boolean = {
      s==s.reverse
    }
    var word=readLine("Enter a word to check if palindrome or not::")
    println(palindrome(word))

    //create a scala function that return sthe factorial of a number

    def factorial(n: Int): Long = {
      if(n==0) 1
      else n*factorial(n-1)
    }
    //Example usage
    val number=readLine("Enter a number to calculate its factorial::").toInt
    println(s"Factorial of $number="+factorial(number))


  }
  }
