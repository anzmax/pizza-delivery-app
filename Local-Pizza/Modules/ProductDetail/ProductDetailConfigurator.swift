//
//  ProductDetailConfigurator.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 02.04.2024.
//

import UIKit

class ProductDetailConfigurator {
    
    func configure(_ product: Product) -> ProductDetailVC {
        
        let productDetailVC = ProductDetailVC()
        let productDetailPresenter = ProductDetailPresenter()
        
        productDetailVC.presenter = productDetailPresenter
        productDetailPresenter.view = productDetailVC
        
        
        let archiver = ProductsArchiver()
        let ingredientsService = IngredientsNetworkService()
        
        productDetailPresenter.archiver = archiver
        productDetailPresenter.ingredientsService = ingredientsService
        
        productDetailVC.update(with: product)
        
        return productDetailVC
    }
}
