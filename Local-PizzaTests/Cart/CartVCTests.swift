//
//  CartVCTests.swift
//  Local-PizzaTests
//
//  Created by Lika Maksimovic on 19.04.2024.
//

@testable import Local_Pizza
import XCTest

//MARK: - Spy
class CartVCSpy: CartVCProtocol {

    var presenter: CartPresenterProtocol?
    
    var showItemsInCartCalled = false
    var showDessertsAndDrinksCalled = false
    var navigateToMenuCalled = false
    var navigateToPaymentScreenCalled = false
    
    func showItemsInCart(_ products: [Local_Pizza.Product]) {
        showItemsInCartCalled = true
    }
    
    func showDessertsAndDrinks(_ products: [Local_Pizza.Product]) {
        showDessertsAndDrinksCalled = true
    }
    
    func navigateToMenu() {
        navigateToMenuCalled = true
    }
    
    func navigateToPaymentScreen() {
        navigateToPaymentScreenCalled = true
    }
}

//MARK: - Tests
final class CartVCTests: XCTestCase {
    
    func testNavigateToMenu() {
        let vc = CartVCSpy()
        let presenter = CartPresenter()
        vc.presenter = presenter
        presenter.view = vc

        presenter.menuButtonTapped()

        XCTAssertTrue(vc.navigateToMenuCalled)
    }
    
    func testNavigateToPaymentScreen() {
        let vc = CartVCSpy()
        let presenter = CartPresenter()
        vc.presenter = presenter
        presenter.view = vc
        
        presenter.paymentButtonTapped()
        
        XCTAssertTrue(vc.navigateToPaymentScreenCalled)
    }
}
