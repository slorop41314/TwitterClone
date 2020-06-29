//
//  TweetCell.swift
//  twitterclone
//
//  Created by Albert Stanley on 28/06/20.
//  Copyright © 2020 slorop. All rights reserved.
//

import UIKit

protocol TweetCellDelegate: class {
    func handleProfileImageTapped()
}
class TweetCell : UICollectionViewCell {
    
    // MARK: - Properties
    
    weak var delegate: TweetCellDelegate?
    var tweet: Tweet? {
        didSet {
            configure()
        }
    }
    
    private lazy var profileImageView: UIImageView = {
        let img = ProfileImage().medium()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapProfileImage))
        img.addGestureRecognizer(tap)
        img.isUserInteractionEnabled = true
        return img
    }()
    
    private var captionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private var infoLabel = UILabel()
    
    private lazy var commentButton: UIButton = {
        let btn = Button().smallButtonWithImage(icon: UIImage(systemName: "bubble.right")!)
        btn.addTarget(self, action: #selector(handleTapComment), for: .touchUpInside)
        return btn
    }()
    private lazy var retweetButton: UIButton = {
        let btn = Button().smallButtonWithImage(icon: UIImage(named: "retweet")!)
        btn.addTarget(self, action: #selector(handleTapRetweet), for: .touchUpInside)
        return btn
    }()
    private lazy var likeButton: UIButton = {
        let btn = Button().smallButtonWithImage(icon: UIImage(systemName: "heart")!)
        btn.addTarget(self, action: #selector(handleTapLike), for: .touchUpInside)
        return btn
    }()
    private lazy var shareButton: UIButton = {
        let btn = Button().smallButtonWithImage(icon: UIImage(systemName: "paperplane")!)
        btn.addTarget(self, action: #selector(handleTapShare), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor,paddingTop: 12, paddingLeft: 12)
        
        
        let stack = UIStackView(arrangedSubviews: [infoLabel, captionLabel])
        addSubview(stack)
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 4
        stack.anchor(top: topAnchor, left: profileImageView.rightAnchor, right: rightAnchor,paddingTop : 12, paddingLeft: 12, paddingRight : 12)
        infoLabel.text = "Test"
        captionLabel.text = "Test"
        
        let buttonStack = UIStackView(arrangedSubviews: [commentButton, retweetButton, likeButton, shareButton])
        addSubview(buttonStack)
        buttonStack.distribution = .fillEqually
        buttonStack.axis = .horizontal
        buttonStack.spacing = 60
        buttonStack.anchor(left: profileImageView.rightAnchor,bottom: bottomAnchor,paddingLeft: 12, paddingBottom: 12)
        
        let underlineView = UIView()
        underlineView.backgroundColor = .lightGray
        addSubview(underlineView)
        underlineView.anchor( left:leftAnchor,bottom: bottomAnchor, right: rightAnchor, height: 1)
        
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func handleTapComment() {
         print("Comment")
    }
    
    @objc func handleTapRetweet() {
         print("Retweeet")
    }
    
    @objc func handleTapLike() {
         print("Liked")
    }
    
    @objc func handleTapShare() {
        print("Share")
    }
    
    @objc func handleTapProfileImage() {
        self.delegate?.handleProfileImageTapped()
    }
    
    // MARK: - Configure
    func configure() {
        guard let tweet = tweet else { return }
        let tweetViewModel = TweetViewModel(tweet: tweet)
        profileImageView.sd_setImage(with: tweetViewModel.profileImageUrl, completed: nil)
        infoLabel.attributedText = tweetViewModel.userInfoText
        captionLabel.text = tweet.caption
        
    }
}


