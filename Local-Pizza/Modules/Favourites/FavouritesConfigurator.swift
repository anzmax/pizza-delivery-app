//
//  FavouritesConfigurator.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 05.04.2024.
//

import UIKit

class FavouritesConfigurator {
    
    func configure() -> FavouritesVC {
        
        let favouritesVC = FavouritesVC()
        let favouritesPresenter = FavouritesPresenter()
        
        favouritesVC.presenter = favouritesPresenter
        favouritesPresenter.view = favouritesVC
        
        let archiver = ProductsArchiver()
        favouritesPresenter.archiver = archiver
        
        return favouritesVC
    }
}
