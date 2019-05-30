//
//  UserManager.swift
//  TStudySwift01
//
//  Created by ways on 2018/1/16.
//  Copyright © 2018年 tikeyc. All rights reserved.
//

import UIKit

let UserInstance = UserManager.shareInstance

class UserManager: NSObject {
    
    var nickname = "tikeyc"
    
    var password = "666"
    
    //创建单例
    class var shareInstance: UserManager {
        struct Static {
            static let instance: UserManager = UserManager()
        }
        return Static.instance
    }
    

}
