//
//  PizzaPresenterTests.swift
//  Local-PizzaTests
//
//  Created by Lika Maksimovic on 19.04.2024.
//

@testable import Local_Pizza
import XCTest

//MARK: - Spy
class PizzaPresenterSpy: PizzaMapPresenterProtocol {
    
    var view: PizzaMapVCProtocol?
    
    var closeButtonTappedCalled = false
    var orderButtonTappedCalled = false
    
    func closeButtonTapped() {
        closeButtonTappedCalled = true
    }
    
    func orderButtonTapped() {
        orderButtonTappedCalled = true
    }
}

//MARK: - Tests
class PizzaPresenterTests: XCTestCase {
    
    func testCloseButtonTapped() {
        
        //given
        let vc = PizzaMapVC()
        let presenter = PizzaPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        vc.closeButtonTapped()
        
        //then
        XCTAssertTrue(presenter.closeButtonTappedCalled)
    }
    
    func testOrderButtonTapped() {
        
        //given
        let vc = PizzaMapVC()
        let presenter = PizzaPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        vc.orderButtonTapped()
        
        //then
        XCTAssertTrue(presenter.orderButtonTappedCalled)
    }
}
