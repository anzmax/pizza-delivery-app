//
//  AccountVC.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 19.02.2024.
//

import UIKit
import FirebaseAuth

protocol AuthorizationVCProtocol: AnyObject {
    
    var presenter: AuthPresenterProtocol? { get set }
    
    func showAlert(_ message: String)
    
    func navigateToVerificationScreen()
    func navigateToAccountDetailScreen()
}

final class AuthorizationVC: UIViewController, AuthorizationVCProtocol {
    
    var presenter: AuthPresenterProtocol?
    
    //MARK: - UI Elelments
    
    lazy var titleLabel = CustomLabel(text: "Войдите в свой аккаунт".localized(), color: .darkGray, size: 24, fontWeight: .bold)
    
    lazy var phoneTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "ваш номер телефона".localized()
        textField.textColor = .darkGray
        textField.applyShadow(color: .lightGray)
        textField.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        textField.textAlignment = .left
        textField.keyboardType = .phonePad
        textField.delegate = self
        
        let prefixLabel = UILabel()
        prefixLabel.text = "    +44"
        prefixLabel.textColor = .darkGray
        prefixLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        prefixLabel.sizeToFit()
        
        let prefixView = UIView(frame: CGRect(x: 0, y: 0, width: prefixLabel.frame.size.width + 10, height: prefixLabel.frame.size.height))
        
        prefixView.addSubview(prefixLabel)
        prefixLabel.center = CGPoint(x: prefixView.center.x + 5, y: prefixView.center.y)
        textField.leftView = prefixView
        textField.leftViewMode = .always
        return textField
    }()
    
    lazy var biometricButton: UIButton = {
        let button = UIButton()
        button.setTitle("Face ID", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGray3
        button.layer.cornerRadius = 5
        button.applyShadow(color: .darkGray)
        button.addTarget(self, action: #selector(biometricButtonAction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        addDoneButtonOnKeyboard()
    }
    
    //MARK: - Action
    @objc func doneButtonAction() {
        
        if let phoneNumber = phoneTextField.text {
            presenter?.sendVerificationCode(phoneNumber, phoneTextField)
        }
    }
    
    @objc func biometricButtonAction() {
        presenter?.biometricButtonTapped()
    }
}

//MARK: - UITextFieldDelegate
extension AuthorizationVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard textField == phoneTextField else { return true }
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        let numberOnlyText = updatedText.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        let maxLength = 11
        let formattedNumber = numberOnlyText.prefix(maxLength)
        
        let formattedText = formattedNumber.enumerated().map { index, character -> String in
            switch index {
            case 3, 6, 8:
                return "-\(character)"
            default:
                return String(character)
            }
        }.joined()
        
        textField.text = formattedText
        
        return false
    }
}

//MARK: - Layout
extension AuthorizationVC {
    func setupViews() {
        view.applyGradient(colors: [UIColor.white.cgColor, UIColor.systemGray3.cgColor])
        [titleLabel, phoneTextField, biometricButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: phoneTextField.topAnchor, constant: -16),
            
            phoneTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            phoneTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            phoneTextField.widthAnchor.constraint(equalToConstant: 280),
            phoneTextField.heightAnchor.constraint(equalToConstant: 40),
            
            biometricButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            biometricButton.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 16),
            biometricButton.widthAnchor.constraint(equalToConstant: 280),
            biometricButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func addDoneButtonOnKeyboard() {
        let toolbarHeight: CGFloat = 50
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: toolbarHeight))
        doneToolbar.barStyle = .default
        
        let flexSpaceLeft = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Готово".localized(), style: .done, target: self, action: #selector(doneButtonAction))
        done.tintColor = .black
        let flexSpaceRight = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        doneToolbar.items = [flexSpaceLeft, done, flexSpaceRight]
        doneToolbar.sizeToFit()
        
        phoneTextField.inputAccessoryView = doneToolbar
    }
}

//MARK: - Update View
extension AuthorizationVC {
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Внимание".localized(), message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK".localized(), style: .default))
        present(alert, animated: true)
    }
}

//MARK: - Navigation
extension AuthorizationVC {
    func navigateToVerificationScreen() {
        let vc = VerificationConfigurator().configure()
        self.present(vc, animated: true)
        print("Код верификации отправлен".localized())
    }
    
    func navigateToAccountDetailScreen() {
        let vc = AccountDetailConfigurator().configure()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}
