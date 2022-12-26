//
//  LostItemUserView.swift
//  Where
//
//  Created by Sergiy Brotsky on 01.12.2022.
//

import Foundation
import UIKit

class LostItemUserView: UIView {
    private let lineView: UIView = {
        let line = UIView()
        line.backgroundColor = .lightGray
        line.translatesAutoresizingMaskIntoConstraints = false
        
        return line
    }()
    
    private let title: UILabel = {
        let lable = UILabel()
        lable.text = "User"
        lable.textColor = .gray
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textAlignment = .center
        lable.font = .systemFont(ofSize: 12, weight: .bold)
        
        return lable
    }()
    
    private let userImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "TestImage1")
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 25
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private let userName: UILabel = {
       let lable = UILabel()
        lable.text = "Сергій"
        lable.textColor = .label
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = .systemFont(ofSize: 17, weight: .bold)
        
        return lable
    }()
    
    private let userStatusLable: UILabel = {
       let lable = UILabel()
        lable.text = "Online"
        lable.textColor = .systemBlue
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = .systemFont(ofSize: 12, weight: .semibold)
        
        return lable
    }()
    
    private let sinseFromLable: UILabel = {
       let lable = UILabel()
        lable.text  = "Sinse from December 2019"
        lable.textColor = .label
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = .systemFont(ofSize: 12, weight: .semibold)
        
        return lable
    }()
    
    private let reportlable: UILabel = {
       let lable = UILabel()
        lable.text = "Report"
        lable.textColor = .label
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = .systemFont(ofSize: 11, weight: .bold)
        lable.underline()

        
        return lable
    }()
    
    private let reportIcon: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "flag")
        image.tintColor = .red
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(lineView)
        addSubview(title)
        addSubview(userImage)
        addSubview(userName)
        addSubview(userStatusLable)
        addSubview(sinseFromLable)
        
        addSubview(reportIcon)
        addSubview(reportlable)
        
        
        setupConstaint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstaint() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 100),
            
            lineView.widthAnchor.constraint(equalTo: widthAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 0.2),
            
            title.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            title.widthAnchor.constraint(equalTo: widthAnchor),
            
            userImage.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20),
            userImage.widthAnchor.constraint(equalToConstant: 50),
            userImage.heightAnchor.constraint(equalToConstant: 50),
            
//
            userName.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 10),
            userName.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            
            userStatusLable.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 10),
            userStatusLable.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            
            sinseFromLable.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 10),
            sinseFromLable.bottomAnchor.constraint(equalTo: userStatusLable.topAnchor, constant: 1),
            
            reportlable.trailingAnchor.constraint(equalTo: trailingAnchor),
            reportlable.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            reportIcon.trailingAnchor.constraint(equalTo: reportlable.leadingAnchor, constant: -5),
            reportIcon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            reportIcon.heightAnchor.constraint(equalToConstant: 13),
            
        ])
    }
}
