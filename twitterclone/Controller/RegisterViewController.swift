//
//  RegisterViewController.swift
//  twitterclone
//
//  Created by Albert Stanley on 14/06/20.
//  Copyright © 2020 slorop. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    // MARK: - Properties
    private let profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleChoosePhoto), for: .touchUpInside)
        return button
    }()
    
    private let imagePicker = UIImagePickerController()
    
    private var profileImage: UIImage?
    
    private lazy var emailContainerView: UIView = {
        let view = InputView().inputContainerView(withImage: UIImage(systemName: "envelope")!, textField: emailTextField)
        return view
    }()
    
    private lazy var emailTextField: UITextField = {
        let tf = InputView().textField(placeholder: "Email")
        return tf
    }()
    
    private lazy var fullNameContainerView: UIView = {
        let view = InputView().inputContainerView(withImage: UIImage(systemName: "person")!, textField: fullnameTextField)
        return view
    }()
    
    private lazy var fullnameTextField: UITextField = {
        let tf = InputView().textField(placeholder: "Full Name")
        return tf
    }()
    private lazy var usernameContainerView: UIView = {
        let view = InputView().inputContainerView(withImage: UIImage(systemName: "person")!, textField: usernameTextField)
        return view
    }()
    
    private lazy var usernameTextField: UITextField = {
        let tf = InputView().textField(placeholder: "Username")
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
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Already have an account? Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    // MARK: - Selector
    
    @objc func handleSignIn() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleSignUp() {
        guard let userImage = profileImage else {
            print("Choose user image")
            return
        }
        guard let email = emailTextField.text else { return }
        guard let password = passTextField.text else { return }
        guard let username = usernameTextField.text else { return }
        guard let fullname = fullnameTextField.text else { return }
        
        guard let imageData = userImage.jpegData(compressionQuality: 0.3) else { return }
        let filename = NSUUID().uuidString
        let storageRef = STORAGE_PROFILE_IMAGES.child(filename)
        
        storageRef.putData(imageData, metadata: nil) { (meta, err) in
            storageRef.downloadURL { (url, err) in
                guard let profileImageUrl = url?.absoluteString else { return }
                Auth.auth().createUser(withEmail: email, password: password) { (res, err) in
                    if let error = err {
                        print(error.localizedDescription)
                        return
                    }
                    guard let uid = res?.user.uid else { return }
                    let values = ["username" : username,"fullname" : fullname, "email" : email, "profileImageUrl" : profileImageUrl]
                    REF_USERS.child(uid).updateChildValues(values) { (err, dbref) in
                        print("Successfully updated child")
                    }
                }
            }
        }
        
    }
    
    @objc func handleChoosePhoto() {
        present(imagePicker, animated: true, completion: nil)
    }
    // MARK: - Helper
    
    func configureUI() {
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.isHidden = true
                view.addSubview(profileButton)
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        profileButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 0)
        profileButton.setDimensions(width: 150, height: 150)
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, fullNameContainerView, usernameContainerView])
        stack.axis = .vertical
        stack.spacing = 8
        view.addSubview(stack)
        stack.anchor(top: profileButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(registerButton)
        registerButton.anchor(top: stack.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(signInButton)
        signInButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor,right: view.rightAnchor,paddingBottom: 10)
    }
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else {return }
        self.profileImage = profileImage
        profileButton.layer.cornerRadius = 150/2
        profileButton.layer.masksToBounds = true
        profileButton.layer.borderWidth = 3
        profileButton.layer.borderColor = UIColor.white.cgColor
        self.profileButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        dismiss(animated: true, completion: nil)
    }
}
