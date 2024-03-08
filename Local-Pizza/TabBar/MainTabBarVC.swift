//
//  MainTabBarVC.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 12.02.2024.
//

import UIKit

class MainTabVC: UITabBarController {
    
    private var menuVC = MenuVC()
        private var contactsVC = ContactsVC()
        private var cartVC = CartVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        tabBar.tintColor = .black
        viewControllers = [menuVC, contactsVC, cartVC]

                for (index, controller) in [menuVC, contactsVC, cartVC].enumerated() {
                        
                    let page = TabBarPage.init(index: index)
                    let tabItem = UITabBarItem.init(title: page?.makeTitle(), image: page?.makeIcon(), selectedImage: page?.makeIconSelected())
                controller.tabBarItem = tabItem
                }
    }
}
