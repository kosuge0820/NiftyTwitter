//
//  TimeLineTableViewController.swift
//  NiftyTwitter
//
//  Created by 小菅仁士 on 2016/03/20.
//  Copyright © 2016年 kosuge satoshi. All rights reserved.
//

import UIKit

class TimeLineTableViewController: UITableViewController {
    @IBOutlet weak var textField: UITextField!

    let tweetManager = TweetManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerNib(UINib(nibName: "TweetTableViewCell", bundle: nil), forCellReuseIdentifier: "TweetTableViewCell")
        tweetManager.fetchTweets { () in
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "投稿", style: .Plain, target: self, action: "post")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .Plain, target: self, action: "logout")
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetManager.tweets.count

    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetTableViewCell", forIndexPath: indexPath) as! TweetTableViewCell
        
        let tweet = tweetManager.tweets[indexPath.row]
        cell.nameLabel.text = "satoshi"
        cell.tweetLabel.text = tweet.text
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }
    
    func post() {
        let tweet = Tweet(text: textField.text!)
        tweet.save { () in
            self.tweetManager.fetchTweets({ () in
                self.tableView.reloadData()
            })
        }
    }
    
    func logout() {
        NCMBUser.logOut()
        performSegueWithIdentifier("modalLoginViewController", sender: self)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if NCMBUser.currentUser() == nil {
            performSegueWithIdentifier("modalLoginViewController", sender: self)
        }
    }
}