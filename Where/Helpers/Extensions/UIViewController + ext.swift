//
//  UIViewController + ext.swift
//  Where
//
//  Created by Sergiy Brotsky on 28.11.2022.
//

import Foundation
import UIKit


extension UIViewController {
    func setupDismissKeyboardGesture() {
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_: )))
        view.addGestureRecognizer(dismissKeyboardTap)
    }

    @objc func viewTapped(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == UIGestureRecognizer.State.ended {
            view.endEditing(true) // resign first responder
        }
    }
    
    /**
            Create and show default IOS error alert
     */
    func errorAlert(message: Error?) {
        let alert = UIAlertController(title: "Error", message: message?.localizedDescription ?? "Something went wrong", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            print("Ok")
        }))
        
        self.present(alert, animated: true)
    }
}
