//
//  RegisterController.swift
//  LoginTesting
//
//  Created by Надежда Левицкая on 4/4/23.
//

import UIKit

class RegisterViewController: UIViewController {
    
    // uiobjects properties
    
    private let singUpHeader = RegisterHeader(title: "Create your account")
    private let usernameField = CustomField(fieldType: .username)
    private let emailField = CustomField(fieldType: .email)
    private let phoneField = CustomField(fieldType: .phone)
    private let passwordField = CustomField(fieldType: .password)
    
    private let singUpButton = CustomingButton(title: "Sing up", fontSize: .large)
    private let singInButton = CustomingButton(title: "Already have an account? Sing in!", fontSize: .large)
    private let termsAndConditionsField: UITextView = {
        let tac = UITextView()
        tac.text = "By creating an account, you agree to our Terms & Conditions and you acknowledge that you have read our Privacy Policy."
        tac.backgroundColor = .clear
        tac.textColor = .label
        tac.isSelectable = true
        tac.isEditable = false
        tac.isScrollEnabled = false
        return tac
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpConstraints()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
        self.singInButton.addTarget(self, action: #selector(didClickSingIn), for: .touchUpInside)
        self.singUpButton.addTarget(self, action: #selector(didClickSingUp), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setUpConstraints() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubviews(singUpHeader, usernameField, emailField, phoneField, passwordField, singUpButton, singInButton, termsAndConditionsField)
        
        NSLayoutConstraint.activate([
            self.singUpHeader.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.singUpHeader.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.singUpHeader.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.singUpHeader.heightAnchor.constraint(equalToConstant: 222),
            
            self.usernameField.topAnchor.constraint(equalTo: singUpHeader.bottomAnchor, constant: 12),
            self.usernameField.centerXAnchor.constraint(equalTo: singUpHeader.centerXAnchor),
            self.usernameField.heightAnchor.constraint(equalToConstant: 55),
            self.usernameField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.emailField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 22),
            self.emailField.centerXAnchor.constraint(equalTo: singUpHeader.centerXAnchor),
            self.emailField.heightAnchor.constraint(equalToConstant: 55),
            self.emailField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            
            self.phoneField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 22),
            self.phoneField.centerXAnchor.constraint(equalTo: singUpHeader.centerXAnchor),
            self.phoneField.heightAnchor.constraint(equalToConstant: 55),
            self.phoneField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.passwordField.topAnchor.constraint(equalTo: phoneField.bottomAnchor, constant: 22),
            self.passwordField.centerXAnchor.constraint(equalTo: singUpHeader.centerXAnchor),
            self.passwordField.heightAnchor.constraint(equalToConstant: 55),
            self.passwordField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.singUpButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 22),
            self.singUpButton.centerXAnchor.constraint(equalTo: singUpHeader.centerXAnchor),
            self.singUpButton.heightAnchor.constraint(equalToConstant: 55),
            self.singUpButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.termsAndConditionsField.topAnchor.constraint(equalTo: singUpButton.bottomAnchor, constant: 6),
            self.termsAndConditionsField.centerXAnchor.constraint(equalTo: singUpHeader.centerXAnchor),
            self.termsAndConditionsField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.singInButton.topAnchor.constraint(equalTo: termsAndConditionsField.bottomAnchor, constant: 11),
            self.singInButton.centerXAnchor.constraint(equalTo: singUpHeader.centerXAnchor),
            self.singInButton.heightAnchor.constraint(equalToConstant: 44),
            self.singInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
        ])
    }
    
    @objc func didClickSingUp() {
        
        let registerNewUser = RegisterUser(fullName: self.usernameField.text ?? "", email: self.emailField.text ?? "", password: self.passwordField.text ?? "", phoneNumber: Int(self.phoneField.text!) ?? 0)
        
        if !CheckCorrectness.isCorrectUserName(for: registerNewUser.fullName) {
            AlertInfo.invalidUsername(on: self)
            return
        }
        
        if !CheckCorrectness.isCorrectEmail(for: registerNewUser.email) {
            AlertInfo.invalidEmail(on: self)
            return
        }
        
        if !CheckCorrectness.isCorrectPhoneNumber(for: String( registerNewUser.phoneNumber)) {
            AlertInfo.invalidPhoneNumber(on: self)
            return
        }
        
        if !CheckCorrectness.isCorrectPassword(for: registerNewUser.password) {
            AlertInfo.invalidPasswordAlert(on: self)
            return
        }
        
        AuthenManager.shared.registerUser(with: registerNewUser) { [weak self] isRegistered, error in
            guard let self = self else {
                return
            }
            if let error = error {
                AlertInfo.registerError(on: self, with: error)
                return
            }
            
            if isRegistered {
                self.navigationController?.popToRootViewController(animated: true)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    AlertInfo.registeredSuccessfullyAlert(on: self)
                }
            } else {
                AlertInfo.registerUnknownError(on: self)
            }
        }
    }
    
    @objc private func didClickSingIn() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
