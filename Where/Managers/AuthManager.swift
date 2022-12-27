//
//  AuthManager.swift
//  Where
//
//  Created by Sergiy Brotsky on 22.11.2022.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseCore
import GoogleSignIn


class AuthManager {
    
    static let shared = AuthManager()
    
    var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    
    private let firestoreManager = FirestoreManager()
    
    
    func signUp(email: String, password: String, complition: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                complition(error)
            } else {
                complition(nil)
            }
            
        }
    }
    
    
    func signIn(email: String, password: String, complition: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                complition(error)
            } else {
                complition(nil)
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.changeRootViewController()
        } catch {
            print("Cant logout")
        }
        
    }
    
    func googleAuth(_ viewController: UIViewController, complition: @escaping (Error?) -> Void) {
        GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { [weak self] googleResult, error in
            guard let googleResult = googleResult, error == nil else {
                complition(error)
                return
            }
            
            let accessToken = googleResult.user.accessToken.tokenString
            let idToken = googleResult.user.idToken?.tokenString
            
            guard let idToken = idToken else {
                return
            }
            
            
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
            
            self?.signInWithCred(credential: credential, complition: { error in
                if let error = error {
                    complition(error)
                } else {
                    complition(nil)
                }
            })

        }
    }
    
    
    
    private func signInWithCred(credential: AuthCredential, complition: @escaping (Error?) -> Void) {
        Auth.auth().signIn(with: credential) { [weak self] authResult, error in
            
            guard let authResult = authResult, error == nil else {
                complition(error)
                
                return
            }

            let isNewUser = authResult.additionalUserInfo?.isNewUser
            
            if let isNewUser = isNewUser, isNewUser {
                let user = User(name: authResult.user.displayName, email: authResult.user.email, phone: nil)
                self?.firestoreManager.createUser(user)
            }
            complition(nil)
        }
    }
    
    func changeRootViewController() {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }

        let vc =  isSignedIn ? TabBarController() : LoginViewController()
        window.rootViewController = vc

        
        let options: UIView.AnimationOptions = .transitionFlipFromBottom

        let duration: TimeInterval = 0.3

        UIView.transition(with: window, duration: duration, options: options, animations: {})
    }

}
