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
//        tableView.selectRow(at: IndexPath(row: <#T##Int#>, section: 0), animated: false, scrollPosition: .none)
        
        

    
        NSLayoutConstraint.activate([
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
  
   
}


extension AllPhotosViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PhotoCell
        let image = images[indexPath.row].image
        
        
        
        
        cell.configure(image: image)
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        delegate?.didSelect(didSelectRowAt: indexPath)
    }
    
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let isSelected = dataSource?.isSelectedImage(self, forRowAt: indexPath)
        
        if let isSelected = isSelected {
            cell.setSelected(isSelected, animated: true)
        }
       
    }
    
    
   
}
