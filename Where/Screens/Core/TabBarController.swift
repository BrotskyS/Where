//
//  TabBarController.swift
//  Where
//
//  Created by Sergiy Brotsky on 03.11.2022.
//

import UIKit

enum Tabs: Int {
    case home
    case map
    case add
    case chat
    case account
}

final class TabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        let vc1 = HomeViewController()
        let vc2 = MapViewController()
        
        let savedLostItem: LostItem? = UserDefaultsManager.get(key: .lostItem)
        let vc3 = AddViewController(lostItem: savedLostItem ?? LostItem.initial)
        
        let vc4 = ChatViewController()
        let vc5 = AccountViewController()
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        let nav4 = UINavigationController(rootViewController: vc4)
        let nav5 = UINavigationController(rootViewController: vc5)
        
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "map.fill"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Add", image: UIImage(systemName: "plus.circle.fill"), tag: 3)
        nav4.tabBarItem = UITabBarItem(title: "Chat", image: UIImage(systemName: "bell.fill"), tag: 4)
        nav5.tabBarItem = UITabBarItem(title: "Account", image: UIImage(systemName: "person.fill"), tag: 5)
        
        
        setViewControllers([nav1, nav2, nav3, nav4, nav5], animated: false)
        
    }
}
