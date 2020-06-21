//
//  InputUtils.swift
//  twitterclone
//
//  Created by Albert Stanley on 20/06/20.
//  Copyright © 2020 slorop. All rights reserved.
//

import Foundation
import UIKit

class InputView {
    func inputContainerView(withImage image: UIImage, textField : UITextField) -> UIView {
        let view = UIView()
        let iv = UIImageView()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        iv.image = image
        iv.tintColor = .white
        view.addSubview(iv)
        
        iv.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, paddingLeft: 8, paddingBottom: 8)
        iv.setDimensions(width: 24, height: 24)
        
        view.addSubview(textField)
        textField.anchor(left: iv.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor,  paddingLeft: 8, paddingBottom: 8)
        
        let divider = UIView()
        divider.backgroundColor = .white
        view.addSubview(divider)
        divider.anchor(left: iv.leftAnchor,bottom: view.bottomAnchor, right: textField.rightAnchor, height: 0.75)
        return view
    }
    
    func textField(placeholder: String, secureText: Bool = false)-> UITextField {
        let tf = UITextField()
        tf.placeholder = placeholder
        tf.textColor = .white
        tf.isSecureTextEntry = secureText
        tf.attributedPlaceholder = NSAttributedString(string: placeholder,attributes:
            [NSAttributedString.Key.foregroundColor : UIColor.white]
        )
        return tf
    }
}
