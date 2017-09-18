//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)


/*表示并抛出错误
 
 */



enum VendingMachineError: Error {
    
    case invalidSelection                     //选择无效
    
    case insufficientFunds(coinsNeeded: Int) //金额不足
    
    case outOfStock                             //缺货
    
}


throw VendingMachineError.insufficientFunds(coinsNeeded: 5)




/*处理错误
 Swift 中有4种处理错误的方式。你可以
 1.把函数抛出的错误传递给调用此函数的代码、
 2.用do-catch语句处理错误、
 3.将错误作为可选类型处理、
 4.或者断言此错误根本不会发生
 
 注意
 Swift 中的错误处理和其他语言中用try，catch和throw进行异常处理很像。和其他语言中（包括 Objective-C ）的异常处理不同的是，Swift 中的错误处理并不涉及解除调用栈，这是一个计算代价高昂的过程。就此而言，throw语句的性能特性是可以和return语句相媲美的。
 */


/*用 throwing 函数传递错误

为了表示一个函数、方法或构造器可以抛出错误，在函数声明的参数列表之后加上throws关键字。一个标有throws关键字的函数被称作throwing 函数。如果这个函数指明了返回值类型，throws关键词需要写在箭头（->）的前面。
 
 一个 throwing 函数可以在其内部抛出错误，并将错误传递到函数被调用时的作用域。
 
 注意
 只有 throwing 函数可以传递错误。任何在某个非 throwing 函数内部抛出的错误只能在函数内部处理。
 */

func canThrowErrors() throws -> String {
    return ""
}

func cannotThrowErrors() -> String {
    return ""
}



//

struct Item {
    
    var price: Int
    var count: Int
}

class VendingMachine {
    
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    
    var coinsDeposited = 0
    
    func dispenseSnack(snack: String) {
        print("Dispensing \(snack)")
    }
    
    func vend(itemNamed name: String) throws {
        
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        
        newItem.count -= 1
        
        inventory[name] = newItem
        
        print("Dispensing \(name)")
    }
}



/*用 Do-Catch 处理错误

可以使用一个do-catch语句运行一段闭包代码来处理错误。如果在do子句中的代码抛出了一个错误，这个错误会与catch子句做匹配，从而决定哪条子句能处理它。

下面是do-catch语句的一般形式：
 
 do {
    try expression
 
    statements
 
 } catch pattern 1 {
 
    statements
 
 } catch pattern 2 where condition {
 
    statements
 }
 */

let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]

func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    
    try vendingMachine.vend(itemNamed: snackName)
}

var vendingMachine = VendingMachine()

vendingMachine.coinsDeposited = 8

do {
    
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
    
} catch VendingMachineError.invalidSelection {
    
    print("Invalid Selection.")
    
} catch VendingMachineError.outOfStock {
    
    print("Out of Stock.")
    
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
    
}



/*将错误转换成可选值

可以使用try?通过将错误转换成一个可选值来处理错误。如果在评估try?表达式时一个错误被抛出，那么表达式的值就是nil。例如,在下面的代码中,x和y有着相同的数值和等价的含义：
 */

func someThrowingFunction() throws -> Int {
    // ...
    return 2
}

let x = try? someThrowingFunction()

let y: Int?

do {
    
    y = try someThrowingFunction()
    
} catch {
    
    y = nil
}




/*禁用错误传递

有时你知道某个throwing函数实际上在运行时是不会抛出错误的，在这种情况下，你可以在表达式前面写try!来禁用错误传递，这会把调用包装在一个不会有错误抛出的运行时断言中。如果真的抛出了错误，你会得到一个运行时错误。

例如，下面的代码使用了loadImage(atPath:)函数，该函数从给定的路径加载图片资源，如果图片无法载入则抛出一个错误。在这种情况下，因为图片是和应用绑定的，运行时不会有错误抛出，所以适合禁用错误传递：
*/

func loadImage(atPath: String) {
    
}

let photo = try! loadImage(atPath: "./Resources/John Appleseed.jpg")




/*指定清理操作

可以使用defer语句在即将离开当前代码块时执行一系列语句。该语句让你能执行一些必要的清理工作，不管是以何种方式离开当前代码块的——无论是由于抛出错误而离开，还是由于诸如return或者break的语句。例如，你可以用defer语句来确保文件描述符得以关闭，以及手动分配的内存得以释放。

defer语句将代码的执行延迟到当前的作用域退出之前。该语句由defer关键字和要被延迟执行的语句组成。延迟执行的语句不能包含任何控制转移语句，例如break或是return语句，或是抛出一个错误。延迟执行的操作会按照它们被指定时的顺序的相反顺序执行——也就是说，第一条defer语句中的代码会在第二条defer语句中的代码被执行之后才执行，以此类推。
 
 下面的代码使用一条defer语句来确保open(_:)函数有一个相应的对close(_:)函数的调用。
 
 注意
 即使没有涉及到错误处理，你也可以使用defer语句。
*/

class File {
    
    func readline() throws -> String {
        return ""
    }
    
}

func open(_ filename: String) -> File {
    return File()
}

func close(_ file: File) {
    
}

func exists(_ filename: String) -> Bool {
   
    return true
}

func processFile(filename: String) throws {
    print("start")//不打印是前面的前面代码中已经跑出错误了
    if exists(filename) {
        
        let file = open(filename)
        
        defer {
            print("defer")
            close(file)
            
        }
        
        while (try? file.readline()) != nil {
            // 处理文件。
        }
        
        
        // close(file) 会在这里被调用，即作用域的最后。
        print("end")//不打印是前面的前面代码中已经跑出错误了
    }
    
}

try processFile(filename: "test")



