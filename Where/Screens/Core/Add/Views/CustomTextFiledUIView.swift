//
//  CustomTextFiledUIView.swift
//  Where
//
//  Created by Sergiy Brotsky on 21.11.2022.
//

import UIKit

class CustomTextFiledUIView: UIView {
    
    private let titleLable: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.text = "Add title*"
        lable.textColor = .lightGray
        lable.font = .preferredFont(forTextStyle: .caption1)
        
        
        return lable
    }()
    
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Hello"
        textField.backgroundColor = .theme.secondary
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 5
        
        textField.setLeadingPaddingPoints(10)
        
        
        return textField
    }()
    
    var maxWord: Int = 0
    private let counterLable: UILabel = {
       let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.text = "0/60"
        lable.textColor = .lightGray
        lable.font = .preferredFont(forTextStyle: .caption1)
        
        return lable
    }()
    
    
    
    
    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubview(titleLable)
        addSubview(textField)
        addSubview(counterLable)
        addConstraints()
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
    }
    

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }
    
    // MARK: Open
    open func configure(title: String, placeholder: String, maxWord: Int?) {
        titleLable.text = title
        textField.placeholder = placeholder
        
        if let maxWord = maxWord {
            counterLable.text = "0/\(maxWord)"
            self.maxWord = maxWord
            textField.setTrailingPaddingPoints(50)
        } else {
            counterLable.isHidden = true
            textField.setTrailingPaddingPoints(10)
        }
    }
    
    func setKeyboardType(type: UIKeyboardType) {
        textField.keyboardType = type
    }
    
    func getText() -> String {
        return textField.text ?? ""
    }
    
    
    
    // MARK: Private
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        let textCount = textField.text?.count ?? 0
        counterLable.text = "\(textCount)/\(maxWord)"
        
        if textCount > maxWord {
            counterLable.textColor = .systemRed
        } else {
            counterLable.textColor = .lightGray
        }
    }
    
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            // basic
            widthAnchor.constraint(equalToConstant: 100),
            heightAnchor.constraint(equalToConstant: 70),
            
            // title
            titleLable.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            // textField
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.widthAnchor.constraint(equalTo: widthAnchor),
            textField.heightAnchor.constraint(equalToConstant: 40),
            
            // counterLable
            counterLable.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: -5),
            counterLable.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -5)
            
            
        ])
    }
    
    
}



