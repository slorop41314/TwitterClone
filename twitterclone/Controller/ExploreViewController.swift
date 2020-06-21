//
//  ExploreViewController.swift
//  twitterclone
//
//  Created by Albert Stanley on 12/06/20.
//  Copyright © 2020 slorop. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController {

    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helper
    
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Explore"
    }


}
