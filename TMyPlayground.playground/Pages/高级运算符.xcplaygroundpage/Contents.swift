//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)


/*位运算符
 
 位运算符可以操作数据结构中每个独立的比特位。它们通常被用在底层开发中，比如图形编程和创建设备驱动。位运算符在处理外部资源的原始数据时也十分有用，比如对自定义通信协议传输的数据进行编码和解码。
 
 Swift 支持 C 语言中的全部位运算符，接下来会一一介绍。
 */


/*按位取反运算符
 
 按位取反运算符（~）可以对一个数值的全部比特位进行取反：
 
 按位取反运算符是一个前缀运算符，需要直接放在运算的数之前，并且它们之间不能添加任何空格：
 */
let initialBits: UInt8 = 0b00001111
let invertedBits = ~initialBits // 等于 0b11110000


/*按位与运算符
 
 按位与运算符（&）可以对两个数的比特位进行合并。它返回一个新的数，只有当两个数的对应位都为 1 的时候，新数的对应位才为 1：
 */
let firstSixBits: UInt8 = 0b11111100
let lastSixBits: UInt8  = 0b00111111
let middleFourBits = firstSixBits & lastSixBits // 等于 00111100

/*按位或运算符
 
 按位或运算符（|）可以对两个数的比特位进行比较。它返回一个新的数，只要两个数的对应位中有任意一个为 1 时，新数的对应位就为 1：
 */
let someBits: UInt8 = 0b10110010
let moreBits: UInt8 = 0b01011110
let combinedbits = someBits | moreBits // 等于 11111110


/*按位异或运算符
 
 按位异或运算符（^）可以对两个数的比特位进行比较。它返回一个新的数，当两个数的对应位不相同时，新数的对应位就为 1
 */
let firstBits: UInt8 = 0b00010100
let otherBits: UInt8 = 0b00000101
let outputBits = firstBits ^ otherBits // 等于 00010001


/*按位左移、右移运算符
 
 按位左移运算符（<<）和按位右移运算符（>>）可以对一个数的所有位进行指定位数的左移和右移，但是需要遵守下面定义的规则。
 
 对一个数进行按位左移或按位右移，相当于对这个数进行乘以 2 或除以 2 的运算。将一个整数左移一位，等价于将这个数乘以 2，同样地，将一个整数右移一位，等价于将这个数除以 2。
 
 无符号整数的移位运算
 
 对无符号整数进行移位的规则如下：
 
 已经存在的位按指定的位数进行左移和右移。
 任何因移动而超出整型存储范围的位都会被丢弃。
 用 0 来填充移位后产生的空白位
 */
let shiftBits: UInt8 = 4 // 即二进制的 00000100
shiftBits << 1           // 00001000
shiftBits << 2           // 00010000
shiftBits << 5           // 10000000
shiftBits << 6           // 00000000
shiftBits >> 2           // 00000001


/*有符号整数的移位运算
 符号位为 0 代表正数，为 1 代表负数。
 */
let shiftBits1: Int = -4
shiftBits1 << 1




/*自定义运算符
 
 除了实现标准运算符，在 Swift 中还可以声明和实现自定义运算符。可以用来自定义运算符的字符列表请参考运算符。
 
 新的运算符要使用 operator 关键字在全局作用域内进行定义，同时还要指定 prefix、infix 或者 postfix 修饰符：
 
 prefix operator +++ {}
 上面的代码定义了一个新的名为 +++ 的前缀运算符。对于这个运算符，在 Swift 中并没有意义，因此我们针对 Vector2D 的实例来定义它的意义。对这个示例来讲，+++ 被实现为“前缀双自增”运算符。它使用了前面定义的复合加法运算符来让矩阵对自身进行相加，从而让 Vector2D 实例的 x 属性和 y 属性的值翻倍。实现 +++ 运算符的方式如下：
 */

struct Vector2D {
    var x = 0.0, y = 0.0
}

extension Vector2D {
    static func + (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y + right.y)
    }
}

extension Vector2D {
    static prefix func - (vector: Vector2D) -> Vector2D {
        return Vector2D(x: -vector.x, y: -vector.y)
    }
}

extension Vector2D {
    static func += (left: inout Vector2D, right: Vector2D) {
        left = left + right
    }
}

extension Vector2D {
    static func == (left: Vector2D, right: Vector2D) -> Bool {
        return (left.x == right.x) && (left.y == right.y)
    }
    static func != (left: Vector2D, right: Vector2D) -> Bool {
        return !(left == right)
    }
}


//extension Vector2D {
//    static prefix func +++ (vector: inout Vector2D) -> Vector2D {
//        vector += vector
//        return vector
//    }
//}
//
//
//var toBeDoubled = Vector2D(x: 1.0, y: 4.0)
//let afterDoubling = +++toBeDoubled
// toBeDoubled 现在的值为 (2.0, 8.0)
// afterDoubling 现在的值也为 (2.0, 8.0)












