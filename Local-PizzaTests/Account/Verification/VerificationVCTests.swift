//
//  VerificationVCTests.swift
//  Local-PizzaTests
//
//  Created by Lika Maksimovic on 19.04.2024.
//

@testable import Local_Pizza
import XCTest

//MARK: - Spy
class VerificationVCSpy: VerificationVCProtocol {
    
    var presenter: VerificationPresenterProtocol?
    
    var showAlertCalled = false
    var navigateToAccountDetailVCCalled = false
    
    func showAlert(withTitle title: String, message: String) {
        showAlertCalled = true
    }
    
    func navigateToAccountDetailVC() {
        navigateToAccountDetailVCCalled = true
    }
}

//MARK: - Tests
class VerificationVCTests: XCTestCase {
    
}
