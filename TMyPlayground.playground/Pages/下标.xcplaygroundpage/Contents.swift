//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)


/*下标语法
 举例来说，用下标访问一个Array实例中的元素可以写作someArray[index]，访问Dictionary实例中的元素可以写作someDictionary[key]
 
 下标允许你通过在实例名称后面的方括号中传入一个或者多个索引值来对实例进行存取。语法类似于实例方法语法和计算型属性语法的混合。与定义实例方法类似，定义下标使用subscript关键字，指定一个或多个输入参数和返回类型；与实例方法不同的是，下标可以设定为读写或只读。这种行为由 getter 和 setter 实现，有点类似计算型属性：
 
 subscript(index: Int) -> Int {
     get {
         // 返回一个适当的 Int 类型的值
     }
     
     set(newValue) {
         // 执行适当的赋值操作
     }
 }
 */




struct TimesTable {
    
    let multiplier: Int
    
    subscript(index: Int) -> Int {
        
        return multiplier * index
        
    }
    
}

let threeTimesTable = TimesTable(multiplier: 3)

print("six times three is \(threeTimesTable[6])")





/*下标选项
 
 下标可以接受任意数量的入参，并且这些入参可以是任意类型。下标的返回值也可以是任意类型。下标可以使用变量参数和可变参数，但不能使用输入输出参数，也不能给参数设置默认值。
 
 一个类或结构体可以根据自身需要提供多个下标实现，使用下标时将通过入参的数量和类型进行区分，自动匹配合适的下标，这就是下标的重载。
 
 虽然接受单一入参的下标是最常见的，但也可以根据情况定义接受多个入参的下标。例如下例定义了一个Matrix结构体，用于表示一个Double类型的二维矩阵。Matrix结构体的下标接受两个整型参数：
 */

struct Matrix {
    
    let rows: Int, columns: Int
    
    var grid: [Double]
    
    init(rows: Int, columns: Int) {
        
        self.rows = rows
        
        self.columns = columns
        
        //grid = Array(count: rows * columns, repeatedValue: 0.0)
        grid = Array(repeatElement(0.0, count: rows * columns))
        
    }
    
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript(row: Int, column: Int) -> Double {
        
        get {
            assert(indexIsValidForRow(row:row, column: column), "Index out of range")
            
            return grid[(row * columns) + column]
        }
        
        set {
            assert(indexIsValidForRow(row:row, column: column), "Index out of range")
            
            grid[(row * columns) + column] = newValue
        }
    }
}























