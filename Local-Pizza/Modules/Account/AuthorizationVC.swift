//
//  AccountVC.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 19.02.2024.
//

import UIKit
import FirebaseAuth

class AuthorizationVC: UIViewController {
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "8")
        imageView.contentMode = .scaleAspectFill
        
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Войдите в свой аккаунт"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .darkGray
        label.textAlignment = .center
        return label
    }()
    
    lazy var phoneTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Введите номер телефона"
        textField.textAlignment = .center
        textField.keyboardType = .phonePad
        textField.delegate = self
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        addDoneButtonOnKeyboard()
    }
    
    func setupViews() {
        view.backgroundColor = .systemGray6
        view.addSubview(backgroundImageView)
        backgroundImageView.addSubview(titleLabel)
        backgroundImageView.addSubview(phoneTextField)
    }
    
    func setupConstraints() {
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            titleLabel.centerXAnchor.constraint(equalTo: backgroundImageView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            titleLabel.widthAnchor.constraint(equalToConstant: 280),
            
            phoneTextField.centerXAnchor.constraint(equalTo: backgroundImageView.centerXAnchor),
            phoneTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            phoneTextField.widthAnchor.constraint(equalToConstant: 280),
            phoneTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func addDoneButtonOnKeyboard() {
        let toolbarHeight: CGFloat = 50
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: toolbarHeight))
        doneToolbar.barStyle = .default
        
        let flexSpaceLeft = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(doneButtonAction))
        done.tintColor = .black
        let flexSpaceRight = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        doneToolbar.items = [flexSpaceLeft, done, flexSpaceRight]
        doneToolbar.sizeToFit()
        
        phoneTextField.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        guard let phoneNumber = phoneTextField.text, !phoneNumber.isEmpty else {
            showAlert("Пожалуйста, введите номер телефона")
            return
        }
        
        let phoneWithCountryCode = "+44\(phoneNumber)"
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneWithCountryCode, uiDelegate: nil) { verificationID, error in
            
            if let error = error {
                print("Ошибка при отправке кода верификации: \(error.localizedDescription)")
                return
            }
            
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")

            DispatchQueue.main.async {
                let vc = VerificationVC()
                self.present(vc, animated: true)
                print("Код верификации отправлен")
            }
        }
    }
    
    func showAlert(_ message: String) {
         let alert = UIAlertController(title: "Внимание", message: message, preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "OK", style: .default))
         present(alert, animated: true)
     }
}

extension AuthorizationVC: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}
