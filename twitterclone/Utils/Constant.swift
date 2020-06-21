//
//  Constant.swift
//  twitterclone
//
//  Created by Albert Stanley on 22/06/20.
//  Copyright © 2020 slorop. All rights reserved.
//

import Firebase

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_image")

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
