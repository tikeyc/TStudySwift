//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)



class SomeClass {
    var property1: String {
        get {
            return "get_property1"
//            return self.property1
        }
        set(newValue) {
//            print(newValue)
            self.property1 = newValue
        }
    }
}


var someClass = SomeClass()

//someClass.property1 = "test1"//set_property1

print(someClass.property1)


/////////////////
struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0),
                  size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")


/*只读计算属性
 
 只有 getter 没有 setter 的计算属性就是只读计算属性
 */
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}



/*属性观察器
 
 属性观察器监控和响应属性值的变化，每次属性被设置值的时候都会调用属性观察器，即使新值和当前值相同的时候也不例外。
 
 可以为除了延迟存储属性之外的其他存储属性添加属性观察器，也可以通过重写属性的方式为继承的属性（包括存储属性和计算属性）添加属性观察器。你不必为非重写的计算属性添加属性观察器，因为可以通过它的 setter 直接监控和响应值的变化
 
 注意
 父类的属性在子类的构造器中被赋值时，它在父类中的 willSet 和 didSet 观察器会被调用，随后才会调用子类的观察器。在父类初始化方法调用之前，子类给属性赋值时，观察器不会被调用
 */

class SuperStepCounter {
    var superTotalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set superTotalSteps to \(newTotalSteps)")
        }
        didSet {
            if superTotalSteps > oldValue  {
                print("Added \(superTotalSteps - oldValue) steps")
            }
        }
    }

}

class StepCounter : SuperStepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
    
    
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200

stepCounter.totalSteps = 360

stepCounter.totalSteps = 896

stepCounter.superTotalSteps = 100


/*类型属性
 使用关键字 static 来定义类型属性。
 
 在为类定义计算型类型属性时，可以改用关键字 class 来支持子类对父类的实现进行重写
 */

struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeClass1 {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}























