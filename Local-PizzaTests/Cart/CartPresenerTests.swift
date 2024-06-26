//
//  CartPresenerTests.swift
//  Local-PizzaTests
//
//  Created by Lika Maksimovic on 19.04.2024.
//

@testable import Local_Pizza
import XCTest

//MARK: - Spy
class CartPresenterSpy: CartPresenterProtocol {

    var view: CartVCProtocol?
    
    var viewWillAppearCalled = false
    var menuButtonTappedCalled = false
    var productCountChangedInCartCalled = false
    var priceButtonTappedCalled = false
    var fetchProductsCalled = false
    var fetchDessertsAndDrinksCalled = false
    var calculateTotalAmountForProductsCalled = false
    var saveProductsInArchiverCalled = false
    var appendProductToArchiverCalled = false
    var removeProductFromArchiverCalled = false
    var paymentButtonTappedCalled = false
    
    func viewWillAppear() {
        viewWillAppearCalled = true
    }
    
    func menuButtonTapped() {
        menuButtonTappedCalled = true
    }
    
    func productCountChangedInCart(_ changedProduct: Local_Pizza.Product, _ itemsInCart: [Local_Pizza.Product]) {
        productCountChangedInCartCalled = true
    }
    
    func priceButtonTapped(_ product: Local_Pizza.Product) {
        priceButtonTappedCalled = true
    }
    
    func fetchProducts() {
        fetchProductsCalled = true
    }
    
    func fetchDessertsAndDrinks() {
        fetchDessertsAndDrinksCalled = true
    }
    
    func calculateTotalAmountForProducts(_ itemsInCart: [Local_Pizza.Product]) -> Int {
        calculateTotalAmountForProductsCalled = true
        return 0
    }
    
    func saveProductsInArchiver(_ itemsInCart: [Local_Pizza.Product]) {
        saveProductsInArchiverCalled = true
    }
    
    func appendProductToArchiver(_ product: Local_Pizza.Product) {
        appendProductToArchiverCalled = true
    }
    
    func removeProductFromArchiver(_ productToRemove: Local_Pizza.Product) {
        removeProductFromArchiverCalled = true
    }
    
    func paymentButtonTapped() {
        paymentButtonTappedCalled = true
    }
}

//MARK: - Tests
final class CartPresenterTests: XCTestCase {
    
    func testViewWillAppear() {
        let vc = CartVC()
        let presenter = CartPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc

        vc.viewWillAppear(true)

        XCTAssertTrue(presenter.viewWillAppearCalled)
    }
    
    func testMenuButtonTapped() {
        let vc = CartVC()
        let presenter = CartPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc

        vc.menuButtonTapped()

        XCTAssertTrue(presenter.menuButtonTappedCalled)
    }
    
    func testProductCountChangedInCart() {
        let vc = CartVC()
        let presenter = CartPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc

        let product = Product.data
        vc.productCellCountChanged(product)

        XCTAssertTrue(presenter.productCountChangedInCartCalled)
    }
    
    func testPriceButtonTapped() {
        let vc = CartVC()
        let presenter = CartPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc

        let product = Product.data
        vc.priceButtonTapped(product)

        XCTAssertTrue(presenter.priceButtonTappedCalled)
    }
    
    func testCalculateTotalAmountForProducts() {
        let vc = CartVC()
        let presenter = CartPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc

        let products = [Product.data]
        vc.showItemsInCart(products)
 
        XCTAssertTrue(presenter.calculateTotalAmountForProductsCalled)
    }
    
    func testPaymentButtonTapped() {
        let vc = CartVC()
        let presenter = CartPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
        
        vc.paymentButtonAction()
        
        XCTAssertTrue(presenter.paymentButtonTappedCalled)
    }
}
