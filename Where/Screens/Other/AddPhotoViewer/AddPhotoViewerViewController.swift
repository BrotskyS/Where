//
//  AddPhotoViewerViewController.swift
//  Where
//
//  Created by Sergiy Brotsky on 03.01.2023.
//

import UIKit

protocol AddPhotoViewerViewControllerDelegate: AnyObject {
    
}


protocol AddPhotoViewerViewControllerDataSource: AnyObject {
    func images(_ photoViewer: AddPhotoViewerViewController) -> [ImageItem] 
}

class AddPhotoViewerViewController: UIViewController {
    
    private let imageView: UIImageView = {
       let image = UIImageView()
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        
        
        return image
    }()
    
    private let scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInsetAdjustmentBehavior = .never
        
        return scrollView
    }()
    
    
    private let allPhotosViewController = AllPhotosViewController()
    
    private var images: [ImageItem] = []
    
    var selectedImageId: String?
    var delegate: AddPhotoViewerViewControllerDelegate?
    var dataSource: AddPhotoViewerViewControllerDataSource?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        overrideUserInterfaceStyle = .dark
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(pressOnSaveButton))
        
        allPhotosViewController.delegate = self
        allPhotosViewController.dataSource = self
        
        configureViews()
        configureConstraints()
        
        
        reloadData()
     
        
    }
    

    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        allPhotosViewController.isModalInPresentation = true // Disable dismiss modal

        if let sheet = allPhotosViewController.sheetPresentationController {
            sheet.detents = [
                .custom(identifier: .large, resolver: { context in
                    return 100
                }),
                .medium()
            ]
            sheet.prefersGrabberVisible = true
            sheet.prefersEdgeAttachedInCompactHeight = false
            sheet.largestUndimmedDetentIdentifier = .medium
        }
        
        self.present(allPhotosViewController, animated: true)
    }
    
    func reloadData() {
        let images = dataSource?.images(self)
        
        guard let images = images else {
            return
        }
        
        self.images = images
        allPhotosViewController.images = images
        
        configure()
    }
    
    
    // MARK: Private
    private func configureViews() {
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 10.0
        view.addSubview(scrollView)
        
        scrollView.addSubview(imageView)
    }
    
    private func configure() {
        let image = images.first(where: {$0.id.uuidString == selectedImageId})
        
        if let image = image {
            imageView.image = image.image
        }
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            scrollView.heightAnchor.constraint(equalTo: view.heightAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }
    
    @objc private func pressOnSaveButton() {
        self.dismiss(animated: true)
    }
}

extension AddPhotoViewerViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}


extension AddPhotoViewerViewController: AllPhotosViewControllerDelegate, AllPhotosViewControllerDataSource {
 
    func isSelectedImage(_ photoViewer: AllPhotosViewController, forRowAt indexPath: IndexPath) -> Bool {
        return images[indexPath.row].id.uuidString == selectedImageId
    }
 
    func didChangeImages(images: [ImageItem]) {
        
    }
    
    func didSelect(didSelectRowAt indexPath: IndexPath) {
        let newImage = images[indexPath.row].image
        imageView.image = newImage
        
        if let sheet =  allPhotosViewController.sheetPresentationController {
            sheet.animateChanges {
                sheet.selectedDetentIdentifier = .large
            }
        }
    }
    
}
