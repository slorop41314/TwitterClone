//
//  ProfileTabViewCell.swift
//  twitterclone
//
//  Created by Albert Stanley on 30/06/20.
//  Copyright © 2020 slorop. All rights reserved.
//

import UIKit

class ProfileTabViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Tab Title"
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            titleLabel.font = isSelected ? UIFont.boldSystemFont(ofSize: 16) : UIFont.systemFont(ofSize: 14)
            titleLabel.textColor = isSelected ? .twitterBlue : .gray
        }
    }
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame : frame)
        addSubview(titleLabel)
        titleLabel.centerX(inView: self)
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

