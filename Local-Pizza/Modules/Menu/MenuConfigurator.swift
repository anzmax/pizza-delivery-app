//
//  MenuConfigurator.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 29.03.2024.
//

import Foundation

final class MenuConfigurator {
    
    func configure() -> MenuVC {
        
        let menuVC = MenuVC()
        let menuPresenter = MenuPresenter()
        
        menuVC.presenter = menuPresenter
        menuPresenter.view = menuVC
        
        
        
        return menuVC
    }
}
