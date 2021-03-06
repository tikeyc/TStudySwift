//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)



/*协议语法
 
 协议的定义方式与类、结构体和枚举的定义非常相似：
 
 protocol SomeProtocol {
    // 这里是协议的定义部分
 }
 
 要让自定义类型遵循某个协议，在定义类型时，需要在类型名称后加上协议名称，中间以冒号（:）分隔。遵循多个协议时，各协议之间用逗号（,）分隔：
 
 struct SomeStructure: FirstProtocol, AnotherProtocol {
    // 这里是结构体的定义部分
 }
 
 拥有父类的类在遵循协议时，应该将父类名放在协议名之前，以逗号分隔：
 
 class SomeClass: SomeSuperClass, FirstProtocol, AnotherProtocol {
    // 这里是类的定义部分
 }
 
 
 属性要求
 
 协议可以要求遵循协议的类型提供特定名称和类型的实例属性或类型属性。协议不指定属性是存储型属性还是计算型属性，它只指定属性的名称和类型。此外，协议还指定属性是可读的还是可读可写的。
 
 如果协议要求属性是可读可写的，那么该属性不能是常量属性或只读的计算型属性。如果协议只要求属性是可读的，那么该属性不仅可以是可读的，如果代码需要的话，还可以是可写的。
 
 协议总是用 var 关键字来声明变量属性，在类型声明后加上 { set get } 来表示属性是可读可写的，可读属性则用 { get } 来表示
 
 
 */

protocol SomeProtocol {
    
    var mustBeSettable: Int { get set }
    
    var doesNotNeedToBeSettable: Int { get }
    
    
    static var someTypeProperty: Int { get set }//定义类型属性
    
    
    
}

//这个协议表示，任何遵循 FullyNamed 的类型，都必须有一个可读的 String 类型的实例属性 fullName
protocol FullyNamed {
    
    var fullName: String { get }
    
}


struct Person: FullyNamed {
    
    var fullName: String

}

let john = Person(fullName: "John Appleseed")



/*方法要求
 
 协议可以要求遵循协议的类型实现某些指定的实例方法或类方法。这些方法作为协议的一部分，像普通方法一样放在协议的定义中，但是不需要大括号和方法体。可以在协议中定义具有可变参数的方法，和普通方法的定义方式相同。但是，不支持为协议中的方法的参数提供默认值。
 */


protocol RandomNumberGenerator {
    
    func random() -> Double
    
    mutating func testStructMethodChangeProperty()
    
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    
    var lastRandom = 42.0
    
    let m = 139968.0
    
    let a = 3877.0
    
    let c = 29573.0

    
    func random() -> Double {
        
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy:m))
        
        return lastRandom / m
        
    }
    
    func testStructMethodChangeProperty() {
        
    }
    
}

let generator = LinearCongruentialGenerator()

print("Here's a random number: \(generator.random())")


struct TestStruct: RandomNumberGenerator {
    
    var testProperty = "改变结构体或枚举的属性的值"
    
    
    func random() -> Double {
        return 1.0
    }
    
    mutating func testStructMethodChangeProperty() {
        self.testProperty = "改变结构体或枚举的属性的值"
    }
    
}


/*构造器要求在类中的实现
 
 你可以在遵循协议的类中实现构造器，无论是作为指定构造器，还是作为便利构造器。无论哪种情况，你都必须为构造器实现标上 required 修饰符：
 

 */

protocol SomeProtocol1 {
    
    init(someParameter: Int)
    
}

class SomeClass: SomeProtocol1 {
    
    required init(someParameter: Int) {
        
        // 这里是构造器的实现部分
        
    }
    
}



protocol SomeProtocol2 {
    init()
}

class SomeSuperClass2 {
    init() {
        // 这里是构造器的实现部分
    }
}

class SomeSubClass: SomeSuperClass2, SomeProtocol2 {
    // 因为遵循协议，需要加上 required
    // 因为继承自父类，需要加上 override
    required override init() {
        // 这里是构造器的实现部分
    }
}


//

class Dice {
    
    let sides: Int
    
    let generator: RandomNumberGenerator
    
    
    /// 协议作为类型
    ///
    /// - Parameters:
    ///   - sides:
    ///   - generator: 任何遵循了 RandomNumberGenerator 协议的类型的实例都可以赋值给 generator
    init(sides: Int, generator: RandomNumberGenerator) {
        
        self.sides = sides
        
        self.generator = generator
        
    }
    
    func roll() -> Int {
        
        return Int(generator.random() * Double(sides)) + 1
        
    }
    
}



/*委托（代理）模式
 
 委托是一种设计模式，它允许类或结构体将一些需要它们负责的功能委托给其他类型的实例。委托模式的实现很简单：定义协议来封装那些需要被委托的功能，这样就能确保遵循协议的类型能提供这些功能。委托模式可以用来响应特定的动作，或者接收外部数据源提供的数据，而无需关心外部数据源的类型。
 */


