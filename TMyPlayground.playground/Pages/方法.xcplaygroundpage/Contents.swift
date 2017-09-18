//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)


/*方法（Methods）
 
 方法是与某些特定类型相关联的函数。类、结构体、枚举都可以定义实例方法
 */


class Counter {
    
    var count = 0
    
    func increment() {
        count += 1
    }
    
    func increment(by amount: Int) {
        count += amount
    }
    
    func reset() {
        count = 0
    }
}


let counter = Counter()

counter.increment()
counter.increment(by: 10)
counter.count



/*在实例方法中修改值类型
 
 结构体和枚举是值类型。默认情况下，值类型的属性不能在它的实例方法中被修改。
 
 但是，如果你确实需要在某个特定的方法中修改结构体或者枚举的属性，你可以为这个方法选择可变(mutating)行为，然后就可以从其方法内部改变它的属性；并且这个方法做的任何改变都会在方法执行结束时写回到原始结构中。方法还可以给它隐含的self属性赋予一个全新的实例，这个新实例在方法结束时会替换现存实例。
 
 要使用可变方法，将关键字mutating 放到方法的func关键字之前就可以了：
 
 mutation:可变方法
 nonmutating:不可变方法
 */

struct Point {
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
    
    /*在可变方法中给 self 赋值
     
     可变方法能够赋给隐含属性self一个全新的实例
     */
    mutating func changeSelfMoveBy(x deltaX: Double, y deltaY: Double) {
        self = Point(x: x + deltaX, y: y + deltaY)
    }
}
var somePoint = Point(x: 1.0, y: 1.0)

somePoint.moveByX(deltaX:2.0, y: 3.0)
print("The point is now at (\(somePoint.x), \(somePoint.y))")

somePoint.changeSelfMoveBy(x: 10.0, y: 10.0)
print("The point is now at (\(somePoint.x), \(somePoint.y))")

//循环切换
enum TriStateSwitch {
    
    case Off, Low, High
    
    mutating func next() {
        switch self {
        case .Off:
            self = .Low
        case .Low:
            self = .High
        case .High:
            self = .Off
        }
    }
}
var ovenLight = TriStateSwitch.Low
ovenLight.next()

ovenLight.next()



/*类型方法
 在方法的func关键字之前加上关键字static，来指定类型方法。类还可以用关键字class来允许子类重写父类的方法实现。
 
 注意
 在 Objective-C 中，你只能为 Objective-C 的类类型（classes）定义类型方法（type-level methods）。在 Swift 中，你可以为所有的类、结构体和枚举定义类型方法。每一个类型方法都被它所支持的类型显式包含
 */

struct LevelTracker {
    
    static var highestUnlockedLevel = 1
    
    var currentLevel = 1
    
    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel { highestUnlockedLevel = level }
    }
    
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    
    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
    
}


class Player {
    
    var tracker = LevelTracker()
    
    let playerName: String
    
    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    
    init(name: String) {
        playerName = name
    }
}














