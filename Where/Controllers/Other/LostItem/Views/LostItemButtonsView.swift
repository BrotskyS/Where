//
//  LostItemButtonsView.swift
//  Where
//
//  Created by Sergiy Brotsky on 01.12.2022.
//

import Foundation
import UIKit

class LostItemButtonsView: UIView {
    
    private let stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let callButton: UIButton = {
       let button = UIButton()
        button.setTitle(" Write", for: .normal)
        button.backgroundColor = .systemBlue
        button.setImage(UIImage(systemName: "phone"), for: .normal)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.tintColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
        return button
    }()
    
    private let writeButton: UIButton = {
       let button = UIButton()
        button.setTitle(" Call", for: .normal)
        button.backgroundColor = .systemBlue
        button.setImage(UIImage(systemName: "message"), for: .normal)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.tintColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(stackView)
        
        stackView.addArrangedSubview(callButton)
        stackView.addArrangedSubview(writeButton)
        
        setupConstaint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstaint() {
        NSLayoutConstraint.activate([
            
            heightAnchor.constraint(equalToConstant: 40),
            
            stackView.widthAnchor.constraint(equalTo: widthAnchor),
            stackView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }
}
