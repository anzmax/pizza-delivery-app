//
//  PaymentPresenterTests.swift
//  Local-PizzaTests
//
//  Created by Lika Maksimovic on 01.05.2024.
//

@testable import Local_Pizza
import XCTest

//MARK: - Spy
class PaymentPresenterSpy: PaymentPresenterProtocol {
    var view: PaymentVCProtocol?
    
    var applePayButtonTappedCalled = false
    var paymentButtonTappedCalled = false
    
    func applePayButtonTapped() {
        applePayButtonTappedCalled = true
    }
    
    func paymentButtonTapped() {
        paymentButtonTappedCalled = true
    }
}

//MARK: - Tests
final class PaymentPresenterTests: XCTestCase {
    
    func testApplePayButtonTapped() {
        let vc = PaymentVC()
        let presenter = PaymentPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
        
        vc.applePayButtonAction()
        
        XCTAssertTrue(presenter.applePayButtonTappedCalled)
    }
    
    func testPaymentButtonTapped() {
        let vc = PaymentVC()
        let presenter = PaymentPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
        
        vc.cardNumberTextField = UITextField()
        vc.nameTextField = UITextField()
        vc.cvvTextField = UITextField()
        vc.expiredTextField = UITextField()
        
        vc.cardNumberTextField.text = "1234567812345678"
        vc.nameTextField.text = "John Smith"
        vc.cvvTextField.text = "123"
        vc.expiredTextField.text = "12/24"
        
        vc.paymentButtonAction()
        
        XCTAssertTrue(presenter.paymentButtonTappedCalled)
    }
}
