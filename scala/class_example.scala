case class school(val name:String, val s_n:Int)

object matchcas extends App{
  val s1=school("SAM",12)
  val s2=school("saintgits",50)
  
  s1 match{
    case school=>println(s1.name)
  }
}
