//
//  AuthService.swift
//  
//
//  Created by Albert Stanley on 23/06/20.
//

import Foundation
import Firebase
import UIKit
struct AuthCredentials {
    let fullname: String
    let email: String
    let username: String
    let password: String
    let profileImage: UIImage
}

class AuthService {
    static let shared = AuthService()
    
    func registerUser(userData: AuthCredentials, completion: @escaping(Error?, DatabaseReference)-> Void){
        guard let imageData = userData.profileImage.jpegData(compressionQuality: 0.3) else { return }
        let filename = NSUUID().uuidString
        let storageRef = STORAGE_PROFILE_IMAGES.child(filename)
        
        storageRef.putData(imageData, metadata: nil) { (meta, err) in
            storageRef.downloadURL { (url, err) in
                guard let profileImageUrl = url?.absoluteString else { return }
                Auth.auth().createUser(withEmail: userData.email, password: userData.password) { (res, err) in
                    if let error = err {
                        print(error.localizedDescription)
                        return
                    }
                    guard let uid = res?.user.uid else { return }
                    let values = ["username" : userData.username,"fullname" : userData.fullname, "email" : userData.email, "profileImageUrl" : profileImageUrl]
                    REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
                }
            }
        }
    }
    
    func logUserIn(withEmail email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void){
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
}
