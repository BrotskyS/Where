//
//  AuthButtonView.swift
//  Where
//
//  Created by Sergiy Brotsky on 23.11.2022.
//

import UIKit

class AuthButtonView: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setTitle("Hello", for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
