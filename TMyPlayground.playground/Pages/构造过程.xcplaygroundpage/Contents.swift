//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)


/*构造器
 
 构造器在创建某个特定类型的新实例时被调用。它的最简形式类似于一个不带任何参数的实例方法，以关键字init命名：
 
 init() {
    // 在此处执行构造过程
 }
 
 注意
 当你为存储型属性设置默认值或者在构造器中为其赋值时，它们的值是被直接设置的，不会触发任何属性观察者
 */





/*指定构造器和便利构造器的语法
 
 类的指定构造器的写法跟值类型简单构造器一样：
 
 init(parameters) {
     statements
 }
 
 
 便利构造器也采用相同样式的写法，但需要在init关键字之前放置convenience关键字，并使用空格将它们俩分开：
 
 convenience init(parameters) {
     statements
 }
 */



/*构造器的继承和重写
 
 跟 Objective-C 中的子类不同，Swift 中的子类默认情况下不会继承父类的构造器。Swift 的这种机制可以防止一个父类的简单构造器被一个更精细的子类继承，并被错误地用来创建子类的实例。
 
 注意
 父类的构造器仅会在安全和适当的情况下被继承。具体内容请参考后续章节构造器的自动继承。
 
 假如你希望自定义的子类中能提供一个或多个跟父类相同的构造器，你可以在子类中提供这些构造器的自定义实现
 
 
 正如重写属性，方法或者是下标，override修饰符会让编译器去检查父类中是否有相匹配的指定构造器，并验证构造器参数是否正确。
 
 注意
 当你重写一个父类的指定构造器时，你总是需要写override修饰符，即使你的子类将父类的指定构造器重写为了便利构造器
 */




class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}


/*
 下面例子中定义了一个Vehicle的子类Bicycle：
 
 子类Bicycle定义了一个自定义指定构造器init()。这个指定构造器和父类的指定构造器相匹配，所以Bicycle中的指定构造器需要带上override修饰符。
 */

class Bicycle: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
}

/*构造器的自动继承
 
 如上所述，子类在默认情况下不会继承父类的构造器。但是如果满足特定条件，父类构造器是可以被自动继承的。在实践中，这意味着对于许多常见场景你不必重写父类的构造器，并且可以在安全的情况下以最小的代价继承父类的构造器。
 
 假设你为子类中引入的所有新属性都提供了默认值，以下 2 个规则适用：
 
 规则 1
 
 如果子类没有定义任何指定构造器，它将自动继承所有父类的指定构造器。
 
 规则 2
 
 如果子类提供了所有父类指定构造器的实现——无论是通过规则 1 继承过来的，还是提供了自定义实现——它将自动继承所有父类的便利构造器。
 
 即使你在子类中添加了更多的便利构造器，这两条规则仍然适用。
 
 注意
 对于规则 2，子类可以将父类的指定构造器实现为便利构造器
 */



/*可失败构造器
 
 如果一个类、结构体或枚举类型的对象，在构造过程中有可能失败，则为其定义一个可失败构造器。这里所指的“失败”是指，如给构造器传入无效的参数值，或缺少某种所需的外部资源，又或是不满足某种必要的条件等。
 
 为了妥善处理这种构造过程中可能会失败的情况。你可以在一个类，结构体或是枚举类型的定义中，添加一个或多个可失败构造器。其语法为在init关键字后面添加问号(init?)。
 
 通常来说我们通过在init关键字后添加问号的方式（init?）来定义一个可失败构造器，但你也可以通过在init后面添加惊叹号的方式来定义一个可失败构造器（init!），该可失败构造器将会构建一个对应类型的隐式解包可选类型的对象
 注意
 可失败构造器的参数名和参数类型，不能与其它非可失败构造器的参数名，及其参数类型相同。
 */

struct Animal {
    
    let species: String
    
    init?(species: String) {
        if species.isEmpty { return nil }
        self.species = species
    }
}



var animal = Animal(species:"test")

if let judge = animal {
    print("successed")
}

var animal1 = Animal(species:"")

if let judge = animal1 {
    print("successed")
} else {
    print("failed")
}

/*枚举类型的可失败构造器

你可以通过一个带一个或多个参数的可失败构造器来获取枚举类型中特定的枚举成员。如果提供的参数无法匹配任何枚举成员，则构造失败。

下例中，定义了一个名为TemperatureUnit的枚举类型。其中包含了三个可能的枚举成员(Kelvin，Celsius，和Fahrenheit)，以及一个根据Character值找出所对应的枚举成员的可失败构造器：*/

enum TemperatureUnit {
    
    case Kelvin, Celsius, Fahrenheit
    
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}
//可以重写为：
enum TemperatureUnit1: Character {
    case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
}

var test1 = TemperatureUnit(symbol: "C")

if let judge = test1 {
    print("枚举 successed \(judge.hashValue)")
}

var test2 = TemperatureUnit(symbol: "D")

if let judge = test2 {
    print("枚举successed")
} else {
    print("枚举failed")
}





/*必要构造器
 
 在类的构造器前添加required修饰符表明所有该类的子类都必须实现该构造器：
 
 class SomeClass {
    required init() {
     // 构造器的实现代码
     }
 }
 
 */











