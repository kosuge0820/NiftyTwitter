//
//  User.swift
//  NiftyTwitter
//
//  Created by 小菅仁士 on 2016/03/20.
//  Copyright © 2016年 kosuge satoshi. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String
    var password: String
    
    init(name: String, password: String) {
        self.name = name
        self.password = password
    }
    
    func signUp(callback: (message: String?) -> Void) {
        let user = NCMBUser()
        user.userName = name
        user.password = password
        user.signUpInBackgroundWithBlock { (error) in
            callback(message: error?.userInfo["NSLocalizedDescription"] as? String)
        }
    }
    
    func login(callback: (message: String?) -> Void) {
        NCMBUser.logInWithUsernameInBackground(self.name, password: self.password) { (user, error) in
            callback(message: error?.userInfo["NSLocalizedDescription"] as? String)
        }
    }
}

