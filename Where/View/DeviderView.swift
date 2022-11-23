//
//  DeviderView.swift
//  Where
//
//  Created by Sergiy Brotsky on 23.11.2022.
//

import UIKit

class DeviderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .label
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Private
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 1),
//            widthAnchor.constraint(greaterThanOrEqualToConstant: 200)
        ])
    }
}
