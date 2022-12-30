//
//  ZoomImageViewController.swift
//  Where
//
//  Created by Sergiy Brotsky on 29.12.2022.
//

import UIKit

class ZoomImageViewController: UIViewController, UIScrollViewDelegate {
    
    
    private let scrollViewImage: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        
        return scrollView
    }()
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "TestImage1")
        image.contentMode = .scaleAspectFit
        
        
        return image
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollViewImage)
        
        scrollViewImage.addSubview(image)
        scrollViewImage.delegate = self
        view.backgroundColor = .red
        
        setConstaince()
        
        
    }
    
    
    func configure(image: ImageItem) {
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return image
    }
    
    func setConstaince() {
        NSLayoutConstraint.activate([
            scrollViewImage.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollViewImage.heightAnchor.constraint(equalTo: view.heightAnchor),
            
            image.widthAnchor.constraint(equalTo: scrollViewImage.widthAnchor),
            image.heightAnchor.constraint(equalTo: scrollViewImage.heightAnchor)
        ])
    }
    
    
}
