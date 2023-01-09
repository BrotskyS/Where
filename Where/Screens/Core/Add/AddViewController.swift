//
//  AddViewController.swift
//  Where
//
//  Created by Sergiy Brotsky on 15.11.2022.
//

import UIKit


class AddViewController: UIViewController {
    
    // MARK: Components
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.keyboardDismissMode = .onDrag
        
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
    
    private var lostItem: LostItem
    
    
    
    // MARK: Life Circle
    init(lostItem: LostItem = LostItem.initial) {
        self.lostItem = lostItem
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .theme.background
        navigationItem.title = "Add"
        setupViews()
        setupLayout()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(tappedOnClearButton))
        
        
    }
    
    
    
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        // segmentControl
        stackView.addArrangedSubview(segmentControl)
        segmentControl.addTarget(self, action: #selector(segmentAction), for: .valueChanged)
        
        stackView.addArrangedSubview(photosView)
        
        // titleField
        stackView.addArrangedSubview(titleField)
        titleField.textField.addTarget(self, action: #selector(onChangeTitle), for: .editingChanged)
        titleField.textField.addTarget(self, action: #selector(saveLostItem), for: .editingDidEndOnExit)
        
        stackView.addArrangedSubview(descriptionField)
        descriptionField.delegate = self
        
        // phoneNumberField
        stackView.addArrangedSubview(phoneNumberField)
        phoneNumberField.textField.addTarget(self, action: #selector(onChangePhone), for: .editingChanged)
        phoneNumberField.textField.addTarget(self, action: #selector(saveLostItem), for: .editingDidEndOnExit)
        
        // rewardFiled
        stackView.addArrangedSubview(rewardFiled)
        rewardFiled.textField.addTarget(self, action: #selector(onChangeReward), for: .editingChanged)
        rewardFiled.textField.addTarget(self, action: #selector(saveLostItem), for: .editingDidEndOnExit)
        
        saveButton.addTarget(self, action: #selector(tappedOnSaveButton), for: .touchUpInside)
        stackView.addArrangedSubview(saveButton)
        
        
        imagePicker.delegate = self
        photosView.delegate = self
        
        photoViewer.delegate = self
        photoViewer.dataSource = self
        
        
        
        // if lostItem is not initial. Wee need update data
        if lostItem != LostItem.initial {
            reloadData()
        }
        
    }
    
    
    func reloadData() {
        segmentControl.selectedSegmentIndex = lostItem.type == .lost ? 0 : 1
        
        titleField.setText(text: lostItem.title)
        descriptionField.setText(text: lostItem.description)
        phoneNumberField.setText(text: lostItem.phone)
        
        rewardFiled.setText(text: lostItem.reward ?? "")
    }
    
    // MARK: Private
    
    @objc private func segmentAction(_ segmentedControl: UISegmentedControl) {
        switch (segmentedControl.selectedSegmentIndex) {
            case 0:
                lostItem.type = .lost
                saveLostItem()
            case 1:
                lostItem.type = .found
                saveLostItem()
            default:
                break
        }
    }
    
    
    @objc func onChangeTitle(_ textField: UITextField) {
        lostItem.title = textField.text ?? ""
    }
    
    @objc func onChangePhone(_ textField: UITextField) {
        lostItem.phone = textField.text ?? ""
        
    }
    @objc func onChangeReward(_ textField: UITextField) {
        lostItem.reward = textField.text ?? ""
        
    }
    
    @objc private func tappedOnClearButton() {
        lostItem = LostItem.initial
        reloadData()
        saveLostItem()
    }
    
    @objc private func tappedOnSaveButton() {
        
    }
    
    
    @objc private func saveLostItem() {
        UserDefaultsManager.save(data: lostItem, key: .lostItem)
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
    
    // MARK: Validate fields
    
    private func validateFields() {
        
    }
    
}

extension AddViewController: ImagePickerDelegate {
    func onSelectImages(images: [UIImage]) {
        
        images.forEach {item in
            self.images.append(ImageItem(image: item))
        }
        
        photosView.setImages(images: self.images)
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
    func didChangeImages(images: [ImageItem]) {
        
        self.images = images
        
        photosView.setImages(images: self.images)
    }
    
    func images(_ photoViewer: AddPhotoViewerViewController) -> [ImageItem] {
        return images
    }
    
}

extension AddViewController: CustomTextViewUIViewDelegate {
    func customTextViewTextChanged(text: String?) {
        lostItem.description = text ?? ""
    }
    
    func textViewDidEndEditing() {
        saveLostItem()
    }
}
