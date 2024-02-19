//
//  AccountVC.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 19.02.2024.
//

import UIKit

class AccountVC: UIViewController {
    
    lazy var numberButton: UIButton = {
        let button = UIButton()
        button.setTitle("Указать телефон", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(numberButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(numberButton)
    }
    
    func setupConstraints() {
        numberButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            numberButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            numberButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            numberButton.widthAnchor.constraint(equalToConstant: 200),
            numberButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func numberButtonPressed() {
        let vc = AccountDetailVC()
        present(vc, animated: true)
    }
}
