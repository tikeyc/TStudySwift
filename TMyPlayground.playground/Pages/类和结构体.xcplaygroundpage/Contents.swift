//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

/*与其他编程语言所不同的是，Swift 并不要求你为自定义类和结构去创建独立的 接口 和 实现文件。
 你所要做的是在一个单一文件中定义一个类或者结构体，系统将会自动生成面向其它代码的外部接口
 
 按照通用的准则，当符合一条或多条以下条件时，请考虑构建结构体：
 
 该数据结构的主要目的是用来封装少量相关简单数据值。
 有理由预计该数据结构的实例在被赋值或传递时，封装的数据将会被拷贝而不是被引用。
 该数据结构中储存的值类型属性，也应该被拷贝，而不是被引用。
 该数据结构不需要去继承另一个既有类型的属性或者行为
 */

struct SomeStructure {
    // 在这里定义结构体
    var property1: String?
    var property2: Int?
}

var someStructure = SomeStructure()

someStructure.property1 = "property1"

class SomeClass {
    // 在这里定义类
    var property1: String?
    
    var someStructure = SomeStructure()
}

var someClass = SomeClass()

someClass.property1 = "property1"

print(someClass.property1)

/*所有结构体都有一个自动生成的成员逐一构造器，用于初始化新结构体实例中成员的属性。
 新实例中各个属性的初始值可以通过属性的名称传递到成员逐一构造器之中：
 */

var someStructure1 = SomeStructure(property1:"1", property2:2);

print(someStructure1.property2)


/*
 类型被赋予给一个变量、常量或者被传递给一个函数的时候，其值会被拷贝。
 
 在之前的章节中，我们已经大量使用了值类型。实际上，在 Swift 中，所有的基本类型：整数（Integer）、浮点数（floating-point）、布尔值（Boolean）、字符串（string)、数组（array）和字典（dictionary），都是值类型，并且在底层都是以结构体的形式所实现

 *
 在以下示例中，声明了一个名为hd的常量，其值为一个初始化为全高清视频分辨率（1920 像素宽，1080 像素高）的Resolution实例。
 
 然后示例中又声明了一个名为cinema的变量，并将hd赋值给它。因为Resolution是一个结构体，所以cinema的值其实是hd的一个拷贝副本，而不是hd本身。尽管hd和cinema有着相同的宽（width）和高（height），但是在幕后它们是两个完全不同的实例
 */
struct Resolution {
    var width = 0
    var height = 0
}
let hd = Resolution(width: 1920, height: 1080)
print(hd.width)
//在将hd赋予给cinema的时候，实际上是将hd中所存储的值进行拷贝，然后将拷贝的数据存储到新的cinema实例中(枚举也遵循相同的行为准则)
var cinema = hd
cinema.width = 2000
print(cinema.width)



/*
 类是引用类型
 
 与值类型不同，引用类型在被赋予到一个变量、常量或者被传递到一个函数时，其值不会被拷贝。因此，引用的是已存在的实例本身而不是其拷贝
 */

let someClass1 = someClass

print(someClass.property1)
someClass1.property1 = "property1_change"
print(someClass.property1)


/*恒等运算符
 因为类是引用类型，有可能有多个常量和变量在幕后同时引用同一个类实例。（对于结构体和枚举来说，这并不成立。因为它们作为值类型，在被赋予到常量、变量或者传递到函数时，其值总是会被拷贝。）
 请注意，“等价于”（用三个等号表示，===）与“等于”（用两个等号表示，==）的不同：
 
 “等价于”表示两个类类型（class type）的常量或者变量引用同一个类实例。
 “等于”表示两个实例的值“相等”或“相同”，判定时要遵照设计者定义的评判标准，因此相对于“相等”来说，这是一种更加合适的叫法
 */

if someClass1 === someClass {
    print("someClass1 === someClass")
}

if someClass1.property1 == someClass.property1 {
    print("someClass1.property1 == someClass.property1")
}



/*
 字符串、数组、和字典类型的赋值与复制行为
 
 Swift 中，许多基本类型，诸如String，Array和Dictionary类型均以结构体的形式实现。这意味着被赋值给新的常量或变量，或者被传入函数或方法中时，它们的值会被拷贝。
 
 Objective-C 中NSString，NSArray和NSDictionary类型均以类的形式实现，而并非结构体。它们在被赋值或者被传入函数或方法时，不会发生值拷贝，而是传递现有实例的引用
 */






