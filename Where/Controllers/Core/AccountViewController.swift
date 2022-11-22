//
//  AccountViewController.swift
//  Where
//
//  Created by Sergiy Brotsky on 15.11.2022.
//

import UIKit

class AccountViewController: UIViewController {

    
    let signoutButton: UIButton = {
        let button = UIButton()
        

       
        button.setTitle("Sign Out", for: .normal)
        button.configuration = .tinted()

        
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Account"
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        
       
        view.addSubview(signoutButton)
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
