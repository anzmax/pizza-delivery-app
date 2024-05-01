//
//  AuthPresenterTests.swift
//  Local-PizzaTests
//
//  Created by Lika Maksimovic on 19.04.2024.
//

@testable import Local_Pizza
import XCTest

//MARK: - Spy
class AuthPresenterSpy: AuthPresenterProtocol {

    var view: AuthorizationVCProtocol?
    
    var sendVerificationCodeCalled = false
    var biometricButtonTappedCalled = false
    var isValidPhoneNumberCalled = false
    
    func sendVerificationCode(_ phoneNumber: String, _ textField: UITextField) {
        sendVerificationCodeCalled = true
    }
    
    func biometricButtonTapped() {
        biometricButtonTappedCalled = true
    }
    
    func isValidPhoneNumber(_ number: String) -> Bool {
        isValidPhoneNumberCalled = true
        return true
    }
}

//MARK: - Tests
class AuthPresenterTests: XCTestCase {
    
    func testSendVerificationCode() {
        let vc = AuthorizationVC()
        let presenter = AuthPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc

        vc.doneButtonAction()

        XCTAssertTrue(presenter.sendVerificationCodeCalled)
    }
    
    func testBiometricButtonTapped() {
        let vc = AuthorizationVC()
        let presenter = AuthPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
        
        vc.biometricButtonAction()
        
        XCTAssertTrue(presenter.biometricButtonTappedCalled)
    }
}
