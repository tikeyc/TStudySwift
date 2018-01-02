//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)


/*访问控制语法
 
 通过修饰符 open，public，internal，filepart，private 来声明实体的访问级别：
 */

public class SomePublicClass {}
internal class SomeInternalClass {}
fileprivate class SomeFilePrivateClass {}
private class SomePrivateClass {}

public var somePublicVariable = 0
internal let someInternalConstant = 0
fileprivate func someFilePrivateFunction() {}
private func somePrivateFunction() {}




public class SomePublicClass {                  // 显式公开类
    public var somePublicProperty = 0            // 显式公开类成员
    var someInternalProperty = 0                 // 隐式内部类成员
    fileprivate func someFilePrivateMethod() {}  // 显式文件私有类成员
    private func somePrivateMethod() {}          // 显式私有类成员
}

class SomeInternalClass {                       // 隐式内部类
    var someInternalProperty = 0                 // 隐式内部类成员
    fileprivate func someFilePrivateMethod() {}  // 显式文件私有类成员
    private func somePrivateMethod() {}          // 显式私有类成员
}

fileprivate class SomeFilePrivateClass {        // 显式文件私有类
    func someFilePrivateMethod() {}              // 隐式文件私有类成员
    private func somePrivateMethod() {}          // 显式私有类成员
}

private class SomePrivateClass {                // 显式私有类
    func somePrivateMethod() {}                  // 隐式私有类成员
}
