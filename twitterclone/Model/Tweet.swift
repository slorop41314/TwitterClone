//
//  Tweet.swift
//  twitterclone
//
//  Created by Albert Stanley on 28/06/20.
//  Copyright © 2020 slorop. All rights reserved.
//

import Foundation


struct Tweet {
    let caption: String
    let tweetId: String
    let uid: String
    let likes: Int
    let retweetCount: Int
    var timestamp: Date?
    let user: User
    
    init(user: User,tweetId: String, dict: [String : Any]){
        self.tweetId = tweetId
        self.user = user
        self.caption = dict["caption"] as? String ?? ""
        self.uid = dict["uid"] as? String ?? ""
        self.likes = dict["likes"] as? Int ?? 0
        self.retweetCount = dict["retweet"] as? Int ?? 0
        if let timestamp = dict["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
    }
}
