//
//  CustomTextFiledUIView.swift
//  Where
//
//  Created by Sergiy Brotsky on 21.11.2022.
//

import UIKit

class CustomTextFiledUIView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Add title*"
        label.textColor = .lightGray
        label.font = .preferredFont(forTextStyle: .caption1)
        
        
        return label
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
    private let counterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0/60"
        label.textColor = .lightGray
        label.font = .preferredFont(forTextStyle: .caption1)
        
        return label
    }()
    
    
    
    
    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubview(titleLabel)
        addSubview(textField)
        addSubview(counterLabel)
        addConstraints()
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        
        
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }
    
    // MARK: Open
    open func configure(title: String, placeholder: String, maxWord: Int?) {
        titleLabel.text = title
        textField.placeholder = placeholder
        
        if let maxWord = maxWord {
            counterLabel.text = "0/\(maxWord)"
            self.maxWord = maxWord
            textField.setTrailingPaddingPoints(50)
        } else {
            counterLabel.isHidden = true
            textField.setTrailingPaddingPoints(10)
        }
    }
    
    func setKeyboardType(type: UIKeyboardType) {
        textField.keyboardType = type
    }
    
    func getText() -> String {
        return textField.text ?? ""
    }
    
    func setText(text: String?) {
        textField.text = text
        
        updateCounter(textCount: text?.count ?? 0)
    }
    
    
    
    // MARK: Private
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        let textCount = textField.text?.count ?? 0
        
        updateCounter(textCount: textCount)
    }
    
    
    private func updateCounter(textCount: Int) {
        counterLabel.text = "\(textCount)/\(maxWord)"
        
        if textCount > maxWord {
            counterLabel.textColor = .systemRed
        } else {
            counterLabel.textColor = .lightGray
        }
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            // basic
            heightAnchor.constraint(equalToConstant: 70),
            
            //             title
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            // textField
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.widthAnchor.constraint(equalTo: widthAnchor),
            textField.heightAnchor.constraint(equalToConstant: 40),
            
            // counterLabel
            counterLabel.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: -5),
            counterLabel.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -5)
            
            
        ])
    }
    
    
}



