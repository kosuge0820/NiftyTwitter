//
//  TweetManager.swift
//  NiftyTwitter
//
//  Created by 小菅仁士 on 2016/03/20.
//  Copyright © 2016年 kosuge satoshi. All rights reserved.
//

import UIKit

class TweetManager: NSObject {
    static let sharedInstance = TweetManager()
    var tweets: [Tweet] = []
    
    func fetchTweets(callback: () -> Void) {
        let query = NCMBQuery(className: "Tweet")
        query.includeKey("user")
        query.orderByDescending("createDate")
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            if error == nil {
                self.tweets = []
                for object in objects {
                    let text = object.objectForKey("text") as! String
                    let tweet = Tweet(text: text)
                    let userObject = object.objectForKey("user") as! NCMBUser
                    let user = User(name: userObject.userName!, password: "")
                    tweet.user = user
                    self.tweets.append(tweet)
                    callback()
                    
                }
            }
        }
    }
}
