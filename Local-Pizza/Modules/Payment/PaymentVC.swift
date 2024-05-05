//
//  PaymentVC.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 30.04.2024.
//

import AudioToolbox
import UIKit

protocol PaymentVCProtocol: AnyObject {
    
    var presenter: PaymentPresenterProtocol? { get set }
    
    func showPopup()
    func showPaymentSuccessAlert()
    
    func navigateToMenuScreen()
}

final class PaymentVC: UIViewController, PaymentVCProtocol {
    
    var presenter: PaymentPresenterProtocol?
    
    lazy var titleLabel = CustomLabel(text: "Выберите способ оплаты".localized(), color: .black, size: 22, fontWeight: .semibold)
    
    lazy var cardNumberLabel = CustomLabel(text: "Номер карты".localized(), color: .gray, size: 14, fontWeight: .light)
    
    lazy var nameLabel = CustomLabel(text: "Имя на карте".localized(), color: .gray, size: 14, fontWeight: .light)
    
    lazy var expiredDateLabel = CustomLabel(text: "Дата истечения срока".localized(), color: .gray, size: 14, fontWeight: .light)
    
    lazy var cvvLabel = CustomLabel(text: "CVV".localized(), color: .gray, size: 14, fontWeight: .light)
    
    
    lazy var masterCardButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "mastercard1"), for: .normal)
        return button
    }()
    
    lazy var applePayButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "applepay1"), for: .normal)
        button.addTarget(self, action: #selector(applePayButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy var cardNumberTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.tintColor = .darkGray
        textField.placeholder = "Введите номер карты".localized()
        textField.keyboardType = .numberPad
        textField.delegate = self
        return textField
    }()
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.tintColor = .darkGray
        textField.placeholder = "Введите имя".localized()
        return textField
    }()
    
    lazy var cvvTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.tintColor = .darkGray
        textField.isSecureTextEntry = true
        textField.keyboardType = .numberPad
        textField.delegate = self
        return textField
    }()
    
    lazy var expiredTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.tintColor = .darkGray
        textField.placeholder = "MM / YY"
        textField.keyboardType = .numberPad
        textField.delegate = self
        return textField
    }()
    
    lazy var paymentButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray6
        button.setTitle("Оплатить".localized(), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.layer.cornerRadius = 5
        button.applyShadow(color: .lightGray)
        button.addTarget(self, action: #selector(paymentButtonAction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
}

//MARK: - Delegate
extension PaymentVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == cardNumberTextField {
            return handleCardNumberInput(textField: textField, range: range, string: string)
        } else if textField == expiredTextField {
            return handleExpirationDateInput(textField: textField, range: range, string: string)
        } else if textField == cvvTextField {
            return handleCVVInput(textField: textField, range: range, string: string)
        }
        return true
    }
    
    
    func handleCardNumberInput(textField: UITextField, range: NSRange, string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newString = (currentText as NSString).replacingCharacters(in: range, with: string)
        let digitsOnly = newString.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        if digitsOnly.count > 16 {
            return false
        }
        
        var formattedText = ""
        for (index, digit) in digitsOnly.enumerated() {
            if index > 0 && index % 4 == 0 {
                formattedText += " "
            }
            formattedText += String(digit)
        }
        
        textField.text = formattedText
        return false
    }
    
    func handleExpirationDateInput(textField: UITextField, range: NSRange, string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newString = (currentText as NSString).replacingCharacters(in: range, with: string)
        let digitsOnly = newString.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        if digitsOnly.count > 4 {
            return false
        }
        
        var formattedText = ""
        for (index, digit) in digitsOnly.enumerated() {
            if index == 2 {
                formattedText += "/"
            }
            formattedText += String(digit)
        }
        
        textField.text = formattedText
        return false
    }
    
    func handleCVVInput(textField: UITextField, range: NSRange, string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newString = (currentText as NSString).replacingCharacters(in: range, with: string)
        let digitsOnly = newString.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        if digitsOnly.count > 3 {
            return false
        }
        
        textField.text = digitsOnly
        return false
    }
}

//MARK: - Event Handler
extension PaymentVC {
    @objc func applePayButtonAction() {
        presenter?.applePayButtonTapped()
    }
    
