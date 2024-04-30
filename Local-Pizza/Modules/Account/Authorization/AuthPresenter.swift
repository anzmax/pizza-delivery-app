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
    func handleSuccessfulAuthorization()
    func handleFailedAuthorization()
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
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneWithCountryCode, uiDelegate: nil) { [weak self] verificationID, error in
            if let error = error {
                print("Ошибка при отправке кода верификации: \(error.localizedDescription)")
                return
            }
            
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
            
            DispatchQueue.main.async {
                self?.view?.navigateToVerificationScreen()
            }
        }
    }
    
    func biometricButtonTapped() {
        localAuthorizationService.authorizeIfPossible { [weak self] success in
            DispatchQueue.main.async {
                if success {
                    self?.handleSuccessfulAuthorization()
                } else {
                    self?.handleFailedAuthorization()
                }
            }
        }
    }

    func handleSuccessfulAuthorization() {
        print("Success authorization")
        view?.navigateToAccountDetailScreen()
    }

    func handleFailedAuthorization() {
        print("Failed authorization")
    }
}

