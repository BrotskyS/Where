//
//  LostItemLocationView.swift
//  Where
//
//  Created by Sergiy Brotsky on 01.12.2022.
//

import Foundation
import UIKit

class LostItemLocationView: UIView {
    private let lineView: UIView = {
        let line = UIView()
        line.backgroundColor = .lightGray
        line.translatesAutoresizingMaskIntoConstraints = false
        
        return line
    }()
    
    private let title: UILabel = {
        let lable = UILabel()
        lable.text = "Location"
        lable.textColor = .gray
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textAlignment = .center
        lable.font = .systemFont(ofSize: 12, weight: .bold)
        
        return lable
    }()
    
    private let locationIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "location")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private let locationTitle: UILabel = {
       let lable = UILabel()
        lable.text = "Київ"
        lable.textColor = .label
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = .systemFont(ofSize: 17, weight: .bold)
        
        return lable
    }()
    
    private let locationArea: UILabel = {
       let lable = UILabel()
        lable.text  = "Соломянський район"
        lable.textColor = .label
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = .systemFont(ofSize: 12, weight: .semibold)
        
        return lable
    }()
    
    private let locationDistance: UILabel = {
       let lable = UILabel()
        lable.text = "1 km from you"
        lable.textColor = .systemGray
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = .preferredFont(forTextStyle: .caption1)
        
        return lable
    }()
    
  
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(lineView)
        addSubview(title)
        addSubview(locationIcon)
        addSubview(locationTitle)
        addSubview(locationArea)
        addSubview(locationDistance)
        
        
        setupConstaint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstaint() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 130),
            
            lineView.widthAnchor.constraint(equalTo: widthAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 0.2),
            
            title.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            title.widthAnchor.constraint(equalTo: widthAnchor),
            
            locationIcon.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 30),
            locationIcon.widthAnchor.constraint(equalToConstant: 30),
            locationIcon.heightAnchor.constraint(equalToConstant: 30),
            
//
            locationTitle.leadingAnchor.constraint(equalTo: locationIcon.trailingAnchor, constant: 10),
            locationTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20),
            
            locationArea.leadingAnchor.constraint(equalTo: locationIcon.trailingAnchor, constant: 10),
            locationArea.topAnchor.constraint(equalTo: locationTitle.bottomAnchor),
            
            locationDistance.leadingAnchor.constraint(equalTo: locationIcon.trailingAnchor, constant: 10),
            locationDistance.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            
   
            
            
        ])
    }
}
