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
        
        //given
        let vc = PizzaMapVCSpy()
        let presenter = PizzaMapPresenter()
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        let address = "11 Kingly St, Soho"
        vc.addAnnotationForAddress(address)
        
        //then
        XCTAssertTrue(vc.addAnnotationForAddressCalled)
    }
    
    func testAddAnnotationsForPizzaAddresses() {
        
        //given
        let vc = PizzaMapVCSpy()
        let presenter = PizzaMapPresenter()
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        vc.addAnnotationsForPizzaAddresses()
        
        //then
        XCTAssertTrue(vc.addAnnotationsForPizzaAddressesCalled)
    }
    
    func testNavigateToPreviousScreen() {
        
        //given
        let vc = PizzaMapVCSpy()
        let presenter = PizzaMapPresenter()
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        presenter.closeButtonTapped()
        
        //then
        XCTAssertTrue(vc.navigateToPreviousScreenCalled)
    }
    
    func testPassAnnotationAddressToMenu() {
        
        //given
        let vc = PizzaMapVCSpy()
        let presenter = PizzaMapPresenter()
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        presenter.orderButtonTapped()
        
        //then
        XCTAssertTrue(vc.passAnnotationAddressToMenuCalled)
    }
}
