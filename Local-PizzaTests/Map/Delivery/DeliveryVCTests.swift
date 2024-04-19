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
        
        //given
        let vc = DeliveryMapVCSpy()
        let presenter = DeliveryMapPresenter()
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        presenter.closeButtonTapped()
        
        //then
        XCTAssertTrue(vc.navigateToPreviousScreenCalled)
    }
    
    func testPassAddressToMenuScreen() {
        
        //given
        let vc = DeliveryMapVCSpy()
        let presenter = DeliveryMapPresenter()
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        presenter.saveButtonTapped()
        
        //then
        XCTAssertTrue(vc.passAddressToMenuScreenCalled)
    }
}
