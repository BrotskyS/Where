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
    
    lazy var photosView: PhotosUIView = {
        let photosView = PhotosUIView()
        
        return photosView
    }()
    
    static let maxImagesCount = 5
    
    
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
    
    
    private let saveButton: UIButton = {
        let button =  UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setTitleColor(.white, for: .normal)
        
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        return button
    }()
    
    
    private let imagePicker = ImagePicker()
    private let photoViewer = AddPhotoViewerViewController()
    private var images: [ImageItem] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .theme.background
        navigationItem.title = "Add"
        setupViews()
        setupLayout()
        
    }
    
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(segmentControl)
        stackView.addArrangedSubview(photosView)
        stackView.addArrangedSubview(titleField)
        stackView.addArrangedSubview(descriptionField)
        stackView.addArrangedSubview(phoneNumberField)
        stackView.addArrangedSubview(rewardFiled)
        
        saveButton.addTarget(self, action: #selector(tappedOnSaveButton), for: .touchUpInside)
        stackView.addArrangedSubview(saveButton)
        
        
        imagePicker.delegate = self
        photosView.delegate = self
        
        photoViewer.delegate = self
        photoViewer.dataSource = self
        
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
    
    @objc private func tappedOnSaveButton() {
        
    }
    
    
    private func setupLayout() {
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -30),
        ])
        
    }
    
}

extension AddViewController: ImagePickerDelegate {
    func onSelectImages(images: [UIImage]) {
        
        images.forEach {item in
            self.images.append(ImageItem(image: item))
        }
        
        self.images.enumerated().forEach { index, item in
            photosView.setNewImage(image: item, at: index)
        }
    }
}


extension AddViewController: PhotosUIViewDelegate {
    func pressOnImageItem(id: String?) {
        // if id is nil, user pressed on empty image
        if let id = id {
            photoViewer.selectedImageId = id
            photoViewer.reloadData()
            let nav = UINavigationController(rootViewController: photoViewer)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        } else {
            let selectionLimit = AddViewController.maxImagesCount - images.count
            self.imagePicker.openPicker(self, selectionLimit: selectionLimit)
        }
    }
}

extension AddViewController: AddPhotoViewerViewControllerDelegate, AddPhotoViewerViewControllerDataSource {
    func images(_ photoViewer: AddPhotoViewerViewController) -> [ImageItem] {
        return images
    }
    
  
    
    
}
