import scala.io.Source
object file{
  def main(args: Array[String]): Unit = {
    var f=Source.fromFile("C:/Users/Administrator/Desktop/UST/Scala/Sample.txt")
    val l=f.getLines().toList
    for(i<-l){
      println(i)
    }
  }
}
