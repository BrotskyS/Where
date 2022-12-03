//
//  AccountViewController.swift
//  Where
//
//  Created by Sergiy Brotsky on 15.11.2022.
//

import UIKit

class AccountViewController: UIViewController {

    
    let signoutButton: UIButton = {
        let button = UIButton(type: .system)
        

       
        button.setTitle("Sign Out", for: .normal)
        button.configuration = .tinted()

        
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Account"
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        signoutButton.addTarget(self, action: #selector(tappedSignOut), for: .touchUpInside)
        
       
        view.addSubview(signoutButton)
    }
    
    @objc private func tappedSignOut() {
        AuthManager.shared.signOut()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signoutButton.frame = CGRect(
            x: 20,
            y: view.height - 50 - view.safeAreaInsets.bottom,
            width: view.width - 40,
            height: 50
        )
    }
    

}
