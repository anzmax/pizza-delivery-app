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
    
    func sendVerificationCode(_ phoneNumber: String, _ textField: UITextField) {
        sendVerificationCodeCalled = true
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
}
