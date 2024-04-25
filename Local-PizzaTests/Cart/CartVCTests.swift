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
    
    var showItemsInCartCalled: Bool = false
    var showDessertsAndDrinksCalled: Bool = false
    var navigateToMenuCalled: Bool = false
    
    func showItemsInCart(_ products: [Local_Pizza.Product]) {
        showItemsInCartCalled = true
    }
    
    func showDessertsAndDrinks(_ products: [Local_Pizza.Product]) {
        showDessertsAndDrinksCalled = true
    }
    
    func navigateToMenu() {
        navigateToMenuCalled = true
    }
}

//MARK: - Tests
final class CartVCTests: XCTestCase {
    
    func testNavigateToMenu() {
        
        //given
        let vc = CartVCSpy()
        let presenter = CartPresenter()
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        presenter.menuButtonTapped()
        
        //then
        XCTAssertTrue(vc.navigateToMenuCalled)
    }
}
