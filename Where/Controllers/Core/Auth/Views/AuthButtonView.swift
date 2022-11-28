//
//  AuthButtonView.swift
//  Where
//
//  Created by Sergiy Brotsky on 23.11.2022.
//

import UIKit

class AuthButtonView: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setTitle("Hello", for: .normal)
        clipsToBounds = true
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String) {
        setTitle(text, for: .normal)
        tintColor = .label
        backgroundColor = UIColor.lightGray
        
    }
    
    // MARK: Private
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 45),
        ])
    }
    
}
