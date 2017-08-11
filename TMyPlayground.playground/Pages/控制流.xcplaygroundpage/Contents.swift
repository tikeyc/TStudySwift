//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)


/**
 Swift 的switch语句比 C 语言中更加强大。在 C 语言中，如果某个 case 不小心漏写了break，这个 case 就会贯穿至下一个 case，Swift 无需写break，所以不会发生这种贯穿的情况。case 还可以匹配很多不同的模式，包括间隔匹配（interval match），元组（tuple）和转换到特定类型。switch语句的 case 中匹配的值可以绑定成临时常量或变量，在case体内使用，也可以用where来描述更复杂的匹配条件
 */



for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}
//如果你不需要区间序列内每一项的值，你可以使用下划线（_）替代变量名来忽略这个值：
let base = 3
let power = 10
var answer = 1
for _ in 1...power {
    answer *= base
}
print("\(base) to the power of \(power) is \(answer)")


let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs {
    print("\(animalName)s have \(legCount) legs")
}


/*Repeat-While
 while循环的另外一种形式是repeat-while，它和while的区别是在判断循环条件之前，
 先执行一次循环的代码块。然后重复循环直到条件为false
 Swift语言的repeat-while循环和其他语言中的do-while循环是类似的。
 */
let a = 1
var b = 4
repeat {
    b -= 1;
    print("repeat")
} while (a < b)



/*Switch
 不需要在 case 分支中显式地使用break语句
 虽然在Swift中break不是必须的，但你依然可以在 case 分支中的代码执行完毕前使用break跳出
 
 每一个 case 分支都必须包含至少一条语句
 */
let someCharacter: Character = "e"
switch someCharacter {
case "a":
    print("The first letter of the alphabet")

case "z":
    print("The last letter of the alphabet")//尝试注释此行代码

case "c":
    break//尝试去掉break
case "b", "e":
    print("b and e")

default:
    print("Some other character")
}

//区间匹配
let approximateCount = 62
let countedThings = "moons orbiting Saturn"
var naturalCount: String
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}
print("There are \(naturalCount) \(countedThings).")


//元组
//我们可以使用元组在同一个switch语句中测试多个值。元组中的元素可以是值，也可以是区间。另外，使用下划线（_）来匹配所有可能的值。
//下面的例子展示了如何使用一个(Int, Int)类型的元组来分类下图中的点(x, y)：

let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("(0, 0) is at the origin")
case (_, 0):
    print("(\(somePoint.0), 0) is on the x-axis")
case (0, _):
    print("(0, \(somePoint.1)) is on the y-axis")
case (-2...2, -2...2):
    print("(\(somePoint.0), \(somePoint.1)) is inside the box")
default:
    print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
}

//值绑定
//case 分支允许将匹配的值绑定到一个临时的常量或变量，并且在case分支体内使用 —— 这种行为被称为值绑定（value binding），因为匹配的值在case分支体内，与临时的常量或变量绑定
var anotherPoint = (2, 0)
//anotherPoint = (2, 2)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}


//case 分支的模式可以使用where语句来判断额外的条件。
//下面的例子把下图中的点(x, y)进行了分类：
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}


//控制转移语句continue break fallthrough return throw

//fallthrough 贯穿
let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough//满足条件后贯穿下一个case
case 5:
    description += " 贯穿fallthrough"
default:
    description += " an integer."
}
print(description)


/*
 像if语句一样，guard的执行取决于一个表达式的布尔值。
 我们可以使用guard语句来要求条件必须为真时，以执行guard语句后的代码。
 不同于if语句，一个guard语句总是有一个else从句，如果条件不为真则执行else从句中的代码。
 */

func greet(person: [String: String]) {
    guard let name = person["name"] else {
        return
    }
    print("Hello \(name)")
    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }
    print("I hope the weather is nice in \(location).")
}

greet(person: ["name":"tikeyc","location":"guangzhou"])



/*检测 API 可用性 Swift内置支持检查 API 可用性
 我们在if或guard语句中使用可用性条件（availability condition)去有条件的执行一段代码，
 来在运行时判断调用的API是否可用
 */

if #available(iOS 10, *) {
    
    print("在 iOS 使用 iOS 10 的 API")
} else {
    print("使用先前版本的 iOS 和 macOS 的 API")
    
}

if #available(iOS 10, macOS 10.12, *) {
    print("在 iOS 使用 iOS 10 的 API, 在 macOS 使用 macOS 10.12 的 API")
    
} else {
    print("使用先前版本的 iOS 和 macOS 的 API")
    
}











