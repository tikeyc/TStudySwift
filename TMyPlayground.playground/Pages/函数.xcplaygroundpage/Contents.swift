//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)



/**
 ->（一个连字符后跟一个右尖括号）后跟返回类型的名称的方式来表示
 */

func greet(person: String, isPrint: Bool) -> String {
    
    let greeting = "hello" + person + "!"
    
    return greeting
}


//被调用时，一个函数的返回值可以被忽略
func testGreet() {
    let _ = greet(person: "tikeyc", isPrint: true)
}
testGreet()

//你可以用元组（tuple）类型让多个值作为一个复合值从函数中返回
//?表示返回类型可选optional
func getMinMax(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty { return nil }
    var min = array[0]
    var max = array[0]
    
    for value in array[1..<array.count] {
        if value < min {
            min = value
        } else if value > max {
            max = value
        }
    }
    
    return (min, max)
}

let minMaxValue = getMinMax(array: [11,21,3,43,5,64,27,38])
minMaxValue?.min
minMaxValue?.max


/*函数 参数标签 和 参数名称
 每个函数参数都有一个参数标签( argument label )以及一个参数名称( parameter name )。
 参数标签在调用函数的时候使用；调用的时候需要将函数的参数标签写在对应的参数前面。
 参数名称在函数的实现中使用。默认情况下，函数参数使用参数名称来作为它们的参数标签
 */

func greet(person: String, from hometown: String) -> String {
    return "Hello \(person)!  Glad you could visit from \(hometown)."
}

print(greet(person: "tikeyc", from: "China"))

//如果你不希望为某个参数添加一个标签，可以使用一个下划线(_)来代替一个明确的参数标签。
func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
    // 在函数体内，firstParameterName 和 secondParameterName 代表参数中的第一个和第二个参数值
}
someFunction(1, secondParameterName: 2)


//你可以在函数体中通过给参数赋值来为任意一个参数定义默认值（Deafult Value）
func someFunction(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
    // 如果你在调用时候不传第二个参数，parameterWithDefault 会值为 12 传入到函数体中。
}
someFunction(parameterWithoutDefault: 3, parameterWithDefault: 6) // parameterWithDefault = 6
someFunction(parameterWithoutDefault: 4) // parameterWithDefault = 12



/**可变参数
 
 一个可变参数（variadic parameter）可以接受零个或多个值。
 函数调用时，你可以用可变参数来指定函数参数可以被传入不确定数量的输入值。
 通过在变量类型名后面加入（...）的方式来定义可变参数。
 
 可变参数的传入值在函数体中变为此类型的一个数组。例如，一个叫做 numbers 的 Double... 型可变参数，
 在函数体内可以当做一个叫 numbers 的 [Double] 型的数组常量。
 
 注意：
 一个函数最多只能拥有一个可变参数
 */

func arithmeticMean(_ numbers: Double..., isMean: Bool) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
arithmeticMean(1, 2, 3, 4, 5, isMean:true)
// 返回 3.0, 是这 5 个数的平均数。
arithmeticMean(3, 8.25, 18.75, isMean:true)

arithmeticMean(1,2, isMean: false)


/*
 输入输出参数
 
 函数参数默认是常量。试图在函数体中更改参数值将会导致编译错误(compile-time error)。
 这意味着你不能错误地更改参数值。如果你想要一个函数可以修改参数的值，
 并且想要在这些修改在函数调用结束后仍然存在，那么就应该把这个参数定义为输入输出参数（In-Out Parameters）
 
 定义一个输入输出参数时，在参数定义前加 inout 关键字。一个输入输出参数有传入函数的值，这个值被函数修改，然后被传出函数，替换原来的值。想获取更多的关于输入输出参数的细节和相关的编译器优化，请查看输入输出参数一节。
 
 你只能传递变量给输入输出参数。你不能传入常量或者字面量，因为这些量是不能被修改的。当传入的参数作为输入输出参数时，需要在参数名前加 & 符，表示这个值可以被函数修改
 
 注意 输入输出参数不能有默认值，而且可变参数不能用 inout 标记
 */


func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")

//使用函数类型
//在 Swift 中，使用函数类型就像使用其他类型一样。例如，你可以定义一个类型为函数的常量或变量，并将适当的函数赋值给它：
func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}

var mathFunction: (Int, Int) -> Int = addTwoInts

mathFunction(1,2)

//函数类型作为参数类型
func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}

printMathResult(mathFunction, 1, 2)

//它的返回类型是 (Int) -> Int 类型的函数
func chooseStepFunction(backward: Bool) -> (Int,Int) -> Int {
    
    //嵌套函数
    func addTwoInts1(_ a: Int, _ b: Int) -> Int {
        return a + b
    }
    
    let defaultMetho = addTwoInts1
    
    return backward ? defaultMetho : mathFunction
}




















