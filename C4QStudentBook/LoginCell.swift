//
//  LoginCell.swift
//  C4QStudentBook
//
//  Created by Annie Tung on 11/18/16.
//  Copyright © 2016 Jason Wang. All rights reserved.
//

import UIKit

class LoginCell: BaseCell, UITextFieldDelegate {
    
    static let identifier = "loginCellID"
    
    lazy var emailTextField: UITextField = {
        let email = UITextField()
        email.placeholder = "Email address"
        email.borderStyle = .roundedRect
        email.translatesAutoresizingMaskIntoConstraints = false
        return email
    }()
    
    let passwordTextField: UITextField = {
        let password = UITextField()
        password.placeholder = "Password"
        password.isSecureTextEntry = true
        password.borderStyle = .roundedRect
        password.translatesAutoresizingMaskIntoConstraints = false
        return password
    }()
    
    lazy var loginButton: UIButton = {
        let login = UIButton(type: .system)
        login.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        login.backgroundColor = .orange
        login.setTitle("Login", for: .normal)
        login.setTitleColor(.white, for: .normal)
        login.translatesAutoresizingMaskIntoConstraints = false
        return login
    }()
    
    func loginButtonTapped() {
        print("See if this works")
    }
    
    
    override func setupCell() {
        super.setupCell()
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        backgroundColor = .white
        emailConstraint()
        passwordConstraint()
        loginButtonConstraint()
    }
    
    func emailConstraint() {
        emailTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        emailTextField.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func passwordConstraint() {
        passwordTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func loginButtonConstraint() {
        loginButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        loginButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        frame = CGRect(x: frame.origin.x, y: frame.origin.y - 20, width: frame.size.width, height: frame.size.height)
    }
}

