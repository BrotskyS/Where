//
//  PhotoCell.swift
//  Where
//
//  Created by Sergiy Brotsky on 04.01.2023.
//

import UIKit

class PhotoCell: UITableViewCell {

    var image: UIImageView = {
       let image = UIImageView()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        
        
        return image
    }()
    
     var isSelectedCustom = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(image)
        
        configureConstraints()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(image: UIImage, isSelected: Bool) {
        self.image.image = image
        
        self.backgroundColor = isSelected ? .systemGray5 : .clear
        
        
    }
    
    
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            image.heightAnchor.constraint(equalToConstant: 80),
            image.widthAnchor.constraint(equalToConstant: 100)
            
        ])
    }
    
}
