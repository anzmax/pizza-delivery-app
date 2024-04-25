//
//  AuthConfigurator.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 11.04.2024.
//

import UIKit

class AuthConfigurator {
    
    func configure() -> AuthorizationVC {
        let authVC = AuthorizationVC()
        let authPresenter = AuthPresenter()
        
        authVC.presenter = authPresenter
        authPresenter.view = authVC
        
        return authVC
    }
}
