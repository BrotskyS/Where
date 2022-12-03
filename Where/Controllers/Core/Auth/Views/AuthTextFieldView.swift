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
        image.tintColor = .placeholderText
        image.contentMode = .scaleAspectFit
        
        
        return image
    }()
    
    private let textFiledView: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private let isSecureImageView: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .placeholderText
        
        return button
    }()
    
    private let devider: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .placeholderText
        
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
            isSecureImageView.addTarget(self, action: #selector(changeVisibility), for: .touchUpInside)
            
            NSLayoutConstraint.activate([
                isSecureImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
                isSecureImageView.widthAnchor.constraint(equalToConstant: 25),
                isSecureImageView.heightAnchor.constraint(equalToConstant: 25),
                isSecureImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 10),
            ])
            
            textFiledView.isSecureTextEntry = true
            textFiledView.textContentType = .password
        }
        
    }
    

    
    func getText() -> String? {
        return textFiledView.text
    }
    
    // MARK: Private
    
    @objc private func changeVisibility() {
   
        if textFiledView.isSecureTextEntry {
            isSecureImageView.setImage(UIImage(systemName: "eye"), for: .normal)
        } else {
            isSecureImageView.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
       
        
        textFiledView.togglePasswordVisibility()
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

