//
//  LoginController.swift
//  LoginTesting
//
//  Created by Надежда Левицкая on 4/4/23.
//

import UIKit

class LogInViewController: UIViewController {
    
    // uiobjects properties
    
    private let registerHeader = RegisterHeader(title: "Sing in")
    
    private let emailField = CustomField(fieldType: .email)
    private let passwordField = CustomField(fieldType: .password)
    
    private let singInButton = CustomingButton(title: "Sing in", fontSize: .large)
    
    private let newUserButton = CustomingButton(title: "New here? Click to create an account :)", fontSize: .medium)
    
    private let forgottenPassword = CustomingButton(title: "I forgot my password", fontSize: .small)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.setUpConstraints()
        
        self.singInButton.addTarget(self, action: #selector(singInButtonClicked), for: .touchUpInside)
        self.newUserButton.addTarget(self, action: #selector(newUserButtonClicked), for: .touchUpInside)
        self.forgottenPassword.addTarget(self, action: #selector(forgotPasswordButtonClicked), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    private func setUpConstraints() {
        
        self.view.addSubviews(registerHeader, emailField, passwordField, singInButton, newUserButton, forgottenPassword)
        
        self.view.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            self.registerHeader.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.registerHeader.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.registerHeader.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.registerHeader.heightAnchor.constraint(equalToConstant: 200),
            
            self.emailField.topAnchor.constraint(equalTo: registerHeader.bottomAnchor, constant: 12),
            self.emailField.centerXAnchor.constraint(equalTo: registerHeader.centerXAnchor),
            self.emailField.heightAnchor.constraint(equalToConstant: 50),
            self.emailField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 12),
            self.passwordField.centerXAnchor.constraint(equalTo: registerHeader.centerXAnchor),
            self.passwordField.heightAnchor.constraint(equalToConstant: 55),
            self.passwordField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.singInButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 12),
            self.singInButton.centerXAnchor.constraint(equalTo: registerHeader.centerXAnchor),
            self.singInButton.heightAnchor.constraint(equalToConstant: 55),
            self.singInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.newUserButton.topAnchor.constraint(equalTo: singInButton.bottomAnchor, constant: 11),
            self.newUserButton.centerXAnchor.constraint(equalTo: registerHeader.centerXAnchor),
            self.newUserButton.heightAnchor.constraint(equalToConstant: 44),
            self.newUserButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.forgottenPassword.topAnchor.constraint(
                equalTo: newUserButton.bottomAnchor, constant: 6),
            self.forgottenPassword.centerXAnchor.constraint(equalTo: registerHeader.centerXAnchor),
            self.forgottenPassword.heightAnchor.constraint(equalToConstant: 44),
            self.forgottenPassword.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85)
        ])
        
        registerHeader.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        singInButton.translatesAutoresizingMaskIntoConstraints = false
        newUserButton.translatesAutoresizingMaskIntoConstraints = false
        forgottenPassword.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    @objc private func singInButtonClicked() {
        let login = LogInUser(email: self.emailField.text ?? "", password: self.passwordField.text ?? "")
        if !CheckCorrectness.isCorrectEmail(for: login.email) {
            AlertInfo.invalidEmail(on: self)
            return
        }
        if !CheckCorrectness.isCorrectPassword(for: login.password) {
            AlertInfo.invalidPasswordAlert(on: self)
            return
        }
        
        AuthenManager.shared.singIn(with: login) { [weak self] error in
            guard let self = self else {
                return
            }
            
            if let error = error {
                AlertInfo.singInAlert(on: self, with: error)
                return
            }
            
            if let sd = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sd.checkAuthen()
            } else {
                AlertInfo.singInOtherAlert(on: self)
            }
        }
    }
    
    @objc private func newUserButtonClicked() {
        let vc = RegisterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func forgotPasswordButtonClicked() {
        let vc = ForgottenPasswordViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

