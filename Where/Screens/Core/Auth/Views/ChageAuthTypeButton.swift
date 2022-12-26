//
//  ChageAuthTypeButton.swift
//  Where
//
//  Created by Sergiy Brotsky on 28.11.2022.
//

import Foundation
import UIKit

protocol ChangeAuthTypeButtonDelegete: AnyObject {
    func didTapOnChangeType()
}

class ChangeAuthTypeButton: UIView {
    
    weak var delegete: ChangeAuthTypeButtonDelegete?
    
    let view = UIView()
    
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

        
        
        
        addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(lable)
        view.addSubview(button)
        
        button.addTarget(self, action: #selector(didTab), for: .touchUpInside)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(lableText: String, buttonText: String) {
        lable.text = lableText
        
        button.setTitle(buttonText, for: .normal)
    }
    
    @objc func didTab() {
        delegete?.didTapOnChangeType()
    }
    
}

extension ChangeAuthTypeButton {
    func setupLayout() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 50),

            view.leadingAnchor.constraint(equalTo: lable.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: button.trailingAnchor),
            view.heightAnchor.constraint(equalTo: heightAnchor),
            view.centerXAnchor.constraint(equalTo: centerXAnchor),

            lable.centerYAnchor.constraint(equalTo: centerYAnchor),
            

            
            
            button.leadingAnchor.constraint(equalTo: lable.trailingAnchor, constant: 5),
            button.centerYAnchor.constraint(equalTo: centerYAnchor),

        ])
    }
}
