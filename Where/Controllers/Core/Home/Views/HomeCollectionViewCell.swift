//
//  HomeCollectionViewCell.swift
//  Where
//
//  Created by Sergiy Brotsky on 29.11.2022.
//

import Foundation
import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    static let identifier = "HomeCollectionViewCell"
    
    private let image: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "TestImage1")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        
        
        return image
    }()
    
    private let whereTypeBlurView: UIVisualEffectView = {
       let view = UIVisualEffectView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        view.effect = blurEffect
        
        return view
    }()
    
    private let whereTypeImage: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(systemName: "magnifyingglass")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .systemGreen
        
        return image
    }()
    
    private let lable: UILabel = {
       let lable = UILabel()
        lable.text = "Lost my keys, help plz"
        lable.textColor = .label
        lable.font = .systemFont(ofSize: 20, weight: .semibold)
        lable.numberOfLines = 2
        lable.translatesAutoresizingMaskIntoConstraints = false
        
        return lable
    }()
    
    private let locationLable: UILabel = {
       let lable = UILabel()
        lable.text = "Київ, Архипенка"
        lable.textColor = .lightGray
        lable.font = .preferredFont(forTextStyle: .footnote)
        lable.translatesAutoresizingMaskIntoConstraints = false
        
        return lable
    }()
    
    private let dateLable: UILabel = {
        let lable = UILabel()
        lable.text = "4 вер. 20:22"
        lable.textColor = .lightGray
        lable.font = .preferredFont(forTextStyle: .footnote)
        lable.translatesAutoresizingMaskIntoConstraints = false
        
        return lable
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        
        addSubview(image)
        addSubview(whereTypeBlurView)
       
        setupTypeImage()
        addSubview(lable)
        addSubview(locationLable)
        addSubview(dateLable)
        
        
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func setupTypeImage() {
        whereTypeBlurView.contentView.addSubview(whereTypeImage)
    }
    
    private func setupLayout() {
        backgroundColor = .theme.secondary
        clipsToBounds = true
        layer.cornerRadius = 10
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor),
            image.topAnchor.constraint(equalTo: topAnchor),
            image.heightAnchor.constraint(equalToConstant: 140),
            
            whereTypeBlurView.topAnchor.constraint(equalTo: image.topAnchor, constant: 10),
            whereTypeBlurView.leadingAnchor.constraint(equalTo: image.leadingAnchor, constant: 10),
            whereTypeBlurView.widthAnchor.constraint(equalToConstant: 35),
            whereTypeBlurView.heightAnchor.constraint(equalToConstant: 35),
            
            whereTypeImage.centerXAnchor.constraint(equalTo: whereTypeBlurView.centerXAnchor),
            whereTypeImage.centerYAnchor.constraint(equalTo: whereTypeBlurView.centerYAnchor),
            
            lable.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10),
            lable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            lable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10),
            
            dateLable.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            dateLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            locationLable.bottomAnchor.constraint(equalTo: dateLable.topAnchor),
            locationLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
            
            
            
        ])
    }
    
}
