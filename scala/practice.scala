object practice{
  def main(args: Array[String]): Unit ={
//    var a: Int=5
//    var b: Long=5324234
//    var c: String="hello"
//    var d: Byte=5
//    println(a)
//    println(b)
//    println(c)
//    println(d)
//
//    var arr= Array[Int]()
//    arr=Array(1,2,3,4,5)
//    print(arr.mkString(","))
////
////    import scala.collection.mutable.ArrayBuffer
////    var ab=ArrayBuffer(1,2,3,4,5,6)
////    ab+=11
////    print(ab.mkString(","))
////
////    var x=ArrayBuffer("Aeron","John","Thomas")
////    println(x.mkString(","))
////
////    var y=Array(Array(1,2,3),Array(1,2,3),Array(1,2,3))
////    println(y.flatten.mkString(","))
////    println(y.length)
////    println(y(0).mkString("0"))
////    println(x.takeInPlace(2))
////    println(x.map(_+"hi"))
////    println(x.filter(_.startsWith("A")))
////    println(x.reduce(_+_))
////    println(x.slice(1,2))
//
//    var l:List[String]=List("Aeron","John","Thomas","Sam","Len","Fein")
//
//    l.foreach(println)
//
//    println(l(0))
//    println(l.length)
//    println(l.isEmpty)
//    println(l.sortWith(_.length<_.length))
//    println(l.lift(2))
//
//    import scala.collection.mutable.Map
//
//    var m=Map("Aeron"->1,"John"->2,"Thomas"->3)
//    println(m)
//    println(m.values)
//    println(m.keys)
//
//    println(m.contains("Aeron"))
//
//    var s=Set(1,2,3,4,5)
//    var s1=Set(4,5,6,7,8)
//    println(s.union(s1))
//    println(s.intersect(s1))
//    println(s.diff(s1))
//    s1++=Set(90,80)
//    println(s1)
//    import scala.io.StdIn.*
//    println("Enter a number")
//    val day=readInt()
//    println(sw(day))
//    def sw(day:Int) : String=day match{
//      case 1=>"Monday"
//      case 2=>"Tuesday"
//      case 3=>"Wednesday"
//      case 4=>"Friday"
//      case 5=>"Saturday"
//      case _=>"Invalid choice"
//    }
//
//    println("Enter + - * or /")
//    var c=readLine()
//    println("Enter first number")
//    var a=readInt()
//    println("Enter second number")
//    var b=readInt()
//    println(swi(c,a,b))
//    def swi(c:String,a:Int,b:Int): Int=c match{
//      case "+"=>a+b
//      case "-"=>a-b
//      case "*"=>a*b
//      case "/"=> if b!=0 then a/b else 0
//      case _=>0
//    }
//   import scala.io.StdIn.*
//   var s=readInt()
//    if (s>50){
//      println("Welldone")
//    }
//    else{
//      println("Bad")
//    }
//
//
//    var r=if (s>90) "A"
//    else if (s>80) "B"
//    else if (s>70) "C"
//    else if (s>60) "D"
//    else if (s>50) "E"
//    else "F"
//    println(r)
//

  for(i<-1 to 10 if i%2==0){
    println(i)
  }
    
    var s:List[String]=List("Aeron","John","Thomas")
    for(i<-s){
      println(i)
    }


  }
}
