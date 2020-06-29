//
//  Button.swift
//  twitterclone
//
//  Created by Albert Stanley on 28/06/20.
//  Copyright © 2020 slorop. All rights reserved.
//

import UIKit

class Button {
    func smallButtonWithImage(icon: UIImage) -> UIButton {
        let btn = UIButton(type: .system)
        btn.setImage(icon, for: .normal)
        btn.setDimensions(width: 20, height: 20)
        btn.tintColor = .darkGray
        return btn
    }
}
