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
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.addSubview(backButton)
        backButton.anchor(top : view.topAnchor, left : view.leftAnchor, paddingTop: 42, paddingLeft: 16)
        backButton.setDimensions(width: 30, height: 30)
        view.backgroundColor = .twitterBlue
        return view
    }()
    
    private lazy var backButton: UIView = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "baseline_arrow_back_white_24dp"), for: .normal)
        btn.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        return btn
    }()
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.backgroundColor = .gray
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 4
        return iv
    }()
    
    private lazy var editProfileFollowButton: UIView = {
        let btn = UIButton()
        btn.setTitle("Loading", for: .normal)
        btn.setTitleColor(.twitterBlue, for: .normal)
        btn.layer.borderColor = UIColor.twitterBlue.cgColor
        btn.layer.borderWidth = 1
        btn.addTarget(self, action: #selector(handleEditFollow), for: .touchUpInside)
        return btn
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Your name here..."
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "@your_username"
        label.textColor = .gray
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.text = "Your bio here..."
        label.numberOfLines = 3
        return label
    }()
    // MARK: - Selectors
    
    @objc func handleBackButton() {
        
    }
    
    @objc func handleEditFollow() {
        
    }
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(containerView)
        containerView.anchor(top : topAnchor, left: leftAnchor, right: rightAnchor, height : 108)
        
        addSubview(profileImageView)
        profileImageView.anchor(top: containerView.bottomAnchor, left: leftAnchor, paddingTop: -24, paddingLeft: 16)
        profileImageView.setDimensions(width: 80, height: 80)
        profileImageView.layer.cornerRadius = 80/2
        
        addSubview(editProfileFollowButton)
        editProfileFollowButton.anchor(top: containerView.bottomAnchor, right: rightAnchor,paddingTop: 16, paddingRight: 16)
        editProfileFollowButton.setDimensions(width: 100, height: 32)
        editProfileFollowButton.layer.cornerRadius = 32/2
        
        let stack = UIStackView(arrangedSubviews: [nameLabel, usernameLabel, bioLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 4
        
        addSubview(stack)
        stack.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 16)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
