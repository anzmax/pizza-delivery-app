//
//  PizzaVCTests.swift
//  Local-PizzaTests
//
//  Created by Lika Maksimovic on 19.04.2024.
//

@testable import Local_Pizza
import XCTest

//MARK: - Spy
class PizzaMapVCSpy: PizzaMapVCProtocol {
    
    var presenter: PizzaMapPresenterProtocol?
    
    var addAnnotationForAddressCalled = false
    var addAnnotationsForPizzaAddressesCalled = false
    var navigateToPreviousScreenCalled = false
    var passAnnotationAddressToMenuCalled = false
    
    func addAnnotationForAddress(_ address: String) {
        addAnnotationForAddressCalled = true
    }
    
    func addAnnotationsForPizzaAddresses() {
        addAnnotationsForPizzaAddressesCalled = true
    }
    
    func navigateToPreviousScreen() {
        navigateToPreviousScreenCalled = true
    }
    
    func passAnnotationAddressToMenu() {
        passAnnotationAddressToMenuCalled = true
    }
}

//MARK: - Tests
class PizzaMapVCTests: XCTestCase {
    
    func testAddAnnotationForAddress() {
        let vc = PizzaMapVCSpy()
        let presenter = PizzaMapPresenter()
        vc.presenter = presenter
        presenter.view = vc

        let address = "11 Kingly St, Soho"
        vc.addAnnotationForAddress(address)
        
        XCTAssertTrue(vc.addAnnotationForAddressCalled)
    }
    
    func testAddAnnotationsForPizzaAddresses() {
        let vc = PizzaMapVCSpy()
        let presenter = PizzaMapPresenter()
        vc.presenter = presenter
        presenter.view = vc

        vc.addAnnotationsForPizzaAddresses()

        XCTAssertTrue(vc.addAnnotationsForPizzaAddressesCalled)
    }
    
    func testNavigateToPreviousScreen() {
        let vc = PizzaMapVCSpy()
        let presenter = PizzaMapPresenter()
        vc.presenter = presenter
        presenter.view = vc
 
        presenter.closeButtonTapped()

        XCTAssertTrue(vc.navigateToPreviousScreenCalled)
    }
    
    func testPassAnnotationAddressToMenu() {
        let vc = PizzaMapVCSpy()
        let presenter = PizzaMapPresenter()
        vc.presenter = presenter
        presenter.view = vc

        presenter.orderButtonTapped()

        XCTAssertTrue(vc.passAnnotationAddressToMenuCalled)
    }
}
