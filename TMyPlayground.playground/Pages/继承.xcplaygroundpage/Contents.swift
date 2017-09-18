//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

/*重写
 
 子类可以为继承来的实例方法，类方法，实例属性，或下标提供自己定制的实现。我们把这种行为叫重写。
 
 如果要重写某个特性，你需要在重写定义的前面加上override关键字。这么做，你就表明了你是想提供一个重写版本，而非错误地提供了一个相同的定义。意外的重写行为可能会导致不可预知的错误，任何缺少override关键字的重写都会在编译时被诊断为错误。
 
 override关键字会提醒 Swift 编译器去检查该类的超类（或其中一个父类）是否有匹配重写版本的声明。这个检查可以确保你的重写定义是正确
 */

class SuperClass {
    
    var currentSpeed = 0.0
    
    
    var description: String {
        return "SuperClass"
    }
    
    func makeNoise() {
        print("SuperClass")
    }
    

}


class SubClass: SuperClass {
    
    var gear = 1
    
    override var description: String {
        return super.description + " in gear \(gear)"
    }
    
    override func makeNoise() {
        print("SubClass")
    }
    
    
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}


let subClass = SubClass()

subClass.makeNoise()

subClass.description

subClass.currentSpeed = 10.0

subClass.gear


/*
 防止重写
 
 你可以通过把方法，属性或下标标记为final来防止它们被重写，
 只需要在声明关键字前加上final修饰符即可
 （例如：final var，final func，final class func，以及final subscript）
 */

class SuperClass1 {
    
    func test1() -> Void {
        
    }
    
    final func test2() -> Void {
        
    }
    
    final subscript(value:Int) -> String {
        return "test"
    }
    
}

final class SuperClass2 {
    
}


class SubClass1: SuperClass1 {
    
    
    override func test1() {
        
    }
    
//    override func test2() {
//        
//    }
    
//    override subscript(value:Int) -> String {
//        return "test1"
//    }
    
}












