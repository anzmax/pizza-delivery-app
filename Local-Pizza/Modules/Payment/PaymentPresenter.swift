//
//  PaymentPresenter.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 30.04.2024.
//

import UIKit

protocol PaymentPresenterProtocol: AnyObject {
    
    var view: PaymentVCProtocol? { get set}
    
    func applePayButtonTapped()
    func paymentButtonTapped()
}

final class PaymentPresenter: PaymentPresenterProtocol {
    
    weak var view: PaymentVCProtocol?
}

//MARK: - View Event
extension PaymentPresenter {
    func applePayButtonTapped() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.view?.showPaymentSuccessAlert()
        }
    }
    
    func paymentButtonTapped() {
        view?.showPopup()
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.view?.navigateToMenuScreen()
        }
    }
}
