//
//  User.swift
//  twitterclone
//
//  Created by Albert Stanley on 26/06/20.
//  Copyright © 2020 slorop. All rights reserved.
//

import Foundation

struct User {
    let fullname: String
    let email: String
    let username: String
    var profileImageUrl: URL?
    let uid: String
    
    init(uid: String, dict: [String : AnyObject]) {
        self.uid = uid
        self.fullname = dict["fullname"] as? String ?? ""
        self.email = dict["email"] as? String ?? ""
        self.username = dict["username"] as? String ?? ""
        
        if let stringProfileImageUrl =  dict["profileImageUrl"] as? String {
            guard let url = URL(string: stringProfileImageUrl) else { return }
            self.profileImageUrl = url
        }
    }
}
