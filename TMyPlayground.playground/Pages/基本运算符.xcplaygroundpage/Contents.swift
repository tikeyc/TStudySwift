//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)


/*1
 其他常规运算符就不在多说
 */

/*2
 元组的比较
 */
(1, "zebra") < (2, "apple")   // true，因为 1 小于 2
(3, "apple") < (3, "bird")    // true，因为 3 等于 3，但是 apple 小于 bird
(4, "dog") == (4, "dog")      // true，因为 4 等于 4，dog 等于 dog



/*3
 空合运算符（Nil Coalescing Operator）
 空合运算符（a ?? b）将对可选类型 a 进行空判断，如果 a 包含一个值就进行解封，否则就返回一个默认值 b。表达式 a 必须是 Optional 类型。默认值 b 的类型必须要和 a 存储值的类型保持一致
 空合运算符是对以下代码的简短表达方法：
 
 a != nil ? a! : b
 使用三目运算符去理解
 */

let defaultColorName = "red"
var userDefinedColorName: String?   //默认值为 nil

var colorNameToUse = userDefinedColorName ?? defaultColorName


/*4
 区间运算符
 闭区间运算符（a...b）定义一个包含从 a 到 b（包括 a 和 b）的所有值的区间。a 的值不能超过 b
 半开区间运算符（a..<b）定义一个从 a 到 b 但不包括 b 的区间
 */
for index in 1...5 {
    print("\(index) * 5 = \(index * 5)")
}

let names = ["Anna", "Alex", "Brian", "Jack"]
let count = names.count
for i in 0..<count {
    print("第 \(i + 1) 个人叫 \(names[i])")
}

for name in names {
    print(name)
}
















