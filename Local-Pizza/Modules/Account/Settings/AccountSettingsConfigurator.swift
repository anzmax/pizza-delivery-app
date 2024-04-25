//
//  SettingsConfigurator.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 11.04.2024.
//

import UIKit

class AccountSettingsConfigurator {
    
    func configure() -> AccountSettingsVC {
        
        let settingsVC = AccountSettingsVC()
        let settingsPresenter = AccountSettingsPresenter()
        
        settingsVC.presenter = settingsPresenter
        settingsPresenter.view = settingsVC
        
        return settingsVC
    }
}
