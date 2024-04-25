//
//  DeliveryMapConfigurator.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 09.04.2024.
//

import UIKit

class DeliveryMapConfigurator {
    
    func configure() -> DeliveryMapVC {
        
        let deliveryMapVC = DeliveryMapVC()
        let deliveryMapPresenter = DeliveryMapPresenter()
        
        deliveryMapVC.presenter = deliveryMapPresenter
        deliveryMapPresenter.view = deliveryMapVC
        
        return deliveryMapVC
    }
}
