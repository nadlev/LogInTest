//
//  ViewsExtension.swift
//  LoginTesting
//
//  Created by Надежда Левицкая on 4/5/23.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}
