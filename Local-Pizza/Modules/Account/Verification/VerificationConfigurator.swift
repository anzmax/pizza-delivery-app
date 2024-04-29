//
//  VerificationConfigurator.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 11.04.2024.
//

import UIKit

final class VerificationConfigurator {
    
    func configure() -> VerificationVC {
        let verificationVC = VerificationVC()
        let presenter = VerificationPresenter()
        
        verificationVC.presenter = presenter
        presenter.view = verificationVC
        
        return verificationVC
    }
}
