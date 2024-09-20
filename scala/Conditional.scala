object Conditional{
  def main(args: Array[String]): Unit = {

    //if condition
    val x=10
    if (x>5){
      println(s"$x is greater than 5")
    } else {
      println(s"$x is less than 5")
    }

    //if-else as an expression
    val y = 3
    val result = if (y % 2== 0) "Even" else "Odd"
    println(result)

    //check ternary operation and list comprehension in scala and in python

    //Ask user to input the data

    import scala.io.StdIn._
    println("Please enter a value: ")
    // Read user input and convert to integer
    val value = readInt()

    val result1 = if (value % 2 == 0) "Even" else "Odd"
    println(result1)

    //Create a program which asks user to input mark and return grade

    println("Enter your marks:")
    val mark=readInt()
    if (mark>=90) {
      println("Grade A")
    } else if(mark>=80){
      println("Grade B")
    }else if(mark>=70){
      println("Grade C")
    }else if(mark>=60){
      println("Grade D")
    }else if(mark>=50){
      println("Grade E")
    }else{
      println("Grade F")
    }

    val result3= if (mark>=90) "Grade A" 
    else if (mark>=80) "Grade B" 
    else if (mark>=70) "Grade C" 
    else if (mark>=60) "Grade D" 
    else if (mark>=60) "Grade E"
    else "Grade F"
    
    print(result3)
  }
}
