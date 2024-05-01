//
//  PaymentConfigurator.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 30.04.2024.
//

import UIKit

final class PaymentConfigurator {
    
    func configure() -> PaymentVC {
        let vc = PaymentVC()
        let presenter = PaymentPresenter()
        
        vc.presenter = presenter
        presenter.view = vc
        
        return vc
    }
}
