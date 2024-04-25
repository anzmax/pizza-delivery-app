//
//  CartPresenerTests.swift
//  Local-PizzaTests
//
//  Created by Lika Maksimovic on 19.04.2024.
//

@testable import Local_Pizza
import XCTest

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
}

//MARK: - Tests
final class CartPresenterTests: XCTestCase {
    
    func testViewWillAppear() {
        
        //given
        let vc = CartVC()
        let presenter = CartPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        vc.viewWillAppear(true)
        
        //then
        XCTAssertTrue(presenter.viewWillAppearCalled)
    }
    
    func testMenuButtonTapped() {
        
        //given
        let vc = CartVC()
        let presenter = CartPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        vc.menuButtonTapped()
        
        //then
        XCTAssertTrue(presenter.menuButtonTappedCalled)
    }
    
    func testProductCountChangedInCart() {
        
        //given
        let vc = CartVC()
        let presenter = CartPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        let product = Product.data
        vc.productCellCountChanged(product)
        
        //then
        XCTAssertTrue(presenter.productCountChangedInCartCalled)
    }
    
    func testPriceButtonTapped() {
        
        //given
        let vc = CartVC()
        let presenter = CartPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        let product = Product.data
        vc.priceButtonTapped(product)
        
        //then
        XCTAssertTrue(presenter.priceButtonTappedCalled)
    }
    
    func testCalculateTotalAmountForProducts() {
        
        //given
        let vc = CartVC()
        let presenter = CartPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        let products = [Product.data]
        vc.showItemsInCart(products)
        
        //then
        XCTAssertTrue(presenter.calculateTotalAmountForProductsCalled)
    }
}
