//
//  HomeController.swift
//  LoginTesting
//
//  Created by Надежда Левицкая on 4/4/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupConstraints()
    }
    
    private func setupConstraints() {
        self.view.backgroundColor = .systemBackground
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Exit", style: .done, target: self, action: #selector(didTapExit))
    }
    
    @objc private func didTapExit() {
        AuthenManager.shared.singOut { [weak self] error in
            guard let self = self else {
                return
            }
            if let error = error {
                AlertInfo.logOutAlert(on: self, with: error)
                return
            }
        }
        
        if let sd = self.view.window?.windowScene?.delegate as? SceneDelegate {
            sd.checkAuthen()
        }
    }
}
