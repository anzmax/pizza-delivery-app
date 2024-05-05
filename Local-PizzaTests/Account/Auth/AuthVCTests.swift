//
//  AuthVCTests.swift
//  Local-PizzaTests
//
//  Created by Lika Maksimovic on 19.04.2024.
//

@testable import Local_Pizza
import XCTest

//MARK: - Spy
class AuthVCSpy: AuthorizationVCProtocol {
    
    var presenter: AuthPresenterProtocol?
    
    var showAlertCalled = false
    var navigateToVerificationScreenCalled = false
    var navigateToAccountDetailScreenCalled = false
    
    func showAlert(_ message: String) {
        showAlertCalled = true
    }
    
    func navigateToVerificationScreen() {
        navigateToVerificationScreenCalled = true
    }
    
    func navigateToAccountDetailScreen() {
        navigateToAccountDetailScreenCalled = true
    }
}

//MARK: - Tests
class AuthVCTests: XCTestCase {
    
    func testShowAlert() {
        let vc = AuthVCSpy()
        let presenter = AuthPresenter()
        vc.presenter = presenter
        presenter.view = vc
 
        let textField = UITextField()
        let number = "7342207015"
        presenter.sendVerificationCode(number, textField)

        XCTAssertTrue(vc.showAlertCalled)
    }
}
