//
//  AddViewController.swift
//  Where
//
//  Created by Sergiy Brotsky on 15.11.2022.
//

import UIKit
class AddViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private var segmentControl: UISegmentedControl = {
        let items = ["I Lost", "I Found"]
        let segmentedControl = UISegmentedControl(items: items)
        
        
        segmentedControl.addTarget(AddViewController.self, action: #selector(segmentAction(_:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        return segmentedControl
        
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var photosView: PhotosUIVIew = {
        let photosView = PhotosUIVIew()
        
        return photosView
    }()
    
    
    lazy var titleField: CustomTextFiledUIView = {
       let field = CustomTextFiledUIView()
        field.configure(title: "Ad title", placeholder: "I lost my keys", maxWord: 60)
        
        
        return field
    }()
    
    lazy var descriptionField: CustomTextViewUIView = {
       let field = CustomTextViewUIView()
        field.configure(title: "Describe what you lost", placeholder: "", maxWord: 200)


        return field
    }()
    
    lazy var phoneNumberField: CustomTextFiledUIView = {
       let field = CustomTextFiledUIView()
        field.configure(title: "Your Phone Number", placeholder: "+38067...", maxWord: nil)
        field.setKeyboardType(type: .phonePad)
        return field
    }()
    
    lazy var rewardFiled: CustomTextFiledUIView = {
       let field = CustomTextFiledUIView()
        field.configure(title: "Specify the reward (option)", placeholder: "0$", maxWord: nil)
        field.setKeyboardType(type: .decimalPad)
        return field
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .theme.background
        navigationItem.title = "Add"
        setupViews()
        setupLayout()
    }
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(segmentControl)
        stackView.addArrangedSubview(photosView)
        stackView.addArrangedSubview(titleField)
        stackView.addArrangedSubview(descriptionField)
        stackView.addArrangedSubview(phoneNumberField)
        stackView.addArrangedSubview(rewardFiled)
        
    }
    
    @objc func segmentAction(_ segmentedControl: UISegmentedControl) {
         switch (segmentedControl.selectedSegmentIndex) {
         case 0:
             break // Lost
         case 1:
             break // Found
         default:
             break
         }
     }
    
    private func setupLayout() {
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
    }
    
}




