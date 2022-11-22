//
//  HomeViewController.swift
//  Where
//
//  Created by Sergiy Brotsky on 15.11.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
    }
    
    
    // MARK: basic config
    private func configure() {
        title = "Home"
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        
        
    }
    
}
