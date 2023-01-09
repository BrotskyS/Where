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
    
    func createLostItem(_ lostItem: LostItem) {
        do {
           try db.collection("lostItems")
                .document()
                .setData(from: lostItem)
        } catch {
            print("Erorr")
        }
      
    }
    
}


