//
//  PhotosUIVIew.swift
//  Where
//
//  Created by Sergiy Brotsky on 21.11.2022.
//

import UIKit


protocol PhotosUIViewDelegate: AnyObject {
    func pressOnImageItem(id: String?)
}

class PhotosUIView: UIView {
    
    // MARK: Components
    private var mainEmptyPhotoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        // image
        view.addSubview(image)
        image.image = UIImage(systemName: "text.below.photo")
        image.tintColor = .label
        
        image.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        image.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -15).isActive = true
        
        // label
        view.addSubview(label)
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 15).isActive = true
        label.font = .preferredFont(forTextStyle: .headline)
        label.text = "Add photo"
        
        
        // view
        view.backgroundColor = .theme.secondary
        
        
        return view
    }()
    
    private let mainPhotoView: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.isUserInteractionEnabled = true
        image.backgroundColor = .red
        image.isHidden = true
        
        return image
    }()
    
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    var delegate: PhotosUIViewDelegate?
    
    
    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        let gestureEmpty = UITapGestureRecognizer(target: self, action:  #selector(self.pressOnImage))
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.pressOnImage))
        
        mainEmptyPhotoView.addGestureRecognizer(gestureEmpty)
        mainPhotoView.addGestureRecognizer(gesture)
        
        addSubview(mainEmptyPhotoView)
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
    
    
    @objc func pressOnImage(sender : UITapGestureRecognizer) {
        let id = sender.view?.accessibilityIdentifier
        delegate?.pressOnImageItem(id: id)
    }
    
    
    private func configureStackView() {
        let emptyImage1 =   EmptyImageView()
        emptyImage1.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.pressOnImage)))
        
        let emptyImage2 =   EmptyImageView()
        emptyImage2.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.pressOnImage)))
        
        let emptyImage3 =   EmptyImageView()
        emptyImage3.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.pressOnImage)))
        
        let emptyImage4 =   EmptyImageView()
        emptyImage4.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(self.pressOnImage)))
        
        stackView.addArrangedSubview(emptyImage1)
        stackView.addArrangedSubview(emptyImage2)
        stackView.addArrangedSubview(emptyImage3)
        stackView.addArrangedSubview(emptyImage4)
    }
    
    func setNewImage(image: ImageItem, at: Int) {
        let imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = image.image
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFill
            imageView.backgroundColor = .red
            imageView.clipsToBounds = true
            imageView.accessibilityIdentifier = image.id.uuidString
            
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(greaterThanOrEqualToConstant: 50),
                imageView.heightAnchor.constraint(equalToConstant: 50),
            ])
            
            let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.pressOnImage))
            
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(gesture)
            
            return imageView
        }()
        
        if at == 0 {
            mainPhotoView.image = image.image
            mainPhotoView.isHidden = false
            mainPhotoView.accessibilityIdentifier = image.id.uuidString
            
//            mainEmptyPhotoView.isHidden = true
        } else {
            stackView.arrangedSubviews[at - 1].removeFromSuperview()
            stackView.insertArrangedSubview(imageView, at: at - 1)
        }
        
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 250),
            
            mainEmptyPhotoView.widthAnchor.constraint(equalTo: widthAnchor),
            mainEmptyPhotoView.heightAnchor.constraint(equalTo: heightAnchor, constant: -60),
            
            mainPhotoView.widthAnchor.constraint(equalTo: widthAnchor),
            mainPhotoView.heightAnchor.constraint(equalTo: heightAnchor, constant: -60),
            
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: widthAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}



class EmptyImageView: UIView {
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


