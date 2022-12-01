//
//  AuthManager.swift
//  Where
//
//  Created by Sergiy Brotsky on 22.11.2022.
//

import Foundation


class AuthManager {
    static let shared = AuthManager()
    
    var isSignedIn: Bool {
        return true
    }
}
