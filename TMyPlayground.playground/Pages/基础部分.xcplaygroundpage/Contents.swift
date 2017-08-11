//: Playground - noun: a place where people can play

import UIKit

//http://www.runoob.com/manual/gitbook/swift3/source/_book/chapter2/01_The_Basics.html#integer_and_floating_point_conversion
/*1
 定义
 */
var str = "Hello, playground"

print(str)

var test: String

test = "tikeyc"

print("creat by \(test)")

var red, green, blue: Double

/*2
 你可以用任何你喜欢的字符作为常量和变量名，包括 Unicode 字符：
 
 常量与变量名不能包含数学符号，箭头，保留的（或者非法的）Unicode 码位，连线与制表符。也不能以数字开头，
 但是可在常量与变量名的其他地方包含数字
 */
let π = 3.14159
let 你好 = "你好世界"
let 🐶🐮🐶 = "dogcow"

//你好 = "d" 报编译错误，常量无法修改其值

print(π,test, separator: ", ", terminator: " !")

/*3
 与 C 语言多行注释不同，Swift 的多行注释可以嵌套在其它的多行注释之中
     /* 这是第二个多行注释的开头
           /* 这是第三个被嵌套的多行注释 */
       这是第二个多行注释的结尾
     */
 */

let cat = "🐱"; print("\n" + cat)//有一种情况下必须要用分号，即你打算在同一行内写多条独立的语句


let tree = 3

let point = 0.1415926

var pi = Double(tree) + point


/*4
 类型别名
 */
typealias AudioSample = UInt16

typealias TimeValue = TimeInterval


let min = AudioSample.min

pi = TimeValue(tree) + point


/*5
 Swift 有两个布尔常量，true 和 false
 */

if true {//不像OC可以用1,0来判断
    let isOpen = false
}

/*6
 元组（tuples）把多个值组合成一个复合值。元组内的值可以是任意类型，并不要求是相同类型
 作为函数返回值时，元组非常有用
 */

let http404Error = (404,"Not Found")

let (statusCode, statusMessage) = http404Error

let (justTheStatusCode, _) = http404Error

print("The status code is \(statusCode)")
print("The status code is \(http404Error.0)")

let array = NSMutableArray.init()
array.add("3")
array.add("4")

let testTuples = (1, "2", true, array)


//你可以在定义元组的时候给单个元素命名：
let http200Status = (statusCode: 200, description: "OK")

//给元组中的元素命名后，你可以通过名字来获取这些元素的值：
print("The status code is \(http200Status.statusCode)")


/*7
 使用可选类型（optionals）来处理值可能缺失的情况
 注意：
 C 和 Objective-C 中并没有可选类型这个概念。最接近的是 Objective-C 中的一个特性，一个方法要不返回一个对象要不返回nil，nil表示“缺少一个合法的对象”。然而，这只对对象起作用——对于结构体，基本的 C 类型或者枚举类型不起作用。对于这些类型，Objective-C 方法一般会返回一个特殊值（比如NSNotFound）来暗示值缺失。这种方法假设方法的调用者知道并记得对特殊值进行判断。然而，Swift 的可选类型可以让你暗示任意类型的值缺失，并不需要一个特殊值
 
 当你确定可选类型确实包含值之后，你可以在可选的名字后面加一个感叹号（!）来获取值。这个惊叹号表示“我知道这个可选有值，请使用它。”这被称为可选值的强制解析（forced unwrapping）：
 */


var optionalsCode: Int? = 404
optionalsCode = nil;//尝试去掉上面的 ？ 将报编译错误

optionalsCode = 400//尝试注释改行代码，下面代码将报编译错误
print(optionalsCode!)//这个惊叹号表示:我知道这个可选有值，请使用它

if optionalsCode != nil {
    
}

optionalsCode = nil
if let judgeCode = optionalsCode {
    print(optionalsCode!)
}

if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100 {
    print("\(firstNumber) < \(secondNumber) < 100")
}

/*8
 隐式解析可选类型
 注意：
 如果一个变量之后可能变成nil的话请不要使用隐式解析可选类型。如果你需要在变量的生命周期中判断是否是nil的话，请使用普通可选类型
 */
let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // 需要感叹号来获取值
//隐式解析可选类型
let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString  // 不需要感叹号

/*
do {
    try canThrowAnError()
} catch {
    
}

func canThrowAnError() throws {
    
}
 */

let age = 3;//尝试修改3为-3
assert(age > 0, "age error")














