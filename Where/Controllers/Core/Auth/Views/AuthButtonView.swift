//
//  AuthButtonView.swift
//  Where
//
//  Created by Sergiy Brotsky on 23.11.2022.
//

import UIKit

class AuthButtonView: UIButton {
    
    func configure(text: String) {
        setTitle(text, for: .normal)
        tintColor = .white
        backgroundColor = .systemBlue
        titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        setTitle(text, for: .normal)
        clipsToBounds = true
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        
        setupLayout()
        
    }
    
    // MARK: Private
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 45),
        ])
    }
    
}
