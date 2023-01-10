//
//  FirestoreManager.swift
//  Where
//
//  Created by Sergiy Brotsky on 02.12.2022.
//

import Foundation
import FirebaseFirestore
import Firebase
import FirebaseCore
import FirebaseFirestoreSwift


enum FirestoreCollection: String {
    case lostItems
    case users
}

class FirestoreManager {
    private let db = Firestore.firestore()
    
    func createUser(_ user: User) {
        do {
            guard let userId = Auth.auth().currentUser?.uid else {
                return
            }
            
            try db.collection(FirestoreCollection.users.rawValue)
                .document(userId)
                .setData(from: user) { error in
                    print("error: \(String(describing: error))")
                }
        } catch {
            print("Debug: Failed to create user. \(error)")
        }
        
    }
    
    func createLostItem(_ lostItem: LostItem, completion: @escaping (Error?) -> Void) {
        if let userId = Auth.auth().currentUser?.uid {
            do {
                var lostItem = lostItem
                lostItem.userID = userId
                
                try db.collection(FirestoreCollection.lostItems.rawValue)
                    .document()
                    .setData(from: lostItem, completion: { error in
                        completion(error)
                    })
                
                
            } catch {
                completion(error)
                print("Debug: Failed to create lost item. \(error)")
            }
        }
    }
    
}


