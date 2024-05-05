//
//  PaymentVCTests.swift
//  Local-PizzaTests
//
//  Created by Lika Maksimovic on 01.05.2024.
//

@testable import Local_Pizza
import XCTest

//MARK: - Spy
class PaymentVCSpy: PaymentVCProtocol {
    
    var presenter: PaymentPresenterProtocol?
    
    var showPopupCalled = false
    var showPaymentSuccessAlertCalled = false
    var navigateToMenuScreenCalled = false
    
    func showPopup() {
        showPopupCalled = true
    }
    
    func showPaymentSuccessAlert() {
        showPaymentSuccessAlertCalled = true
    }
    
    func navigateToMenuScreen() {
        navigateToMenuScreenCalled = true
    }
}

//MARK: - Tests
final class PaymentVCTests: XCTestCase {
    
    func testShowPopup() {
        let vc = PaymentVCSpy()
        let presenter = PaymentPresenter()
        vc.presenter = presenter
        presenter.view = vc
        
        presenter.paymentButtonTapped()
        
        XCTAssertTrue(vc.showPopupCalled)
    }
    
    func testShowPaymentSuccessAlert() {
        let expectation = XCTestExpectation(description: "Payment success alert is shown")
        
        let vc = PaymentVCSpy()
        let presenter = PaymentPresenter()
        vc.presenter = presenter
        presenter.view = vc
        
        presenter.applePayButtonTapped()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if vc.showPaymentSuccessAlertCalled {
                expectation.fulfill()
            }
            self.wait(for: [expectation], timeout: 4.0)
        }
    }
    
    func testNavigateToMenuScreen() {
        let expectation = XCTestExpectation(description: "Navigate to Menu Screen called")
        
        let vc = PaymentVCSpy()
        let presenter = PaymentPresenter()
        vc.presenter = presenter
        presenter.view = vc
        
        presenter.paymentButtonTapped()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            if vc.navigateToMenuScreenCalled {
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 6.0)
    }
}
