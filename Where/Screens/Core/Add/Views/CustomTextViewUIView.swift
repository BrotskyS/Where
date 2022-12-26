//
//  CustomTextViewUIView.swift
//  Where
//
//  Created by Sergiy Brotsky on 22.11.2022.
//

import UIKit

class CustomTextViewUIView: UIView, UITextViewDelegate {
    
    private let titleLable: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.text = "Add title*"
        lable.textColor = .lightGray
        lable.font = .preferredFont(forTextStyle: .caption1)
        
        
        return lable
    }()
    
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        textView.backgroundColor = .theme.secondary
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 5
        
        
        
        
        return textView
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
        addSubview(textView)
        addSubview(counterLable)
        addConstraints()
        
        textView.delegate = self
        
    }
    
    

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let textCount = textView.text?.count ?? 0
        counterLable.text = "\(textCount)/\(maxWord)"
        
        if textCount > maxWord {
            counterLable.textColor = .systemRed
        } else {
            counterLable.textColor = .lightGray
        }
    }
    
    // MARK: Open
    open func configure(title: String, placeholder: String, maxWord: Int?) {
        titleLable.text = title
        
        if let maxWord = maxWord {
            counterLable.text = "0/\(maxWord)"
            self.maxWord = maxWord
        } else {
            counterLable.isHidden = true
        }
    }
    
    
    
    // MARK: Private
    
    
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            // basic
            widthAnchor.constraint(equalToConstant: 100),
            heightAnchor.constraint(equalToConstant: 160),
            
            // title
            titleLable.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            // textField
            textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10),
            textView.widthAnchor.constraint(equalTo: widthAnchor),
            textView.heightAnchor.constraint(equalToConstant: 140),
            
            // counterLable
            counterLable.bottomAnchor.constraint(equalTo: textView.bottomAnchor, constant: -5),
            counterLable.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: -5)
            
            
        ])
    }

}
