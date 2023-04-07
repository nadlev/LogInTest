//
//  CustomButton.swift
//  LoginTesting
//
//  Created by Надежда Левицкая on 4/4/23.
//

import SwiftUI
import UIKit

class CustomingButton: UIButton {
    
    var hasBackgroundColor: Bool = false
    
    enum FontSize {
        case small
        case medium
        case large
    }
    
    init(title: String, fontSize: FontSize) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        
        self.backgroundColor = hasBackgroundColor ? .systemMint : .clear
        let titleColor: UIColor = hasBackgroundColor ? .white : .systemTeal
        self.setTitleColor(titleColor, for: .normal)
        self.setTitleColor(.darkGray, for: .highlighted)
        
        switch fontSize {
        case .large:
            self.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        case .small:
            self.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        case .medium:
            self.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
