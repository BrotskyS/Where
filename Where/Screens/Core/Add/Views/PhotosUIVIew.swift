//
//  PhotosUIVIew.swift
//  Where
//
//  Created by Sergiy Brotsky on 21.11.2022.
//

import UIKit


class PhotosUIVIew: UIView {
    
    // MARK: Components
    private let mainPhotoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        
        // image
        view.addSubview(image)
        image.image = UIImage(systemName: "text.below.photo")
        image.tintColor = .label
        
        image.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        image.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -15).isActive = true
        
        // lable
        view.addSubview(lable)
        lable.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lable.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 15).isActive = true
        lable.font = .preferredFont(forTextStyle: .headline)
        lable.text = "Add photo"
        
        
        // view
        view.backgroundColor = .theme.secondary
        
        
        return view
    }()

    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubview(mainPhotoView)
        addSubview(stackView)
    
        clipsToBounds = true
        layer.cornerRadius = 5
        
        configureStackView()
        addConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private

    
    private func configureStackView() {
        let lable = UILabel()
        lable.text = "Hello"
        lable.textColor = .label
        
        stackView.addArrangedSubview(EpmtyImageView())
        stackView.addArrangedSubview(EpmtyImageView())
        stackView.addArrangedSubview(EpmtyImageView())
        stackView.addArrangedSubview(EpmtyImageView())
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 250),
            
            mainPhotoView.widthAnchor.constraint(equalTo: widthAnchor),
            mainPhotoView.heightAnchor.constraint(equalTo: heightAnchor, constant: -60),
            
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: widthAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}






class EpmtyImageView: UIView {
    let image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "plus.circle.fill")
        
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubview(image)
        backgroundColor = .theme.secondary
        tintColor = .label
        
        image.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        image.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        widthAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
