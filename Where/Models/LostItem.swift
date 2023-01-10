//
//  LostItem.swift
//  Where
//
//  Created by Sergiy Brotsky on 02.12.2022.
//

import Foundation
import FirebaseAuth

enum LostItemType: String, Codable {
    case lost
    case found
}

struct LostItem: Codable, Equatable {
    var type: LostItemType
    var title: String
    var description: String
    var phone: String
    var reward: String?
    
    var userID: String
    
    
    static let initial = LostItem(type: .lost, title: "", description: "", phone: "", reward: nil, userID: "")
    
}


