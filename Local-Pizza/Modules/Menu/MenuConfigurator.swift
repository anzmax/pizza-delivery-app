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
        
        let productsService = ProductNetworkService()
        let specialsService = SpecialsNetworkService()
        let categoriesService = CategoriesNetworkService()
        let storiesService = StoriesNetworkService()
        let coreDataService = CoreDataService()
        
        menuPresenter.productsService = productsService
        menuPresenter.specialsService = specialsService
        menuPresenter.categoriesService = categoriesService
        menuPresenter.storiesService = storiesService
        menuPresenter.coreDataService = coreDataService
        
        return menuVC
    }
}
