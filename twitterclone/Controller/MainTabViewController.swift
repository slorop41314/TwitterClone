//
//  MainTabViewController.swift
//  twitterclone
//
//  Created by Albert Stanley on 12/06/20.
//  Copyright © 2020 slorop. All rights reserved.
//

import UIKit
import Firebase

class MainTabViewController: UITabBarController {

    // MARK: - Properties
    
    var user: User? {
        didSet {
            guard let nav = viewControllers?[0] as? UINavigationController else { return }
            guard let feed = nav.viewControllers.first as? FeedViewController else { return }
            feed.user = user
        }
    }
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.addTarget(nil, action: #selector(onTapNewTweet), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkUserAuthAndConfigure()
    }
    
    // MARK: - API
    
    func fetchUserData() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        UserService.shared.getUserData(uid: uid) { (user) in
            self.user = user
        }
    }
    
    func checkUserAuthAndConfigure() {
        if (Auth.auth().currentUser == nil){
            DispatchQueue.main.async {
                let nav = LoginViewController()
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            }
        }else {
            configureViewControllers()
            configureUI()
            fetchUserData()
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        }catch let error {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Selector
    
    @objc func onTapNewTweet() {
        guard let user = user else { return }
        let vc = UploadTweetViewController(user: user)
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated:  true)
    }
    
    // MARK: - Helper
    
    func configureUI() {
        view.addSubview(actionButton)
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
        actionButton.layer.cornerRadius = 56/2
    }
    func configureViewControllers() {
        let feed = FeedViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let feedNav = templateNavigationController(tabImage: UIImage(systemName: "house"), rootController: feed)
        let explore = ExploreViewController()
        let exploreNav = templateNavigationController(tabImage: UIImage(systemName: "magnifyingglass"), rootController: explore)
        
        let conversation = ConversationViewController()
        let conversationNav = templateNavigationController(tabImage: UIImage(systemName: "message"), rootController: conversation)
        
        let notifications = NotificationViewController()
        let notificationNav = templateNavigationController(tabImage: UIImage(systemName: "bell"), rootController: notifications)
        
        viewControllers = [feedNav, exploreNav, conversationNav, notificationNav]
    }
    
    func templateNavigationController(tabImage : UIImage?, rootController : UIViewController) -> UIViewController {
        let nav = UINavigationController(rootViewController: rootController)
        nav.tabBarItem.image = tabImage
        nav.navigationBar.tintColor = .white
        nav.navigationBar.isTranslucent = false
        return nav
    }


}
