//
//  MainTabBarVC.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 12.02.2024.
//

import UIKit

class MainTabVC: UITabBarController {
    
    private lazy var menuVC = MenuConfigurator().configure()
    private var favouritesVC = FavouritesConfigurator().configure()
    private var cartVC = CartVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        tabBar.tintColor = .black
        viewControllers = [menuVC, favouritesVC, cartVC]

                for (index, controller) in [menuVC, favouritesVC, cartVC].enumerated() {
                        
                    let page = TabBarPage.init(index: index)
                    let tabItem = UITabBarItem.init(title: page?.makeTitle(), image: page?.makeIcon(), selectedImage: page?.makeIconSelected())
                controller.tabBarItem = tabItem
                }
    }
}
