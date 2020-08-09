//
//  LoginViewController.swift
//  PhotoOrganiser
//
//  Created by Sani on 8/8/20.
//  Copyright © 2020 Sani. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    private let loginView: LoginView
    private var redView: UIView?
    private var textField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view = loginView
        loginView.setupViewConstraints()
    }

    init() {
        self.loginView = LoginView()
        super.init(nibName: nil, bundle: nil)
        loginView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoginViewController: LoginViewDelegate {
    func fieldDidPressReturn(field: LoginFields) {
        switch field {
        case .email:
            loginView.selectField(field: .password)
        case .password:
            loginView.endEditing(true)
        default:
            break
        }
    }
    
    func actionButtonPressed() {
        // Make call to service
    }
    
    
}
