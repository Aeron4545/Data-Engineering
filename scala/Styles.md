Styles: It refer to different ways of writing scala program
It is based on various programming paradigm supported by language

1. Functional Style
2. Object- Oriented Style
3. Pattern matching style
4. For-Comprehension


val num=List(1,2,3,4,5,6)
val result=for{
    n<-num
    squared=n*n
}yield squared
println(result)


5. If comprehension
6. Type Class
7. Traits & Mixing
8. Imperative Styles