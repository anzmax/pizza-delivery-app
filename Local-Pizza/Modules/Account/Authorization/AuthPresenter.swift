//
//  AuthPresenter.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 11.04.2024.
//

import UIKit
import FirebaseAuth

protocol AuthPresenterProtocol: AnyObject {
    
    var view: AuthorizationVCProtocol? { get set }
    
    func sendVerificationCode(_ phoneNumber: String, _ textField: UITextField)
}

final class AuthPresenter: AuthPresenterProtocol {
    
    weak var view: AuthorizationVCProtocol?
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
}

