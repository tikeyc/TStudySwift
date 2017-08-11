//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)


/*
 枚举为一组相关的值定义了一个共同的类型，使你可以在你的代码中以类型安全的方式来使用这些值。
 
 如果你熟悉 C 语言，你会知道在 C 语言中，枚举会为一组整型值分配相关联的名称。Swift 中的枚举更加灵活，不必给每一个枚举成员提供一个值。如果给枚举成员提供一个值（称为“原始”值），则该值的类型可以是字符串，字符，或是一个整型值或浮点数。
 
 此外，枚举成员可以指定任意类型的关联值存储到枚举成员中，就像其他语言中的联合体（unions）和变体（variants）。你可以在一个枚举中定义一组相关的枚举成员，每一个枚举成员都可以有适当类型的关联值。
 
 在 Swift 中，枚举类型是一等（first-class）类型。它们采用了很多在传统上只被类（class）所支持的特性，例如计算属性（computed properties），用于提供枚举值的附加信息，实例方法（instance methods），用于提供和枚举值相关联的功能。枚举也可以定义构造函数（initializers）来提供一个初始值；可以在原始实现的基础上扩展它们的功能；还可以遵循协议（protocols）来提供标准的功能
 
 与 C 和 Objective-C 不同，Swift 的枚举成员在被创建时不会被赋予一个默认的整型值。
 在上面的CompassPoint例子中，north，south，east和west不会被隐式地赋值为0，1，2和3。
 相反，这些枚举成员本身就是完备的值，这些值的类型是已经明确定义好的CompassPoint类型。
 */

enum CompassPoint {
    case north
    case south
    case east
    case west
}


var directionToHead = CompassPoint.west

directionToHead = .east

//必须穷举所有情况, 尝试注释某一情况将编译错误
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}


/*关联值
 */
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}
var productBarcode = Barcode.upc(8, 85909, 51226, 3)

switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}

productBarcode = .qrCode("ABCDEFGHIJKLMNOP")
//这时，原始的Barcode.upc和其整数关联值被新的Barcode.qrCode和其字符串关联值所替代。
//Barcode类型的常量和变量可以存储一个.upc或者一个.qrCode（连同它们的关联值），
//但是在同一时间只能存储这两个值中的一个

switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}


//如果一个枚举成员的所有关联值都被提取为常量，或者都被提取为变量，
//为了简洁，你可以只在成员名称前标注一个let或者var：

switch productBarcode {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case let .qrCode(productCode):
    print("QR code: \(productCode).")
}



/*原始值
 在关联值小节的条形码例子中，演示了如何声明存储不同类型关联值的枚举成员。
 作为关联值的替代选择，枚举成员可以被默认值（称为原始值）预填充，这些原始值的类型必须相同。
 
 这是一个使用 ASCII 码作为原始值的枚举：
 */

enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

enum Test: String {
    case type1 = "type1"
    case type2 = "type2"
    case type3 = "type3"
//    case type4 = 4 错误
}

enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

//原始值的隐式赋值
print(Planet.earth.rawValue)
print(CompassPoint.west.hashValue)


/*使用原始值初始化枚举实例

 如果在定义枚举类型的时候使用了原始值，那么将会自动获得一个初始化方法，
 这个方法接收一个叫做rawValue的参数，参数类型即为原始值类型，返回值则是枚举成员或nil。
 你可以使用这个初始化方法来创建一个新的枚举实例。
 */

let possiblePlanet = Planet(rawValue: 2)

if possiblePlanet == Planet.venus {
    print("possiblePlanet == Planet.venus")
}













