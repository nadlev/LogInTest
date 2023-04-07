//
//  RegisterHeader.swift
//  LoginTesting
//
//  Created by Надежда Левицкая on 4/4/23.
//

import UIKit

class RegisterHeader: UIView {
    
    //UI objects properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .center
        label.text = "Error"
        return label
    }()
    
    private let logoView: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logoImage")
        logo.layer.cornerRadius = 12
        logo.layer.masksToBounds = true
        logo.contentMode = .scaleAspectFill
        return logo
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        self.titleLabel.text = title
        
        setConstraintsUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraintsUI() {
        addSubviews(titleLabel, logoView)
        
        NSLayoutConstraint.activate([
            self.logoView.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            self.logoView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.logoView.widthAnchor.constraint(equalToConstant: 90),
            self.logoView.heightAnchor.constraint(equalTo: logoView.widthAnchor),
            
            self.titleLabel.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 20),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.trailingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
