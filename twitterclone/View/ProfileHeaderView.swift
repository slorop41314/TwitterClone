//
//  ProfileHeaderView.swift
//  twitterclone
//
//  Created by Albert Stanley on 29/06/20.
//  Copyright © 2020 slorop. All rights reserved.
//

import UIKit

class ProfileHeaderView: UICollectionReusableView {
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
