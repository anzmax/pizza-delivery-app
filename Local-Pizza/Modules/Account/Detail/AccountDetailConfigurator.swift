//
//  AccountDetailConfigurator.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 11.04.2024.
//

import UIKit

final class AccountDetailConfigurator {
    
    func configure() -> AccountDetailVC {
        
        let accountDetailVC = AccountDetailVC()
        let accountPresenter = AccountDetailPresenter()
        
        accountDetailVC.presenter = accountPresenter
        accountPresenter.view = accountDetailVC
        
        return accountDetailVC
    }
}
