//
//  LostItemViewController.swift
//  Where
//
//  Created by Sergiy Brotsky on 29.11.2022.
//

import UIKit

class LostItemViewController: WABaseController {

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let image: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "TestImage1")
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .red
        image.translatesAutoresizingMaskIntoConstraints = false
        
        
        return image
    }()
    
    private let timeLable: UILabel = {
       let lable = UILabel()
        lable.text = "23:15"
        lable.textColor = .lightGray
        lable.font = .preferredFont(forTextStyle: .footnote)
        
        return lable
    }()
    
    private let titleLable: UILabel = {
       let lable = UILabel()
        lable.text = "I lost my keys, help plz"
        lable.font = .systemFont(ofSize: 20, weight: .bold)
        lable.textColor = .label
        
        return lable
    }()
    
    
    
    private let descriptionTextView: UITextView = {
       let textView = UITextView()
        textView.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Rutrum tellus pellentesque eu tincidunt tortor. Lacus vel facilisis volutpat est velit egestas. Urna duis convallis convallis tellus. Vitae aliquet nec ullamcorper sit amet risus nullam. Scelerisque eleifend donec pretium vulputate. Id porta nibh venenatis cras sed. Dictum non consectetur a erat. Cras semper auctor neque vitae tempus quam pellentesque nec. Aenean pharetra magna ac placerat vestibulum. Et malesuada fames ac turpis egestas integer eget aliquet. Feugiat sed lectus vestibulum mattis. Hac habitasse platea dictumst vestibulum. Ac tincidunt vitae semper quis. Mauris a diam maecenas sed enim ut sem viverra aliquet. Commodo elit at imperdiet dui accumsan sit amet nulla."
        textView.textColor = .label
        textView.sizeToFit()
        textView.isScrollEnabled = false
        textView.backgroundColor = .theme.background
        textView.font = .preferredFont(forTextStyle: .body)
        
        return textView
    }()
    
    private let buttonsView = LostItemButtonsView()
    
    private let userView = LostItemUserView()
    
    private let locatioinView = LostItemLocationView()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBase()
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(image)
        stackView.addArrangedSubview(timeLable)
        stackView.addArrangedSubview(titleLable)
        stackView.addArrangedSubview(descriptionTextView)
        stackView.addArrangedSubview(buttonsView)
        stackView.addArrangedSubview(userView)
        
        stackView.addArrangedSubview(locatioinView)
        
        suputConstaint()
        
    }
    
    private func setupBase() {
        title = "Lost"
    }
    
    private func suputConstaint() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            image.heightAnchor.constraint(equalToConstant: 300),
            image.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            
            
        ])
    }
}
