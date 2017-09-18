//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)



/*类型转换
 
 类型转换在 Swift 中使用 is 和 as 操作符实现。
 这两个操作符提供了一种简单达意的方式去检查值的类型或者转换它的类型。
 
 你也可以用它来检查一个类型是否实现了某个协议
 */



class MediaItem {
    
    var name: String
    
    init(name: String) {
        
        self.name = name
        
    }
    
}



class Movie: MediaItem {
    
    var director: String
    
    init(name: String, director: String) {
        
        self.director = director
        
        super.init(name: name)
        
    }
    
}

class Song: MediaItem {
    
    var artist: String
    
    init(name: String, artist: String) {
        
        self.artist = artist
        
        super.init(name: name)
        
    }
    
}

//Swift 的类型检测器能够推断出 Movie 和 Song 有共同的父类 MediaItem，所以它推断出 [MediaItem] 类作为 library 的类型
let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One And Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]
print("\n类型转换:")
for item in library {
    
    if item is Movie {
        
        print(NSStringFromClass(Movie.self))
        
    } else if item is Song {
        
        print(NSStringFromClass(Song.self))
        
    }
    
}


/*向下转型
 
 某类型的一个常量或变量可能在幕后实际上属于一个子类。当确定是这种情况时，你可以尝试向下转到它的子类型，用类型转换操作符（as? 或 as!）
 
 因为向下转型可能会失败，类型转型操作符带有两种不同形式。条件形式as? 返回一个你试图向下转成的类型的可选值。强制形式 as! 把试图向下转型和强制解包（转换结果结合为一个操作)
 */

print("\n向下转型:")
for item in library {
    
    if let movie = item as? Movie {
        
        print("Movie: '\(movie.name)', dir. \(movie.director)")
        
    } else if let song = item as? Song {
        
        print("Song: '\(song.name)', by \(song.artist)")
        
    }
    
}



/*Any 和 AnyObject 的类型转换
 
 Swift 为不确定类型提供了两种特殊的类型别名：
 
 Any: 可以表示任何类型，包括函数类型。
 AnyObject: 可以表示任何类类型的实例
 */




//创建了一个可以存储 Any 类型的数组 things
var things = [Any]()

things.append(0)

things.append(0.0)

things.append(42)

things.append(3.14159)

things.append("hello")

things.append((3.0, 5.0))

things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))

things.append({ (name: String) -> String in "Hello, \(name)" })

print("\nAny 和 AnyObject 的类型转换:")
for thing in things {
    
    switch thing {
        
    case 0 as Int:
        
        print("zero as an Int")
        
    case 0 as Double:
        
        print("zero as a Double")
        
    case let someInt as Int:
        
        print("an integer value of \(someInt)")
        
    case let someDouble as Double where someDouble > 0:
        
        print("a positive double value of \(someDouble)")
        
    case is Double:
        
        print("some other double value that I don't want to print")
        
    case let someString as String:
        
        print("a string value of \"\(someString)\"")
        
    case let (x, y) as (Double, Double):
        
        print("an (x, y) point at \(x), \(y)")
        
    case let movie as Movie:
        
        print("a movie called '\(movie.name)', dir. \(movie.director)")
        
    case let stringConverter as (String) -> String:
        
        print(stringConverter("Michael"))
        
    default:
        
        print("something else")
        
    }
    
}





















