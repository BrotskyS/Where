//
//  UserDefaultsManager.swift
//  Where
//
//  Created by Sergiy Brotsky on 09.01.2023.
//

import Foundation



enum UserDefaultsKeys: String {
    case lostItem
}

class UserDefaultsManager {
    static func save<T: Encodable>(data: T, key: UserDefaultsKeys){
        if let encoded = try? JSONEncoder().encode(data) {
            UserDefaults.standard.set(encoded, forKey: key.rawValue)
        }
      
    }
    
    static func get<T: Decodable>(key: UserDefaultsKeys) -> T? {
        
        if let data = UserDefaults.standard.object(forKey: key.rawValue) as? Data,
           let category = try? JSONDecoder().decode(T.self, from: data) {
             return category
        }
        
        return nil
    }
    
    static func remove(key: UserDefaultsKeys) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
}
