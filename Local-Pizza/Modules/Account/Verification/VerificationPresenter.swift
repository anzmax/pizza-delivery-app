//
//  VerificationPresenter.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 11.04.2024.
//

import UIKit
import FirebaseAuth

protocol VerificationPresenterProtocol: AnyObject {
    
    //Connections
    var view: VerificationVCProtocol? { get set }
    
    //View Event
    func sendVerificationCode(_ code: String)
}

class VerificationPresenter: VerificationPresenterProtocol {
    
    weak var view: VerificationVCProtocol?
    
}

//MARK: - View Event
extension VerificationPresenter {
    func sendVerificationCode(_ code: String) {
        guard !code.isEmpty else {
            view?.showAlert(withTitle: "Ошибка".localized(), message: "Введите код подтверждения".localized())
            return
        }
        
        guard let currentVerificationId = UserDefaults.standard.string(forKey: "authVerificationID") else {
            view?.showAlert(withTitle: "Ошибка".localized(), message: "Проблема с идентификатором верификации".localized())
            return
        }
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: currentVerificationId, verificationCode: code)
        
        Auth.auth().signIn(with: credential) { [weak self] (authResult, error) in
            if error != nil {
                self?.view?.showAlert(withTitle: "Неверный код".localized(), message: "Введенный код подтверждения неверен. Пожалуйста, попробуйте еще раз.".localized())
                return
            }
            
            self?.view?.navigateToAccountDetailVC()
        }
    }
}

