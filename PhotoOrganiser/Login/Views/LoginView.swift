//
//  LoginView.swift
//  PhotoOrganiser
//
//  Created by Sani on 8/8/20.
//  Copyright © 2020 Sani. All rights reserved.
//

import UIKit

enum LoginFields {
    case email
    case password
    case none
}

protocol LoginViewDelegate {
    func fieldDidPressReturn(field: LoginFields)
    func actionButtonPressed()
}

class LoginView: UIView {
    var delegate: LoginViewDelegate?
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .emailAddress
        textField.borderStyle = .line
        textField.backgroundColor = .yellow
        return textField
    } ()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .line
        textField.isSecureTextEntry = true
        textField.backgroundColor = .red
        return textField
    } ()
    
    private let actionButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitle("Will login when tapped", for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .purple
        return button
    } ()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {

        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(emailTextField)
        emailTextField.delegate = self
        
        self.addSubview(passwordTextField)
        passwordTextField.delegate = self
        
        self.addSubview(actionButton)
        actionButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)

        self.backgroundColor = .white
    }
    
    public func setupViewConstraints() {
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 200),
            emailTextField.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 20),
            emailTextField.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 10),
            passwordTextField.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 20),
            passwordTextField.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 10),
            actionButton.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 20),
            actionButton.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -20),
            actionButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    public func selectField(field: LoginFields) {
        switch field {
        case .email:
            emailTextField.becomeFirstResponder()
        case .password:
            passwordTextField.becomeFirstResponder()
        default: break
        }
    }
    
    @objc func buttonPressed() {
        self.endEditing(true)
    }
}

extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let delegate = delegate else {
            return true
        }
        
        var currentField = LoginFields.none
        if (textField == emailTextField) {
            currentField = .email
        } else if (textField == passwordTextField) {
            currentField = .password
        }

        delegate.fieldDidPressReturn(field: currentField)
        
        return true
    }
}
