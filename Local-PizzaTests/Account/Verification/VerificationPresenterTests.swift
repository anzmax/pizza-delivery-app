//
//  VerificationPresenterTests.swift
//  Local-PizzaTests
//
//  Created by Lika Maksimovic on 19.04.2024.
//

@testable import Local_Pizza
import XCTest

//MARK: - Spy
class VerificationPresenterSpy: VerificationPresenterProtocol {
    
    var view: VerificationVCProtocol?
    
    var sendVerificationCodeCalled = false
    
    func sendVerificationCode(_ code: String) {
        sendVerificationCodeCalled = true
    }
}

//MARK: - Tests
class VerificationPresenterTests: XCTestCase {
    
    func testSendVerificationCode() {
        let vc = VerificationVC()
        let presenter = VerificationPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc

        vc.sendButtonTapped()

        XCTAssertTrue(presenter.sendVerificationCodeCalled)
    }
}
