//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)


/*可选链式调用
 可选链式调用是一种可以在当前值可能为nil的可选值上请求和调用属性、方法及下标的方法。
 如果可选值有值，那么调用就会成功；如果可选值是nil，那么调用将返回nil。
 多个调用可以连接在一起形成一个调用链，如果其中任何一个节点为nil，整个调用链都会失败，即返回nil。
 
 注意
 Swift 的可选链式调用和 Objective-C 中向nil发送消息有些相像，
 但是 Swift 的可选链式调用可以应用于任意类型，并且能检查调用是否成功
 */


class Person {
    var residence: Residence?
}

class Residence {
    
    var rooms = [Room]()
    
    var numberOfRooms: Int {
        
        return rooms.count
    }
    
    subscript(i: Int) -> Room {
        
        get {
            return rooms[i]
        }
        
        set {
            rooms[i] = newValue
        }
        
    }
    
    func printNumberOfRooms() {
        
        print("The number of rooms is \(numberOfRooms)")
    }
    
    var address: Address?
}


class Room {
    
    let name: String
    
    init(name: String) {
        self.name = name
    }
}



class Address {
    
    var buildingName: String?
    
    var buildingNumber: String?
    
    var street: String?
    
    func buildingIdentifier() -> String? {
        
        if buildingName != nil {
            
            return buildingName
        } else if buildingNumber != nil && street != nil {
            
            return "\(buildingNumber) \(street)"
        } else {
            
            return nil
        }
    }
    
}


func createAddress() -> Address {
    
    print("Function was called.")
    
    let someAddress = Address()
    
    someAddress.buildingNumber = "29"
    
    someAddress.street = "Acacia Road"
    
    return someAddress
}


let john = Person()

//如果使用叹号（!）强制展开获得这个john的residence属性中的numberOfRooms值，会触发运行时错误，因为这时residence没有可以展开的值：
//let roomCount = john.residence!.numberOfRooms
let roomCount = john.residence?.numberOfRooms

john.residence = Residence()
let roomCount1 = john.residence!.numberOfRooms



john.residence?.address = createAddress()















