//
//  LostItem.swift
//  Where
//
//  Created by Sergiy Brotsky on 02.12.2022.
//

import Foundation

enum LostItemType: Codable {
    case lost
    case found
}

struct LostItem: Codable {
    let type: LostItemType
    let title: String
    let description: String
    let reward: Int?
}
