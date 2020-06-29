//
//  Image.swift
//  twitterclone
//
//  Created by Albert Stanley on 28/06/20.
//  Copyright © 2020 slorop. All rights reserved.
//

import UIKit

class ProfileImage {
    func smallImage() {
        
    }
    
    func medium() -> UIImageView {
        let img = UIImageView()
        img.setDimensions(width: 64, height: 64)
        img.layer.cornerRadius = 64/2
        img.backgroundColor = .twitterBlue
        img.layer.masksToBounds = true
        return img
    }
}
