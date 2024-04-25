//
//  DeliveryPresenterTests.swift
//  Local-PizzaTests
//
//  Created by Lika Maksimovic on 19.04.2024.
//

@testable import Local_Pizza
import XCTest

//MARK: - Spy
class DeliveryPresenterSpy: DeliveryMapPresenterProtocol {
    
    var view: DeliveryMapVCProtocol?
    
    var closeButtonTappedCalled = false
    var saveButtonTappedCalled = false
    
    func closeButtonTapped() {
        closeButtonTappedCalled = true
    }
    
    func saveButtonTapped() {
        saveButtonTappedCalled = true
    }
}

//MARK: - Tests
class DeliveryPresenterTests: XCTestCase {
    
    func testCloseButtonTapped() {
        
        //given
        let vc = DeliveryMapVC()
        let presenter = DeliveryPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        vc.closeButtonTapped()
        
        //then
        XCTAssertTrue(presenter.closeButtonTappedCalled)
    }
    
    func testSaveButtonTapped() {
        
        //given
        let vc = DeliveryMapVC()
        let presenter = DeliveryPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        vc.saveButtonTapped()
        
        //then
        XCTAssertTrue(presenter.saveButtonTappedCalled)
    }
}
