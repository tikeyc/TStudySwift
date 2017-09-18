//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)


/*嵌套类型实践
 
 下面这个例子定义了一个结构体BlackjackCard（二十一点），用来模拟BlackjackCard中的扑克牌点数。BlackjackCard结构体包含两个嵌套定义的枚举类型Suit和Rank。
 
 在BlackjackCard中，Ace牌可以表示1或者11，Ace牌的这一特征通过一个嵌套在Rank枚举中的结构体Values来表示：
 */

struct BlackjackCard {
    
    // 嵌套的 Suit 枚举
    enum Suit: Character {
        
        case Spades = "♠", Hearts = "♡", Diamonds = "♢", Clubs = "♣"
        
    }
    
    // 嵌套的 Rank 枚举
    enum Rank: Int {
        
        case Two = 2, Three, Four, Five, Six, Seven, Eight, Nine, Ten
        
        case Jack, Queen, King, Ace
        
        struct Values {
            
            let first: Int, second: Int?
            
        }
        
        var values: Values {
            
            switch self {
                
            case .Ace:
                
                return Values(first: 1, second: 11)
                
            case .Jack, .Queen, .King:
                
                return Values(first: 10, second: nil)
                
            default:
                
                return Values(first: self.rawValue, second: nil)
                
            }
            
        }
        
    }
    
    // BlackjackCard 的属性和方法
    let rank: Rank, suit: Suit
    
    var description: String {
        
        var output = "suit is \(suit.rawValue),"
        
        output += " value is \(rank.values.first)"
        
        if let second = rank.values.second {
            
            output += " or \(second)"
            
        }
        
        return output
        
    }
    
}


let theAceOfSpades = BlackjackCard(rank: .Ace, suit: .Spades)

print("theAceOfSpades: \(theAceOfSpades.description)")




let heartsSymbol = BlackjackCard.Suit.Hearts.rawValue

print(heartsSymbol)











