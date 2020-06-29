//
//  TweetViewModel.swift
//  twitterclone
//
//  Created by Albert Stanley on 28/06/20.
//  Copyright © 2020 slorop. All rights reserved.
//

import UIKit

struct TweetViewModel {
    let tweet: Tweet
    let user: User
    
    var profileImageUrl: URL? {
        return user.profileImageUrl
    }
    
    var timeStamp: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        let now = Date()
        return formatter.string(from: tweet.timestamp ?? Date(), to: now) ?? ""
    }
    
    var userInfoText: NSAttributedString? {
        let title = NSMutableAttributedString(string: user.fullname, attributes: [.font : UIFont.systemFont(ofSize: 14)])
        title.append(NSAttributedString(string: " @\(user.username)", attributes: [.font : UIFont.systemFont(ofSize: 14), .foregroundColor : UIColor.systemGray]))
        title.append(NSAttributedString(string: " ~ \(timeStamp)", attributes: [.font : UIFont.systemFont(ofSize: 14), .foregroundColor : UIColor.systemGray]))
        return title
    }
    
    init(tweet: Tweet){
        self.tweet = tweet
        self.user = tweet.user
    }
}
