//
//  UploadTweetViewController.swift
//  twitterclone
//
//  Created by Albert Stanley on 27/06/20.
//  Copyright © 2020 slorop. All rights reserved.
//

import UIKit

class UploadTweetViewController: UIViewController {
    
    // MARK: - Properties
    
    let user: User
    
    private let postField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "What's happening"
        return tf
    }()
    
    private let profileImage: UIImageView = {
        let img = ProfileImage().medium()
        return img
    }()
    
    private lazy var tweetButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .twitterBlue
        btn.setTitle("Tweet", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
        btn.layer.cornerRadius = 32/2
        btn.addTarget(self, action: #selector(handlePostNewTweet), for: .touchUpInside)
        return btn
    }()

    // MARK: - Lifecycle
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle : nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        // Do any additional setup after loading the view.
    }
     // MARK: - API
    
    
    // MARK: - Selector
    
    @objc func handleCancelTweet() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handlePostNewTweet() {
        guard let caption = postField.text else { return }
        TweetService.shared.uploadTweet(caption: caption) { (err, dbref) in
            if let error = err {
                print(error.localizedDescription)
                return
            }
            print("Success tweet")
            self.dismiss(animated: true, completion: nil)
        }
        
    }

    // MARK: - Helper
    
    func configureUI() {
        view.backgroundColor = .white
        configureNavigationBarItem()
        configureProfile()
        configureTextField()
    }
    
    func configureNavigationBarItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancelTweet))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: tweetButton)
    }
    
    func configureTextField() {
        view.addSubview(postField)
        postField.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: profileImage.rightAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10)
    }
    
    func configureProfile() {
        profileImage.sd_setImage(with: user.profileImageUrl, completed: nil)
        view.addSubview(profileImage)
        profileImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,paddingTop: 10, paddingLeft: 10)
    }

}
