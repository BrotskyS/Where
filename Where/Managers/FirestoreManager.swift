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
}

class FirestoreManager {
    private let db = Firestore.firestore()
    
    func createUser(_ user: User) {
        do {
            try db.collection("users")
                .document()
                .setData(from: user) { error in
                    print("error: \(String(describing: error))")
                }
        } catch {
            print("asdasdasdasdasdas")
        }
     
    }
    
    func createLostItem(_ lostItem: LostItem, completion: @escaping (Error?) -> Void) {
        do {
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


