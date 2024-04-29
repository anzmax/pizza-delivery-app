//
//  DeliveryVCTests.swift
//  Local-PizzaTests
//
//  Created by Lika Maksimovic on 19.04.2024.
//

@testable import Local_Pizza
import XCTest

//MARK: - Spy
class DeliveryMapVCSpy: DeliveryMapVCProtocol {
    
    var presenter: DeliveryMapPresenterProtocol?
    
    var navigateToPreviousScreenCalled = false
    var passAddressToMenuScreenCalled = false
    
    func navigateToPreviousScreen() {
        navigateToPreviousScreenCalled = true
    }
    
    func passAddressToMenuScreen() {
        passAddressToMenuScreenCalled = true
    }
}

//MARK: - Tests
class DeliveryMapVCTests: XCTestCase {
    
    func testNavigateToPreviousScreen() {
        let vc = DeliveryMapVCSpy()
        let presenter = DeliveryMapPresenter()
        vc.presenter = presenter
        presenter.view = vc

        presenter.closeButtonTapped()
 
        XCTAssertTrue(vc.navigateToPreviousScreenCalled)
    }
    
    func testPassAddressToMenuScreen() {
        let vc = DeliveryMapVCSpy()
        let presenter = DeliveryMapPresenter()
        vc.presenter = presenter
        presenter.view = vc

        presenter.saveButtonTapped()

        XCTAssertTrue(vc.passAddressToMenuScreenCalled)
    }
}
