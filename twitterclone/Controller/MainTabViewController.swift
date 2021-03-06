//
//  MainTabViewController.swift
//  twitterclone
//
//  Created by Albert Stanley on 12/06/20.
//  Copyright © 2020 slorop. All rights reserved.
//

import UIKit

class MainTabViewController: UITabBarController {

    // MARK: - Properties
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(systemName: "message"), for: .normal)
        
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewControllers()
        configureUI()
    }
    
    // MARK: - Helper
    
    func configureUI() {
        view.addSubview(actionButton)
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
        actionButton.layer.cornerRadius = 56/2
    }
    func configureViewControllers() {
        let feed = FeedViewController()
        let feedNav = templateNavigationController(tabImage: UIImage(systemName: "house"), rootController: feed)
        let explore = ExploreViewController()
        let exploreNav = templateNavigationController(tabImage: UIImage(systemName: "search"), rootController: explore)
        
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
        return nav
    }


}
