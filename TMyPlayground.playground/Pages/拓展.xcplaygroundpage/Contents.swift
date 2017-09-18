//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)


/*拓展
 
 就是为一个已有的类、结构体、枚举类型或者协议类型添加新功能。
 这包括在没有权限获取原始源代码的情况下扩展类型的能力（即 逆向建模 ）。
 扩展和 Objective-C 中的分类类似。（与 Objective-C 不同的是，Swift 的扩展没有名字。）
 
 使用关键字 extension 来声明扩展：
 extension SomeType {
 
    // 为 SomeType 添加的新功能写到这里
 
 }
 
 */


extension Double {
    
    var km: Double { return self * 1_000.0 }
    
    var m : Double { return self }
    
    var cm: Double { return self / 100.0 }
    
    var mm: Double { return self / 1_000.0 }
    
    var ft: Double { return self / 3.28084 }
    
}


let oneInch = 25.4.km

print(oneInch)


let threeFeet = 3.ft

print(threeFeet)



/*构造器
 
 扩展可以为已有类型添加新的构造器。这可以让你扩展其它类型，将你自己的定制类型作为其构造器参数，或者提供该类型的原始实现中未提供的额外初始化选项。
 
 扩展能为类添加新的便利构造器，但是它们不能为类添加新的指定构造器或析构器。指定构造器和析构器必须总是由原始的类实现来提供。
 
 注意
 如果你使用扩展为一个值类型添加构造器，同时该值类型的原始实现中未定义任何定制的构造器且所有存储属性提供了默认值，那么我们就可以在扩展中的构造器里调用默认构造器和逐一成员构造器。
 正如在值类型的构造器代理中描述的，如果你把定制的构造器写在值类型的原始实现中，上述规则将不再适用
 */





struct Size {
    
    var width = 0.0, height = 0.0
    
    
}

struct Point {
    
    var x = 0.0, y = 0.0
    
}


struct Rect {
    
    var origin = Point()
    
    var size = Size()
    
}


//因为结构体 Rect 未提供定制的构造器，因此它会获得一个逐一成员构造器。又因为它为所有存储型属性提供了默认值，它又会获得一个默认构造器。详情请参阅默认构造器。这些构造器可以用于构造新的 Rect 实例：

let defaultRect = Rect()

let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
                          size: Size(width: 5.0, height: 5.0))



extension Rect {
    
    init(center: Point, size: Size) {
        
        let originX = center.x - (size.width / 2)
        
        let originY = center.y - (size.height / 2)
        
        self.init(origin: Point(x: originX, y: originY), size: size)
        
    }
    
}


let rect1 = Rect.init(center: Point.init(x: 1, y: 1), size: Size.init(width: 100, height: 100))



//方法

extension Int {
    
    func repetitions(task: () -> Void) {
        
        for _ in 0..<self {
            
            task()
            
        }
        
    }
    
}

3.repetitions {
    
    print("task")
    
}



/*可变实例方法
 
 通过扩展添加的实例方法也可以修改该实例本身。结构体和枚举类型中修改 self 或其属性的方法必须将该实例方法标注为 mutating，正如来自原始实现的可变方法一样。
 
 下面的例子为 Swift 的 Int 类型添加了一个名为 square 的可变方法，用于计算原始值的平方值：
 */

extension Int {
    
    mutating func square() {
        
        self = self * self
        
    }
    
}

var someInt = 3

someInt.square()




/*下标
 
 扩展可以为已有类型添加新下标。这个例子为 Swift 内建类型 Int 添加了一个整型下标。该下标 [n] 返回十进制数字从右向左数的第 n 个数字：
 
 123456789[0] 返回 9
 123456789[1] 返回 8
 ……以此类推。
 */

extension Int {
    
    subscript(digitIndex: Int) -> Int {
        
        var decimalBase = 1
        
        for _ in 0..<digitIndex {
            
            decimalBase *= 10
            
        }
        
        return (self / decimalBase) % 10
        
    }
    
}


746381295[0]

//如果该 Int 值没有足够的位数，即下标越界，那么上述下标实现会返回 0，犹如在数字左边自动补 0
746381295[9]



/*嵌套类型
 
 扩展可以为已有的类、结构体和枚举添加新的嵌套类型：
 */

extension Int {
    
    enum Kind {
        
        case Negative, Zero, Positive
        
    }
    
    var kind: Kind {
        
        switch self {
            
        case 0:
            
            return .Zero
            
        case let x where x > 0:
            
            return .Positive
            
        default:
            
            return .Negative
            
        }
        
    }
    
}


func printIntegerKinds(_ numbers: [Int]) {
    
    for number in numbers {
        
        switch number.kind {
            
        case .Negative:
            
            print("- ", terminator: "")
            
        case .Zero:
            
            print("0 ", terminator: "")
            
        case .Positive:
            
            print("+ ", terminator: "")
            
        }
        
    }
    
    print("")
    
}

printIntegerKinds([3, 19, -27, 0, -6, 0, 7])









