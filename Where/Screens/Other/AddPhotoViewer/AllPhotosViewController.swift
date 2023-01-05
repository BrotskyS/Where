//
//  AllPhotosViewController.swift
//  Where
//
//  Created by Sergiy Brotsky on 03.01.2023.
//

import UIKit

protocol AllPhotosViewControllerDelegate: AnyObject {
    func didChangeImages(images: [ImageItem])
    
    
    /// Call when user press on image
    func didSelect(didSelectRowAt indexPath: IndexPath)
}


protocol AllPhotosViewControllerDataSource: AnyObject {
    
    func isSelectedImage(_ photoViewer: AllPhotosViewController, forRowAt indexPath: IndexPath) -> Bool
}

class AllPhotosViewController: UIViewController {
    private let tableView = UITableView()

    var images: [ImageItem] = []
    var selectedImageId: String?
    
    
    var delegate: AllPhotosViewControllerDelegate?
    var dataSource: AllPhotosViewControllerDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        overrideUserInterfaceStyle = .dark
        
        
        tableView.rowHeight = 100
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PhotoCell.self, forCellReuseIdentifier: "cell")
        tableView.allowsSelection = true
        tableView.isUserInteractionEnabled = true
        tableView.allowsSelectionDuringEditing = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.setEditing(true, animated: true)
        tableView.allowsSelection = false

    
        NSLayoutConstraint.activate([
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    func reloadData() {
        tableView.reloadData()
    }
    
    private func onChangeImages() {
        delegate?.didChangeImages(images: images)
    }
    
    
    
    
   
}


extension AllPhotosViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PhotoCell
        let image = images[indexPath.row].image
        
        cell.configure(image: image, isSelected:  dataSource!.isSelectedImage(self, forRowAt: indexPath))
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(didSelectRowAt: indexPath)
        tableView.reloadData()
    }
    
    
    // Moving
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        images.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        
        onChangeImages()
    }
    
    
    
    // Delete
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            
            tableView.beginUpdates()
            
            images.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            
            onChangeImages()
            
            tableView.reloadData()
            
      
        }
    }
    
   
}
