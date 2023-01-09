//
//  ValidationManager.swift
//  Where
//
//  Created by Sergiy Brotsky on 01.12.2022.
//

import Foundation

enum RegisterValidationError: String {
    case emailEmpty = "Email is empty"
    case passwordEmpty = "Password is empty"
    case passwordsNotSame = "Password is not same"
    
    case emailIsInvalid = "Email is Invalid"
    case passwordIsInvalid = "Password is invalid"
}

enum LoginValidationError: String {
    case emailEmpty = "Email is empty"
    case passwordEmpty = "Password is empty"
    
    case emailIsInvalid = "Email is Invalid"
    case passwordIsInvalid = "Password is invalid"
}

class ValidationManager {
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    
    
    // MARK: Register
    func validateRegister(email: String?, password: String?, passwordRepeat: String?) -> RegisterValidationError? {
        
        guard let email = email, !email.isEmpty else {
            return .emailEmpty
        }
        
        guard isValidEmail(email) else {
            return .emailIsInvalid
        }
        guard let  password = password, !password.isEmpty else {
            return .passwordEmpty
        }
        guard isValidPassword(password) else {
            return .passwordIsInvalid
        }
    
        guard password == passwordRepeat else {
            return .passwordsNotSame
        }
        
        return nil
    }
    
    // MARK: Login
    func validateLogin(email: String?, password: String?) -> LoginValidationError? {
        guard let email = email, !email.isEmpty else {
            return .emailEmpty
        }
        
        guard isValidEmail(email) else {
            return .emailIsInvalid
        }
        guard let  password = password, !password.isEmpty else {
            return .passwordEmpty
        }
        guard isValidPassword(password) else {
            return .passwordIsInvalid
        }
        
        return nil
    }
    
    // MARK: Add
    
    func validateAdd() {
        
    }
}
