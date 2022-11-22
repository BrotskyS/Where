//
//  AuthTextFieldView.swift
//  Where
//
//  Created by Sergiy Brotsky on 22.11.2022.
//

import UIKit

class AuthTextFieldView: UIView {
    private let leftImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .label
        image.contentMode = .scaleAspectFit
        
        
        return image
    }()
    
    private let textFiledView: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var isSecureImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "eye.slash")
        image.tintColor = .label
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private let devider: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .label
        
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)

        
        addSubview(leftImageView)
        addSubview(textFiledView)
        addSubview(devider)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(imageIcon: String, placeholder: String, isSecure: Bool = false) {
        leftImageView.image = UIImage(systemName: imageIcon)
        textFiledView.placeholder = placeholder
        
        if isSecure {
            addSubview(isSecureImageView)
            
            NSLayoutConstraint.activate([
                isSecureImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
                isSecureImageView.widthAnchor.constraint(equalToConstant: 20),
                isSecureImageView.heightAnchor.constraint(equalToConstant: 20),
                isSecureImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            ])
            
            textFiledView.isSecureTextEntry = true
        }
        
    }
}

extension AuthTextFieldView {
    func setupLayout() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 50),
            
            leftImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            leftImageView.widthAnchor.constraint(equalToConstant: 25),
            leftImageView.heightAnchor.constraint(equalToConstant: 25),
            leftImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            textFiledView.leadingAnchor.constraint(equalTo: leftImageView.trailingAnchor, constant: 10),
            textFiledView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            textFiledView.heightAnchor.constraint(equalToConstant: 35),
            textFiledView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            

            
            devider.leadingAnchor.constraint(equalTo: leftImageView.trailingAnchor, constant: 10),
            devider.trailingAnchor.constraint(equalTo: trailingAnchor),
            devider.bottomAnchor.constraint(equalTo: bottomAnchor),
            devider.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
