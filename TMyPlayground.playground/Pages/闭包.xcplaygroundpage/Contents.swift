//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)


/*
 闭包是自包含的函数代码块，可以在代码中被传递和使用。
 Swift 中的闭包与 C 和 Objective-C 中的代码块（blocks）以及其他一些编程语言中的匿名函数比较相似。
 
 闭包可以捕获和存储其所在上下文中任意常量和变量的引用。被称为包裹常量和变量。
 Swift 会为你管理在捕获过程中涉及到的所有内存操作
 
 */

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

print("排序前names： \(names)")

func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
var reversedNames = names.sorted(by: backward)
print("排序后reversedNames： \(reversedNames)")

print("排序后names： \(names)")


/*闭包表达式语法
 
 闭包表达式语法有如下的一般形式：
 
 { (parameters) -> returnType in
 statements
 }
 */

reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})


/*根据上下文推断类型
 
 因为排序闭包函数是作为 sorted(by:) 方法的参数传入的，Swift 可以推断其参数和返回值的类型。sorted(by:) 方法被一个字符串数组调用，因此其参数必须是 (String, String) -> Bool 类型的函数。这意味着 (String, String) 和 Bool 类型并不需要作为闭包表达式定义的一部分。因为所有的类型都可以被正确推断，返回箭头（->）和围绕在参数周围的括号也可以被省略：
 */

reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )
print("推断类型排序后reversedNames： \(reversedNames)")

//单表达式闭包隐式返回
//单行表达式闭包可以通过省略 return 关键字来隐式返回单行表达式的结果，如上版本的例子可以改写为：

reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )

reversedNames = names.sorted(by: { $0 > $1 } )

reversedNames = names.sorted(by: >)

reversedNames = names.sorted(by: <)

print("<排序后reversedNames： \(reversedNames)")



//尾随闭包
//
//如果你需要将一个很长的闭包表达式作为最后一个参数传递给函数，可以使用尾随闭包来增强函数的可读性。尾随闭包是一个书写在函数括号之后的闭包表达式，函数支持将其作为最后一个参数调用。在使用尾随闭包时，你不用写出它的参数标签：

func someFunctionThatTakesAClosure(closure: () -> Void) {
    // 函数体部分
    closure()
}

// 以下是不使用尾随闭包进行函数调用
someFunctionThatTakesAClosure(closure: {
    // 闭包主体部分
    print("不使用尾随闭包进行函数调用")
})

// 以下是使用尾随闭包进行函数调用
someFunctionThatTakesAClosure() {
    // 闭包主体部分
    print("使用尾随闭包进行函数调用")
}


//在闭包表达式语法一节中作为 sorted(by:) 方法参数的字符串排序闭包可以改写为：
reversedNames = names.sorted() { $0 > $1 }

//如果闭包表达式是函数或方法的唯一参数，则当你使用尾随闭包时，你甚至可以把 () 省略掉：
reversedNames = names.sorted { $0 > $1 }



let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]


let strings = numbers.map { (number) -> String in
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    return output
}

/*逃逸闭包

当一个闭包作为参数传到一个函数中，但是这个闭包在函数返回之后才被执行，我们称该闭包从函数中逃逸。当你定义接受闭包作为参数的函数时，你可以在参数名之前标注 @escaping，用来指明这个闭包是允许“逃逸”出这个函数的。

一种能使闭包“逃逸”出函数的方法是，将这个闭包保存在一个函数外部定义的变量中。举个例子，很多启动异步操作的函数接受一个闭包参数作为 completion handler。这类函数会在异步操作开始之后立刻返回，但是闭包直到异步操作结束后才会被调用。在这种情况下，闭包需要“逃逸”出函数，因为闭包需要在函数返回之后被调用。例如：
*/

var completionHandlers: [() -> Void] = []
//someFunctionWithEscapingClosure(_:) 函数接受一个闭包作为参数，该闭包被添加到一个函数外定义的数组中。如果你不将这个参数标记为 @escaping，就会得到一个编译错误
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}


/*自动闭包
 自动闭包让你能够延迟求值，因为直到你调用这个闭包，代码段才会被执行。
 延迟求值对于那些有副作用（Side Effect）和高计算成本的代码来说是很有益处的，
 因为它使得你能控制代码的执行时机。
 下面的代码展示了闭包如何延时求值。
 */
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
// 打印出 "5"

let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)
// 打印出 "5"

print("Now serving \(customerProvider())!")
// Prints "Now serving Chris!"
print(customersInLine.count)
// 打印出 "4"


















