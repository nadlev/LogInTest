//
//  AuthenManager.swift
//  LoginTesting
//
//  Created by Надежда Левицкая on 4/4/23.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class AuthenManager {
    
    public static let shared = AuthenManager()
    
    private init() {}
    
    public func registerUser(with registerUser: RegisterUser, completion: @escaping (Bool, Error?) -> Void) {
        let userName = registerUser.fullName
        let email = registerUser.email
        let password = registerUser.password
        let phoneNumber = registerUser.phoneNumber
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(false, error)
                return
            }
            
            guard let registerUser = result?.user else {
                completion(false, error)
                return
            }
            
            let db = Firestore.firestore()
            
            db.collection("users")
                .document(registerUser.uid)
                .setData(["username": userName, "email": email, "phone": phoneNumber]) {
                    error in
                    if let error = error {
                        completion(false, error)
                        return
                    }
                    completion(true, nil)
                }
        }
    }
    
    public func singIn(with registeredUser: LogInUser, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: registeredUser.email, password: registeredUser.password) { result, error in
            if let error = error {
                completion(error)
                return
            } else {
                completion(nil)
            }
        }
    }
    
    public func singOut(completion: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
    
    public func forgottenPassword(with email: String, completion: @escaping(Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) {
            error in completion(error)
        }
    }
    
    public func identifyUser(completion: @escaping (User?, Error?) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        let fs = Firestore.firestore()
        fs.collection("users")
            .document(userID)
            .getDocument { screen, error in
                if let error = error {
                    completion(nil, error)
                    return
                }
                
                if let screen = screen,
                   let screenData = screen.data(),
                   let username = screenData["username"] as? String,
                   let email = screenData["email"] as? String,
                   let phoneNumber = screenData["phone"] as? Int {
                    let user = User(userName: username, email: email, phoneNumber: phoneNumber, userID: userID)
                    completion(user, nil)
                }
            }
    }
}

class CheckCorrectness {
    
    static func isCorrectPassword(for password: String) -> Bool {
        let password = password.trimmingCharacters(in: .whitespacesAndNewlines)
        let registerPassword = "\\w{4,24}"
        let enteringPassword = NSPredicate(format: "SELF MATCHES %@", registerPassword)
        return enteringPassword.evaluate(with: password)
    }
    
    static func isCorrectUserName(for username: String) -> Bool {
        let username = username.trimmingCharacters(in: .whitespacesAndNewlines)
        let registerUserName = "\\w{4, 24}"
        let enteringUserName = NSPredicate(format: "SELF MATCHES %@", registerUserName)
        return enteringUserName.evaluate(with: username)
    }
    
    static func isCorrectEmail(for email: String) -> Bool {
        let email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let registeredEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.{1}[A-Za-z]{2,64}"
        let enteringEmail = NSPredicate(format: "SELF MATCHES %@", registeredEmail)
        return enteringEmail.evaluate(with: email)
    }
    
    static func isCorrectPhoneNumber(for number: String) -> Bool {
        let phoneNumber = number.trimmingCharacters(in: .whitespacesAndNewlines)
        let registeredPhoneNumber = "[0-9]{8}"
        let enteringPhoneNumber = NSPredicate(format: "SELF MATCHES %@", registeredPhoneNumber)
        return enteringPhoneNumber.evaluate(with: phoneNumber)
    }
}
