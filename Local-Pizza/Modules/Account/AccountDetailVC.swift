//
//  AccountDetailVC.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 19.02.2024.
//

import UIKit

class AccountDetailVC: UIViewController {
    
    lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "gearshape"), for: .normal)
        button.tintColor = .black
        button.contentMode = .scaleToFill
        button.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }

    func setupViews() {
        view.applyGradient(colors: [UIColor.systemGray4.cgColor, UIColor.white.cgColor])
        view.addSubview(settingsButton)
    }

    func setupConstraints() {
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            settingsButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            settingsButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            settingsButton.heightAnchor.constraint(equalToConstant: 50),
            settingsButton.widthAnchor.constraint(equalToConstant:50)
        ])
    }
    
    @objc func settingsButtonTapped() {
        let vc = AccountSettingsVC()
        present(vc, animated: true)
    }
}
