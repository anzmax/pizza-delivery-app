//
//  VerificationVC.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 01.03.2024.
//

import UIKit
import FirebaseAuth

protocol VerificationVCProtocol: AnyObject {
    
    //Connections
    var presenter: VerificationPresenterProtocol? { get set }
    
    //Update View
    func showAlert(withTitle title: String, message: String)
    
    //Navigation
    func navigateToAccountDetailVC()
}

class VerificationVC: UIViewController, VerificationVCProtocol {
    
    var presenter: VerificationPresenterProtocol?
    
    //MARK: - UI Elements
    lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отправить".localized(), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGray3
        button.layer.cornerRadius = 5
        button.applyShadow(color: .darkGray)
        button.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var verificationTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Введите код".localized()
        textField.applyShadow(color: .lightGray)
        textField.textAlignment = .center
        textField.keyboardType = .phonePad
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    //MARK: - Action
    @objc func sendButtonTapped() {
        
        if let verificationCode = verificationTextField.text {
            presenter?.sendVerificationCode(verificationCode)
        }
    }
}

//MARK: - Layout
extension VerificationVC {
    func setupViews() {
        view.applyGradient(colors: [UIColor.white.cgColor, UIColor.systemGray3.cgColor])
        view.addSubview(verificationTextField)
        view.addSubview(sendButton)
    }
    
    func setupConstraints() {
        verificationTextField.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
 
            verificationTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verificationTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            verificationTextField.widthAnchor.constraint(equalToConstant: 280),
            verificationTextField.heightAnchor.constraint(equalToConstant: 40),
            
            sendButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sendButton.topAnchor.constraint(equalTo: verificationTextField.bottomAnchor, constant: 16),
            sendButton.widthAnchor.constraint(equalToConstant: 280),
            sendButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}

//MARK: - Update View
extension VerificationVC {
    func showAlert(withTitle title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK".localized(), style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}

//MARK: - Navigation
extension VerificationVC {
    func navigateToAccountDetailVC() {
        let vc = AccountDetailConfigurator().configure()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}
