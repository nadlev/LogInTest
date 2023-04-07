//
//  ForgottenPasswordController.swift
//  LoginTesting
//
//  Created by Надежда Левицкая on 4/4/23.
//

import UIKit

class ForgottenPasswordViewController: UIViewController {
    
    private let forgotPasswordHeader = RegisterHeader(title: "Reset your password")
    
    private let emailField = CustomField(fieldType: .email)
    private let resetPasswordButton = CustomingButton(title: "Submit", fontSize: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func setUpConstraints() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubviews(forgotPasswordHeader, emailField, resetPasswordButton)
        
        forgotPasswordHeader.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        resetPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.forgotPasswordHeader.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30),
            self.forgotPasswordHeader.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.forgotPasswordHeader.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.forgotPasswordHeader.heightAnchor.constraint(equalToConstant: 230),
            
            self.emailField.topAnchor.constraint(equalTo: forgotPasswordHeader.bottomAnchor, constant: 11),
            self.emailField.centerXAnchor.constraint(equalTo: forgotPasswordHeader.centerXAnchor),
            self.emailField.heightAnchor.constraint(equalToConstant: 55),
            self.emailField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            
            self.resetPasswordButton.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 22),
            self.resetPasswordButton.centerXAnchor.constraint(equalTo: forgotPasswordHeader.centerXAnchor),
            self.resetPasswordButton.heightAnchor.constraint(equalToConstant: 55),
            self.resetPasswordButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85)
        ])
    }
    
    @objc private func didClickForgotPassword() {
        let email = self.emailField.text ?? ""
        
        if !CheckCorrectness.isCorrectEmail(for: email) {
            AlertInfo.invalidEmail(on: self)
            return
        }
        AuthenManager.shared.forgottenPassword(with: email) { [weak self] error in
            guard let self = self else {
                return
            }
            if let error = error {
                AlertInfo.errorResettingPassword(on: self, with: error)
                return
            }
            AlertInfo.resettingPassword(on: self)
        }
    }
}