    @objc func paymentButtonAction() {
        if areAllFieldsValid() {
            presenter?.paymentButtonTapped()
        }
    }
    
    func areAllFieldsValid() -> Bool {
        
        var allFieldsValid = true
        
        let textFields = [cardNumberTextField, nameTextField, cvvTextField, expiredTextField]
        
        for textField in textFields {
            if textField.text?.isEmpty ?? true {
                textField.layer.borderColor = UIColor.red.cgColor
                textField.layer.cornerRadius = 8
                textField.layer.borderWidth = 1.0
                allFieldsValid = false
            } else {
                textField.layer.borderColor = UIColor.clear.cgColor
                textField.layer.borderWidth = 0
            }
        }
        
        if let cardNumber = cardNumberTextField.text?.filter({ "0123456789".contains($0) }), cardNumber.count < 16 {
            cardNumberTextField.layer.borderColor = UIColor.red.cgColor
            cardNumberTextField.layer.cornerRadius = 8
            cardNumberTextField.layer.borderWidth = 1.0
            allFieldsValid = false
        }
        
        return allFieldsValid
    }
}

//MARK: - Update View
extension PaymentVC {
    func showPopup() {
        let popup = CustomPopupView()
        popup.show(in: self.view)
        popup.hide()
    }
    
    func showPaymentSuccessAlert() {
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        let alert = UIAlertController(title: "Apple Pay", message: "Оплата прошла успешно!".localized(), preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.navigateToMenuScreen()
        }
        alert.addAction(okAction)
        alert.view.tintColor = UIColor.black
        present(alert, animated: true, completion: nil)
    }
}

//MARK: - Navigation
extension PaymentVC {
    func navigateToMenuScreen() {
        let tabBarVC = MainTabVC()
        tabBarVC.modalPresentationStyle = .fullScreen
        present(tabBarVC, animated: true)
    }
}

//MARK: - Layout
extension PaymentVC {
    func setupViews() {
        view.backgroundColor = .white
        [titleLabel, masterCardButton, applePayButton, cardNumberLabel, cardNumberTextField, nameLabel, nameTextField, expiredDateLabel, cvvLabel, cvvTextField, expiredTextField, paymentButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            masterCardButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            masterCardButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            masterCardButton.widthAnchor.constraint(equalToConstant: 63),
            masterCardButton.heightAnchor.constraint(equalToConstant: 40),
            
            applePayButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            applePayButton.leadingAnchor.constraint(equalTo: masterCardButton.trailingAnchor, constant: 16),
            applePayButton.widthAnchor.constraint(equalToConstant: 65),
            applePayButton.heightAnchor.constraint(equalToConstant: 60),
            
            cardNumberLabel.topAnchor.constraint(equalTo: masterCardButton.bottomAnchor, constant: 36),
            cardNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            cardNumberTextField.topAnchor.constraint(equalTo: cardNumberLabel.bottomAnchor, constant: 10),
            cardNumberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cardNumberTextField.widthAnchor.constraint(equalToConstant: 360),
            cardNumberTextField.heightAnchor.constraint(equalToConstant: 40),
            
            nameLabel.topAnchor.constraint(equalTo: cardNumberTextField.bottomAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameTextField.widthAnchor.constraint(equalToConstant: 360),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            expiredDateLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            expiredDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            cvvLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            cvvLabel.leadingAnchor.constraint(equalTo: cvvTextField.leadingAnchor),
            
            cvvTextField.topAnchor.constraint(equalTo: cvvLabel.bottomAnchor, constant: 10),
            cvvTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            cvvTextField.widthAnchor.constraint(equalToConstant: 150),
            cvvTextField.heightAnchor.constraint(equalToConstant: 40),
            
            expiredTextField.topAnchor.constraint(equalTo: cvvLabel.bottomAnchor, constant: 10),
            expiredTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            expiredTextField.widthAnchor.constraint(equalToConstant: 150),
            expiredTextField.heightAnchor.constraint(equalToConstant: 40),
            
            paymentButton.widthAnchor.constraint(equalToConstant: 360),
            paymentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            paymentButton.topAnchor.constraint(equalTo: expiredTextField.bottomAnchor, constant: 46),
            paymentButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
