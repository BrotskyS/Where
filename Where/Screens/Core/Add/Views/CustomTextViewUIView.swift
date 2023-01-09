//
//  CustomTextViewUIView.swift
//  Where
//
//  Created by Sergiy Brotsky on 22.11.2022.
//

import UIKit

protocol CustomTextViewUIViewDelegate: AnyObject {
    func customTextViewTextChanged(text: String?)
    func textViewDidEndEditing()
}

class CustomTextViewUIView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Add title*"
        label.textColor = .lightGray
        label.font = .preferredFont(forTextStyle: .caption1)
        
        
        return label
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
    private let counterLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0/60"
        label.textColor = .lightGray
        label.font = .preferredFont(forTextStyle: .caption1)
        
        return label
    }()
    
    
    var delegate: CustomTextViewUIViewDelegate?
    
    
    
    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubview(titleLabel)
        addSubview(textView)
        addSubview(counterLabel)
        addConstraints()
        
        textView.delegate = self
        
    }
    
    

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
  
    
    // MARK: Open
    open func configure(title: String, placeholder: String, maxWord: Int?) {
        titleLabel.text = title
        
        if let maxWord = maxWord {
            counterLabel.text = "0/\(maxWord)"
            self.maxWord = maxWord
        } else {
            counterLabel.isHidden = true
        }
    }
    
    
    func setText(text: String?) {
        textView.text = text
        
        updateCounter(textCount: text?.count ?? 0)
    }
    
    
    // MARK: Private
    
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
            heightAnchor.constraint(equalToConstant: 160),
            
            // title
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            // textField
            textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10),
            textView.widthAnchor.constraint(equalTo: widthAnchor),
            textView.heightAnchor.constraint(equalToConstant: 140),
            
            // counterLabel
            counterLabel.bottomAnchor.constraint(equalTo: textView.bottomAnchor, constant: -5),
            counterLabel.trailingAnchor.constraint(equalTo: textView.trailingAnchor, constant: -5)
            
            
        ])
    }

}


extension CustomTextViewUIView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let textCount = textView.text?.count ?? 0
        
        updateCounter(textCount: textCount)
        
        
        delegate?.customTextViewTextChanged(text: textView.text)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        delegate?.textViewDidEndEditing()
    }
}
