//
//  AuthPresenter.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 11.04.2024.
//

import UIKit
import FirebaseAuth
import LocalAuthentication

protocol AuthPresenterProtocol: AnyObject {
    
    var view: AuthorizationVCProtocol? { get set }
    
    func sendVerificationCode(_ phoneNumber: String, _ textField: UITextField)
    func biometricButtonTapped()
    func isValidPhoneNumber(_ number: String) -> Bool
}

final class AuthPresenter: AuthPresenterProtocol {
    
    weak var view: AuthorizationVCProtocol?
    var localAuthorizationService = LocalAuthorizationService()
}

//MARK: - View Event
extension AuthPresenter {
    
    func sendVerificationCode(_ phoneNumber: String, _ textField: UITextField) {
        guard let phoneNumber = textField.text, !phoneNumber.isEmpty else {
            view?.showAlert("Пожалуйста, введите номер телефона".localized())
            return
        }
        
        let phoneWithCountryCode = "+44\(phoneNumber)"
        
        guard isValidPhoneNumber(phoneWithCountryCode) else {
            view?.showAlert("Введите корректный номер телефона".localized())
            return
        }
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneWithCountryCode, uiDelegate: nil) { [weak self] verificationID, error in
            DispatchQueue.main.async {
                if let error = error {
                    
                    print("Error sending verification code: \(error.localizedDescription)")
                    self?.view?.showAlert("Не удалось отправить код верификации. Проверьте номер и попробуйте снова".localized())
                } else if let verificationID = verificationID {
                    UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                    self?.view?.navigateToVerificationScreen()
                }
            }
        }
    }
    
    func isValidPhoneNumber(_ number: String) -> Bool {
        print("Validating number: \(number)")
        let phoneRegex = "^[+][0-9]{2}[- ]?([0-9]{3}[-]?){2}[0-9]{2}[-]?[0-9]{2}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: number)
    }
    
    func biometricButtonTapped() {
        localAuthorizationService.authorizeIfPossible { [weak self] success in
            DispatchQueue.main.async {
                if success {
                    self?.view?.navigateToAccountDetailScreen()
                } else {
                    print("Failed authorization")
                }
            }
        }
    }
}

