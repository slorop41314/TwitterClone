//
//  LoginViewController.swift
//  twitterclone
//
//  Created by Albert Stanley on 14/06/20.
//  Copyright © 2020 slorop. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Properties
    private let logoImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "TwitterLogo")
        return iv
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = InputView().inputContainerView(withImage: UIImage(systemName: "envelope")!, textField: emailTextField)
        return view
    }()
    
    private lazy var emailTextField: UITextField = {
        let tf = InputView().textField(placeholder: "Email")
        return tf
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = InputView().inputContainerView(withImage: UIImage(systemName: "lock")!, textField: passTextField)
        return view
    }()
    
    private lazy var passTextField: UITextField = {
        let tf = InputView().textField(placeholder: "Password", secureText: true)
        return tf
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    private let registratioButton: UIButton = {
        let button = UIButton()
        button.setTitle("Dont have an account? Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Selector
    
    @objc func handleSignUp() {
        let vc = RegisterViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // MARK: - Helper
    
    func configureUI() {
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(logoImage)
        logoImage.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 0)
        logoImage.setDimensions(width: 150, height: 150)
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView])
        stack.axis = .vertical
        stack.spacing = 8
        view.addSubview(stack)
        stack.anchor(top: logoImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(loginButton)
        loginButton.anchor(top: stack.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(registratioButton)
        registratioButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor,paddingBottom: 10)
    }
}
