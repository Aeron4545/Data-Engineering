import scala.io.Source

object FileAnalysis{
  def main(args: Array[String]): Unit = {
    //Read from file
    val source=Source.fromFile("C:/Users/Administrator/Desktop/UST/Scala/Sample.txt")
    
    //Read all values and create List of Lines
    val lines=source.getLines().toList
    //Close the file object
    source.close()

    println(lines)
    //process the file
    //split lines into words, change words to its lowercase
    val words=lines.flatMap(_.split("\\s+")).map(_.toLowerCase)
    println(words)

    //print top 10 most frequent words
    //sort words in descending order using negated values (-_._2)
    val wordCount= words.groupBy(identity).mapValues(_.size).toSeq.sortBy(-_._2)

    wordCount.take(10).foreach{case (word,count) =>println(s"$word: $count")}

    //Find count of words
    println("Total count of words=:"+words.length)

    //Find the word with maximum length and minimum length
    val max= words.groupBy(identity).mapValues(_.size).toSeq.sortBy(_._2)
    val min = words.groupBy(identity).mapValues(_.size).toSeq.sortBy(-_._2)
    println("Maximum word and count::"+min.take(1))
    println("Minimum word and count::"+max.take(1))
    
    
    

  }
}
