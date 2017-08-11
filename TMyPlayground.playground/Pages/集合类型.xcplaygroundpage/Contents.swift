//: [Previous](@previous)

import Foundation
import UIKit

var str = "Hello, playground"

//: [Next](@next)


/*
 Swift 语言提供Arrays、Sets和Dictionaries三种基本的集合类型用来存储集合数据。数组（Arrays）是有序数据的集。集合（Sets）是无序无重复数据的集。字典（Dictionaries）是无序的键值对的集。
 */



var someInts = [Int]()

someInts.append(3)

//Swift 中的Array类型还提供一个可以创建特定大小并且所有数据都被默认的构造方法。
//我们可以把准备加入新数组的数据项数量（count）和适当类型的初始值（repeating）传入数组构造函数
var threeDoubles = Array(repeating: 0.0, count: 3)

var anotherThreeDoubles = Array(repeating: 2.5, count: 3)

var sixDoubles = threeDoubles + anotherThreeDoubles


var array1: [String] = ["string0", "string1", "string2"]

array1 += ["string3"]

array1 += ["string4", "string5"]

array1[0]

array1[0] = "string1"

array1[0]
array1[0] = "string0"

//还可以利用下标来一次改变一系列数据值，使新数据和原有数据的数量是不一样的
print(array1)//["string0", "string1", "string2", "string3", "string4", "string5"]
array1[2...4] = ["change2_0", "change3_0"]
print(array1)//["string0", "string1", "change2_0", "change3_0", "string5"]

array1.removeLast()

/*
 如果我们同时需要每个数据项的值和索引值，可以使用enumerated()方法来进行数组遍历。
 enumerated()返回一个由每一个数据项索引值和数据值组成的元组。
 我们可以把这个元组分解成临时常量或者变量来进行遍历
 */

for (index, value) in array1.enumerated() {
    print("Item \(String(index + 1)): \(value)")
}



/*
 集合(Set)用来存储相同类型并且没有确定顺序的值。
 当集合元素顺序不重要时或者希望确保每个元素只出现一次时可以使用集合而不是数组
 */

var letters = Set<String>()

var set1: Set<String> = ["set1", "set0", "set2"]

/*
 使用intersection(_:)方法根据两个集合中都包含的值创建的一个新的集合。
 使用symmetricDifference(_:)方法根据在一个集合中但不在两个集合中的值创建一个新的集合。
 使用union(_:)方法根据两个集合的值创建一个新的集合。
 使用subtracting(_:)方法根据不在该集合中的值创建一个新的集合。
 */
var image = UIImage.init(named: "setVennDiagram_2x")

//var image = UIImage.init(imageLiteralResourceName: "setVennDiagram_2x")
//var imageView = UIImageView.init(image: image)

let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

oddDigits.union(evenDigits).sorted()
// [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
oddDigits.intersection(evenDigits).sorted()
// []
oddDigits.subtracting(singleDigitPrimeNumbers).sorted()
// [1, 9]
oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()
// [1, 2, 9]


/**
 使用“是否相等”运算符(==)来判断两个集合是否包含全部相同的值。
 使用isSubset(of:)方法来判断一个集合中的值是否也被包含在另外一个集合中。
 使用isSuperset(of:)方法来判断一个集合中包含另一个集合中所有的值。
 使用isStrictSubset(of:)或者isStrictSuperset(of:)方法来判断一个集合是否是另外一个集合的子集合或者父集合并且两个集合并不相等。
 使用isDisjoint(with:)方法来判断两个集合是否不含有相同的值(是否没有交集)。
 */
let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]

houseAnimals.isSubset(of: farmAnimals)
// true
farmAnimals.isSuperset(of: houseAnimals)
// true
farmAnimals.isDisjoint(with: cityAnimals)
// true



/*
 字典
 */

var dis1 = [Int: String]()

var dis2: [String: String] = ["key1": "value1", "key2": "value2"]


for (key, value) in dis2 {
    print(key,value)
}

for key in dis2.keys {
    
}

for value in dis2.values {
    
}










