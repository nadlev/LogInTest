//
//  CustomField.swift
//  LoginTesting
//
//  Created by Надежда Левицкая on 4/4/23.
//

import UIKit

class CustomField: UITextField {
    
    enum CustomTextField {
        case username
        case email
        case password
        case phone
    }
    
    private let authFieldType: CustomTextField
    
    init(fieldType: CustomTextField) {
        self.authFieldType = fieldType
        super.init(frame: .zero)
        
        self.backgroundColor = .secondarySystemBackground
        self.layer.cornerRadius = 10
        
        self.returnKeyType = .done
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        
        self.leftViewMode = .always
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.size.height))
        
        switch fieldType {
        case .username:
            self.placeholder = "UserName"
        case .email:
            self.placeholder = "Email Address"
            self.keyboardType = .emailAddress
        case .password:
            self.placeholder = "Password"
            self.isSecureTextEntry = true
        case .phone:
            self.placeholder = "Phone Number"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
