//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)


/*析构器只适用于类类型，当一个类的实例被释放之前，析构器会被立即调用。析构器用关键字deinit来标示，类似于构造器要用init来标示。
 
 
 析构过程原理
 
 Swift 会自动释放不再需要的实例以释放资源。如自动引用计数章节中所讲述，Swift 通过自动引用计数（ARC）处理实例的内存管理。通常当你的实例被释放时不需要手动地去清理。但是，当使用自己的资源时，你可能需要进行一些额外的清理。例如，如果创建了一个自定义的类来打开一个文件，并写入一些数据，你可能需要在类实例被释放之前手动去关闭该文件。
 
 在类的定义中，每个类最多只能有一个析构器，而且析构器不带任何参数，如下所示：
 
 deinit {
    // 执行析构过程
 }
 */


class Bank {
    
    static var coinsInBank = 10_000
    
    static func distribute(coins numberOfCoinsRequested: Int) -> Int {
        
        let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
        
        coinsInBank -= numberOfCoinsToVend
        
        return numberOfCoinsToVend
    }
    static func receive(coins: Int) {
        
        coinsInBank += coins
    }
}


class Player {
    
    var coinsInPurse: Int
    
    init(coins: Int) {
        
        coinsInPurse = Bank.distribute(coins: coins)
    }
    
    func win(coins: Int) {
        
        coinsInPurse += Bank.distribute(coins: coins)
    }
    
    deinit {
        
        Bank.receive(coins: coinsInPurse)
        
        print("Player  deinit")
    }
}



var playerOne: Player? = Player(coins: 100)

playerOne!.win(coins: 2_000)
print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")

playerOne = nil














