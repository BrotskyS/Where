//
//  ImagePicker.swift
//  Where
//
//  Created by Sergiy Brotsky on 29.12.2022.
//

import Foundation
import PhotosUI
import UIKit


protocol ImagePickerDelegate {
    func onSelectImages(images: [UIImage])
}

class ImagePicker: PHPickerViewControllerDelegate{
    var delegate: ImagePickerDelegate?
    

    
    init(delegate: ImagePickerDelegate? = nil) {
        self.delegate = delegate
    }
    
    func openPicker(_ viewController: UIViewController, selectionLimit: Int) {
        var config =  PHPickerConfiguration()
        config.selectionLimit = selectionLimit
        config.filter = .images
        
        let vc = PHPickerViewController(configuration: config)
        vc.delegate = self
        viewController.present(vc, animated: true)
    }
    
    let myGroup = DispatchGroup()
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        var images: [UIImage] = []
    
        results.forEach { result in
            myGroup.enter()
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] reading, error in
                guard let image = reading as? UIImage, error == nil else {
                    self?.myGroup.leave()
                    return
                }
                images.append(image)
                self?.myGroup.leave()
            }
        }

        myGroup.notify(queue: .main) {
            self.delegate?.onSelectImages(images: images)
        }

    }
    
}
