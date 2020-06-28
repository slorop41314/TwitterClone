//
//  TweetService.swift
//  twitterclone
//
//  Created by Albert Stanley on 27/06/20.
//  Copyright © 2020 slorop. All rights reserved.
//

import Firebase

struct TweetService {
    static let shared = TweetService()
    
    func uploadTweet(caption: String,completion: @escaping(Error?, DatabaseReference ) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let values = [
            "uid": uid,
            "timestamp": Int(NSDate().timeIntervalSince1970),
            "likes": 0,
            "retweet": 0,
            "caption": caption,
            ] as [String : Any]
        
        REF_TWEETS.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
    }
    
    func fetchTweets(completion: @escaping([Tweet]) -> Void){
        var tweets = [Tweet]()
        
        REF_TWEETS.observe(.childAdded) { (snapshot) in
            guard let dict = snapshot.value as? [String: Any] else { return }
            guard let uid = dict["uid"] as? String else { return }
            UserService.shared.getUserData(uid: uid) { (user) in
                let tweetId = snapshot.key
                let tweet = Tweet(user: user,tweetId: tweetId, dict: dict)
                tweets.append(tweet)
                completion(tweets)
            }
        }
    }
}
