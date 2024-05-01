//
//  CartConfigurator.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 09.04.2024.
//

import UIKit

final class CartConfigurator {
    
    func configure() -> CartVC {
        let cartVC = CartVC()
        let cartPresenter = CartPresenter()
        
        cartVC.presenter = cartPresenter
        cartPresenter.view = cartVC

        let extrasService = ExtrasNetworkService()
        cartPresenter.extrasService = extrasService
        let archiver = ProductsArchiver()
        cartPresenter.archiver = archiver
        
        return cartVC
    }
}
