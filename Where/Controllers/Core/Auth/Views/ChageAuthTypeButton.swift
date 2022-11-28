//
//  ChageAuthTypeButton.swift
//  Where
//
//  Created by Sergiy Brotsky on 28.11.2022.
//

import Foundation
import UIKit

class ChageAuthTypeButton: UIView {
    let lable: UILabel = {
        let lable = UILabel()
        lable.textColor = .placeholderText
        lable.translatesAutoresizingMaskIntoConstraints = false
        
        return lable
    }()
    
    let button: UIButton = {
       let button = UIButton()
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false

        
        
        backgroundColor = .red
        addSubview(lable)
        addSubview(button)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(lableText: String, buttonText: String) {
       
       
        lable.text = lableText
        
        button.setTitle(buttonText, for: .normal)
        
    }
    
}

extension ChageAuthTypeButton {
    func setupLayout() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalTo: button.heightAnchor),
            widthAnchor.constraint(equalToConstant: 100),
            centerXAnchor.constraint(equalTo: centerXAnchor),
            lable.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            
            
            button.leadingAnchor.constraint(equalTo: lable.trailingAnchor, constant: 5),
            button.centerYAnchor.constraint(equalTo: centerYAnchor),

        ])
    }
}
