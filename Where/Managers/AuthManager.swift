//
//  AuthManager.swift
//  Where
//
//  Created by Sergiy Brotsky on 22.11.2022.
//

import Foundation
import Firebase
import FirebaseAuth



class AuthManager {
    static let shared = AuthManager()
    
    var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    
    private let firestoreManager = FirestoreManager()
    
    var isAuth = false
    
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
        } catch {
           print("Cant logout")
        }
     
    }
}
