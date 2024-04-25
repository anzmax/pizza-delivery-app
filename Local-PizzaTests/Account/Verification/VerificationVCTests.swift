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
    
//    func testShowAlert() {
//        
//        //given
//        let vc = VerificationVCSpy()
//        let presenter = VerificationPresenter()
//        vc.presenter = presenter
//        presenter.view = vc
//        
//        //when
//        let code = "123456"
//        presenter.sendVerificationCode(code)
//        
//        //then
//        XCTAssertTrue(vc.showAlertCalled)
//    }
//    
//    func testNavigateToAccountDetailVC() {
//        
//        //given
//        let vc = VerificationVCSpy()
//        let presenter = VerificationPresenter()
//        vc.presenter = presenter
//        presenter.view = vc
//        
//        //when
//        let code = "123456"
//        presenter.sendVerificationCode(code)
//        
//        //then
//        XCTAssertTrue(vc.navigateToAccountDetailVCCalled)
//    }
}
