//
//  FeedViewController.swift
//  twitterclone
//
//  Created by Albert Stanley on 12/06/20.
//  Copyright © 2020 slorop. All rights reserved.
//

import UIKit
import SDWebImage
class FeedViewController: UIViewController {

    // MARK: - Properties
    var user: User?{
        didSet{ configureLeftBarItem() }
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTweetData()
        configureUI()
    }
    
    // MARK: - API
    func fetchTweetData() {
        TweetService.shared.fetchTweets { (tweets) in
            print(tweets)
        }
    }
    
    // MARK: - Helper
    
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Feed"
    }
    
    func configureLeftBarItem() {
        
        guard let user = user else { return }
        let profileImage = UIImageView()
        profileImage.setDimensions(width: 32, height: 32)
        profileImage.layer.cornerRadius = 32/2
        profileImage.layer.masksToBounds = true
        
        profileImage.sd_setImage(with: user.profileImageUrl, completed: nil)
        view.addSubview(profileImage)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImage)
    }

}
