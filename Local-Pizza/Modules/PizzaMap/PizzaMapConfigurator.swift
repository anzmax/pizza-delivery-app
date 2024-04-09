//
//  PizzaMapConfigurator.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 08.04.2024.
//

import UIKit

final class PizzaMapConfigurator {
    
    func configure() -> PizzaMapVC {
        let pizzaMapVC = PizzaMapVC()
        let pizzaMapPresenter = PizzaMapPresenter()
        
        pizzaMapVC.presenter = pizzaMapPresenter 
        pizzaMapPresenter.view = pizzaMapVC
        
        return pizzaMapVC
    }
}
