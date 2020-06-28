//
//  FeedViewController.swift
//  twitterclone
//
//  Created by Albert Stanley on 12/06/20.
//  Copyright © 2020 slorop. All rights reserved.
//

import UIKit
import SDWebImage

private let reuseIdentifier = "TweetCell"
class FeedViewController: UICollectionViewController {

    // MARK: - Properties
    var user: User?{
        didSet{ configureLeftBarItem() }
    }
    
    private var tweets = [Tweet]() {
        didSet {
            self.collectionView.reloadData()
        }
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
            self.tweets = tweets
        }
    }
    
    // MARK: - Helper
    
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Feed"
        collectionView.register(TweetCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .white
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

// MARK: - CollectionView DataSource

extension FeedViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TweetCell
        let tweet = tweets[indexPath.row]
        cell.tweet = tweet
//        cell.infoLabel.text = tweet.username
        return cell
    }
}

// MARK: - CollectionViewFlowDelegate

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
}
