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
        let vc = PizzaMapVC()
        let presenter = PizzaPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
 
        vc.closeButtonTapped()

        XCTAssertTrue(presenter.closeButtonTappedCalled)
    }
    
    func testOrderButtonTapped() {
        let vc = PizzaMapVC()
        let presenter = PizzaPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc

        vc.orderButtonTapped()

        XCTAssertTrue(presenter.orderButtonTappedCalled)
    }
}
