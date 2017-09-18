//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)








class Person {
    
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    var apartment: Apartment?
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

class Apartment {
    
    let unit: String
    
    init(unit: String) {
        self.unit = unit
    }
    
//    var tenant: Person?//将导致循环引用 无法释放
    weak var tenant: Person? //弱引用 安全释放
    
    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}

var john: Person?

var unit4A: Apartment?


john = Person(name: "John Appleseed")

unit4A = Apartment(unit: "4A")


john!.apartment = unit4A

unit4A!.tenant = john

/*不幸的是，这两个实例关联后会产生一个循环强引用。Person实例现在有了一个指向Apartment实例的强引用，
 而Apartment实例也有了一个指向Person实例的强引用。
 因此，当你断开john和unit4A变量所持有的强引用时，引用计数并不会降为0，实例也不会被 ARC 销毁：
 
 这就在你的应用程序中造成了内存泄漏。
 */
john = nil

unit4A = nil

/*解决实例之间的循环强引用
 
 Swift 提供了两种办法用来解决你在使用类的属性时所遇到的循环强引用问题：
 弱引用（weak reference）和无主引用（unowned reference)
 
 当其他的实例有更短的生命周期时，使用弱引用，也就是说，当其他实例析构在先时。
 在上面公寓的例子中，很显然一个公寓在它的生命周期内会在某个时间段没有它的主人，
 所以一个弱引用就加在公寓类里面，避免循环引用。相比之下，当其他实例有相同的或者更长生命周期时，请使用无主引用
 */





/*和弱引用类似，无主引用不会牢牢保持住引用的实例。和弱引用不同的是，无主引用在其他实例有相同或者更长的生命周期时使用。你可以在声明属性或者变量时，在前面加上关键字unowned表示这是一个无主引用。
 
 无主引用通常都被期望拥有值。不过 ARC 无法在实例被销毁后将无主引用设为nil，因为非可选类型的变量不允许被赋值为nil。
 
 重要
 使用无主引用，你必须确保引用始终指向一个未销毁的实例。
 如果你试图在实例被销毁后，访问该实例的无主引用，会触发运行时错误。
 */

class Customer {
    
    let name: String
    
    var card: CreditCard?
    
    init(name: String) {
        
        self.name = name
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
    
}
class CreditCard {
    
    let number: UInt64
    
    unowned let customer: Customer
    
    init(number: UInt64, customer: Customer) {
        
        self.number = number
        
        self.customer = customer
    }
    
    deinit {
        print("Card #\(number) is being deinitialized")
    }
    
}

var customer: Customer?

var card: CreditCard?

customer = Customer(name: "John Appleseed")

card = CreditCard(number: 1234_5678_9012_3456, customer: customer!)

customer!.card = card

//Customer实例持有对CreditCard实例的强引用，而CreditCard实例持有对Customer实例的无主引用。
//由于customer的无主引用，当你断开customer变量持有的强引用时，再也没有指向Customer实例的强引用了
customer = nil




/*无主引用以及隐式解析可选属性
 
 上面弱引用和无主引用的例子涵盖了两种常用的需要打破循环强引用的场景。
 
 Person和Apartment的例子展示了两个属性的值都允许为nil，并会潜在的产生循环强引用。这种场景最适合用弱引用来解决。
 
 Customer和CreditCard的例子展示了一个属性的值允许为nil，而另一个属性的值不允许为nil，这也可能会产生循环强引用。这种场景最适合通过无主引用来解决。
 
 然而，存在着第三种场景，在这种场景中，两个属性都必须有值，并且初始化完成后永远不会为nil。在这种场景中，需要一个类使用无主属性，而另外一个类使用隐式解析可选属性
 */


class Country {
    
    let name: String
    
    //Country的构造函数调用了City的构造函数。然而，只有Country的实例完全初始化后，Country的构造函数才能把self传给City的构造函数。在两段式构造过程中有具体描述。
    
    //为了满足这种需求，通过在类型结尾处加上感叹号（City!）的方式，将Country的capitalCity属性声明为隐式解析可选类型的属性。这意味着像其他可选类型一样，capitalCity属性的默认值为nil，但是不需要展开它的值就能访问它
    var capitalCity: City!
    
    init(name: String, capitalName: String) {
        
        self.name = name
        
        self.capitalCity = City(name: capitalName, country: self)
    }
    
    deinit {
        print("Country deinit")
    }
}

class City {
    
    let name: String
    
    unowned let country: Country
    
    init(name: String, country: Country) {
        
        self.name = name
        
        self.country = country
    }
    
    deinit {
        print("City deinit")
    }
}


//使用隐式解析可选值意味着满足了类的构造函数的两个构造阶段的要求。capitalCity属性在初始化完成后，能像非可选值一样使用和存取，同时还避免了循环强引用
var country = Country(name: "Canada", capitalName: "Ottawa")
print("\(country.name)'s capital city is called \(country.capitalCity.name)")



/*闭包引起的循环强引用
 
 循环强引用的产生，是因为闭包和类相似，都是引用类型
 
 Swift 提供了一种优雅的方法来解决这个问题，称之为闭包捕获列表（closure capture list）
 
 注意
 Swift 有如下要求：只要在闭包内使用self的成员，就要用self.someProperty或者self.someMethod()（而不只是someProperty或someMethod()）。这提醒你可能会一不小心就捕获了self
 */



//HTMLElement还定义了一个lazy属性asHTML。这个属性引用了一个将name和text组合成 HTML 字符串片段的闭包。
//该属性是Void -> String类型，或者可以理解为“一个没有参数，返回String的函数”
class HTMLElement {
    
    let name: String
    
    let text: String?
    
    var delegate: NSObject?
    
    lazy var someClosure: (Int, String) -> String = {
        
        [unowned self, weak delegate = self.delegate!] (index: Int, stringToProcess: String) -> String in
        
        // 这里是闭包的函数体
        return ""
    }
    
    lazy var asHTML: (Void) -> String = {
        
//        [unowned self] () -> String in //解决闭包的循环引用
        [unowned self] in //或者这样写
        
        if let text = self.text {
            
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        
        self.name = name
        
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
    
}


var element: HTMLElement?

element = HTMLElement.init(name: "p", text: "text")

print(element?.asHTML())


element = nil





