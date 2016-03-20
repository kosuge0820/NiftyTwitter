//
//  Tweet.swift
//  NiftyTwitter
//
//  Created by 小菅仁士 on 2016/03/20.
//  Copyright © 2016年 kosuge satoshi. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var text: String
    
    init(text: String) {
        self.text = text
    }

    
    func save(callback: () -> Void) {
        let tweetObject = NCMBObject(className: "Tweet")
        tweetObject.setObject(text, forKey: "text")
        tweetObject.saveInBackgroundWithBlock { (error) in
            if error == nil {
                callback()
            }
        }
    }
}