protocol DiceGame {
    
    var dice: Dice { get }
    
    func play()
    
}

protocol DiceGameDelegate {
    
    func gameDidStart(_ game: DiceGame)
    
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    
    func gameDidEnd(_ game: DiceGame)
    
}




class SnakesAndLadders: DiceGame {
    
    let finalSquare = 25
    
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    
    var square = 0
    
    var board: [Int]
    
    init() {
        
        board = [Int](repeating: 0, count: finalSquare + 1)
        
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
        
    }
    
    var delegate: DiceGameDelegate?
    
    func play() {
        
        square = 0
        
        delegate?.gameDidStart(self)
        
        gameLoop: while square != finalSquare {
            
            let diceRoll = dice.roll()
            
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            
            switch square + diceRoll {
                
            case finalSquare:
                
                break gameLoop
                
            case let newSquare where newSquare > finalSquare:
                
                continue gameLoop
                
            default:
                
                square += diceRoll
                
                square += board[square]
                
            }
            
        }
        
        delegate?.gameDidEnd(self)
        
    }
    
}




class DiceGameTracker: DiceGameDelegate {
    
    var numberOfTurns = 0
    
    func gameDidStart(_ game: DiceGame) {
        
        numberOfTurns = 0
        
        if game is SnakesAndLadders {
            
            print("Started a new game of Snakes and Ladders")
            
        }
        
        print("The game is using a \(game.dice.sides)-sided dice")
        
    }
    
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        
        numberOfTurns += 1
        
        print("Rolled a \(diceRoll)")
        
    }
    
    func gameDidEnd(_ game: DiceGame) {
        
        print("The game lasted for \(numberOfTurns) turns")
        
    }
    
}



let tracker = DiceGameTracker()

let game = SnakesAndLadders()

game.delegate = tracker

game.play()



/*通过扩展添加协议一致性*/
protocol TextRepresentable {
    var textualDescription: String { get }
}
//可以通过扩展，令先前提到的 Dice 类遵循并符合 TextRepresentable 协议：
extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}




/*协议的继承

协议能够继承一个或多个其他协议，可以在继承的协议的基础上增加新的要求。协议的继承语法与类的继承相似，多个被继承的协议间用逗号分隔：
 */

protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
}


/*协议合成

有时候需要同时遵循多个协议，你可以将多个协议采用 SomeProtocol & AnotherProtocol 这样的格式进行组合，称为 协议合成（protocol composition）。你可以罗列任意多个你想要遵循的协议，以与符号(&)分隔。

下面的例子中，将 Named 和 Aged 两个协议按照上述语法组合成一个协议，作为函数参数的类型：
 */

protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct Person1: Named, Aged {
    var name: String
    var age: Int
}
func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}
let birthdayPerson = Person1(name: "Malcolm", age: 21)
wishHappyBirthday(to: birthdayPerson)



/*
 可选的协议要求
 
 协议可以定义可选要求，遵循协议的类型可以选择是否实现这些要求。在协议中使用 optional 关键字作为前缀来定义可选要求。可选要求用在你需要和 Objective-C 打交道的代码中。协议和可选要求都必须带上@objc属性。标记 @objc 特性的协议只能被继承自 Objective-C 类的类或者 @objc 类遵循，其他类以及结构体和枚举均不能遵循这种协议。
 */

@objc protocol CounterDataSource {
    @objc optional func incrementForCount(count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}



/*协议扩展

协议可以通过扩展来为遵循协议的类型提供属性、方法以及下标的实现。通过这种方式，你可以基于协议本身来实现这些功能，而无需在每个遵循协议的类型中都重复同样的实现，也无需使用全局函数。

例如，可以扩展 RandomNumberGenerator 协议来提供 randomBool() 方法。该方法使用协议中定义的 random() 方法来返回一个随机的 Bool 值：
*/

extension RandomNumberGenerator {
    //提供默认实现
    func randomBool() -> Bool {
        return random() > 0.5
    }
}



/*为协议扩展添加限制条件

在扩展协议的时候，可以指定一些限制条件，只有遵循协议的类型满足这些限制条件时，才能获得协议扩展提供的默认实现。这些限制条件写在协议名之后，使用 where 子句来描述，正如Where子句中所描述的。

例如，你可以扩展 CollectionType 协议，但是只适用于集合中的元素遵循了 TextRepresentable 协议的情况：
 */

//extension CollectionType where Generator.Element: TextRepresentable {
//    var textualDescription: String {
//        let itemsAsText = self.map { $0.textualDescription }
//        return "[" + itemsAsText.joinWithSeparator(", ") + "]"
//    }
//}











