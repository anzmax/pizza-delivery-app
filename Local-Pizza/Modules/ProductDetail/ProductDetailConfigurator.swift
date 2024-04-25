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
        
        productDetailVC.update(with: product)
        
        return productDetailVC
    }
}
