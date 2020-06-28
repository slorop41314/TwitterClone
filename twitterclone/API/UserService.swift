//
//  UserService.swift
//  twitterclone
//
//  Created by Albert Stanley on 26/06/20.
//  Copyright © 2020 slorop. All rights reserved.
//

import Firebase

struct UserService {
    static let shared = UserService()
    
    func getUserData(uid : String, completion: @escaping(User) -> Void) {
        REF_USERS.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let dict = snapshot.value as? [String : AnyObject] else { return }
            let user = User(uid: uid, dict: dict)
            completion(user)
        }
    }
}
