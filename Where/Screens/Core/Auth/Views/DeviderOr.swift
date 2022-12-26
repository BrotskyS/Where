//
//  DeviderOr.swift
//  Where
//
//  Created by Sergiy Brotsky on 28.11.2022.
//

import Foundation
import UIKit


class DeviderOr: UIView {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.text = "OR"
        lable.textColor = .label
        
        let deviderLeft = DeviderView()
        
        let deviderRight = DeviderView()

        
        addSubview(deviderLeft)
        addSubview(lable)
        addSubview(deviderRight)
        
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 50),
            
            lable.centerXAnchor.constraint(equalTo: centerXAnchor),
            lable.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            deviderLeft.leadingAnchor.constraint(equalTo: leadingAnchor),
            deviderLeft.trailingAnchor.constraint(equalTo: lable.leadingAnchor, constant: -10),
            deviderLeft.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            deviderRight.leadingAnchor.constraint(equalTo: lable.trailingAnchor, constant: 10),
            deviderRight.trailingAnchor.constraint(equalTo: trailingAnchor),
            deviderRight.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    
  
    

    
    
    

}
