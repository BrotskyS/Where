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
    
}

class AddPhotoViewerViewController: UIViewController {
    
    var delegate: AddPhotoViewerViewControllerDelegate?
    var dataSource: AddPhotoViewerViewControllerDataSource?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
     
    }
    
    override func viewDidLayoutSubviews() {
        let yourVC = AllPhotosViewController()

        if let sheet = yourVC.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        self.present(yourVC, animated: true)
    }
}
