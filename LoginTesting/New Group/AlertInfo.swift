//
//  AlertInfo.swift
//  LoginTesting
//
//  Created by Надежда Левицкая on 4/4/23.
//

import Foundation
import UIKit
import SwiftUI

class AlertInfo {
    private static func showAlert(on vc: UIViewController, title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        vc.present(alert, animated: true)
    }
    
    public static func invalidPasswordAlert(on vc: UIViewController) {
        self.showAlert(on: vc, title: "Invalid password", message: "Please enter a correct password!")
    }
    
    public static func invalidEmail(on vc: UIViewController) {
        self.showAlert(on: vc, title: "Invalid email address", message: "Please enter a correct email address")
    }
    
    public static func invalidUsername(on vc: UIViewController) {
        self.showAlert(on: vc, title: "Invalid username", message: "Please enter a correct username")
    }
    
    public static func invalidPhoneNumber(on vc: UIViewController) {
        self.showAlert(on: vc, title: "Invalid phone number", message: "Please enter a correct phone number ")
    }
}

extension AlertInfo {
    public static func registerError(on vc: UIViewController, with error: Error) {
        self.showAlert(on: vc, title: "Registration error", message: "\(error.localizedDescription)")
    }
    
    public static func registerUnknownError(on vc: UIViewController) {
        self.showAlert(on: vc, title: "Registration error", message: nil)
    }
    
    public static func singInAlert(on vc: UIViewController, with error: Error) {
        self.showAlert(on: vc, title: "Sing in error", message: "\(error.localizedDescription)")
    }
    
    public static func singInOtherAlert(on vc: UIViewController) {
        self.showAlert(on: vc, title: "Other singin error", message: nil)
    }
    
    public static func logOutAlert(on vc: UIViewController, with error: Error) {
        self.showAlert(on: vc, title: "Log out error", message: "\(error.localizedDescription)")
    }
    
    public static func registeredSuccessfullyAlert(on vc: UIViewController) {
        self.showAlert(on: vc, title: "Registered successfully!", message: nil)
    }
}

extension AlertInfo {
    
    public static func resettingPassword(on vc: UIViewController) {
        self.showAlert(on: vc, title: "Password reset sent", message: nil)
    }
    
    public static func errorResettingPassword(on vc: UIViewController, with error: Error) {
        self.showAlert(on: vc, title: "Error sending resetting password", message: "\(error.localizedDescription)")
    }
    
    public static func errorFindingUser(on vc: UIViewController, with error: Error) {
        self.showAlert(on: vc, title: "Error finding user", message: "\(error.localizedDescription)")
    }
}
