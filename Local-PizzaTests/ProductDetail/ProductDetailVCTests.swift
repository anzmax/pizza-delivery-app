//
//  ProductDetailVCTests.swift
//  Local-PizzaTests
//
//  Created by Lika Maksimovic on 16.04.2024.
//

@testable import Local_Pizza
import XCTest

//MARK: - Spy
class ProductDetailVCSpy: ProductDetailVCProtocol {
    
    var presenter: ProductDetailPresenterProtocol?
    
    var showIngredientsCalled = false
    var showProductDoughCalled = false
    var showProductSizeCalled = false
    var navigateToPreviousScreenCalled = false
    
    
    func showIngredients(_ ingredients: [Local_Pizza.Ingredient]) {
        showIngredientsCalled = true
    }
    
    func showProductDough(_ index: Int) {
        showProductDoughCalled = true
    }
    
    func showProductSize(_ index: Int) {
        showProductSizeCalled = true
    }
    
    func navigateToPreviousScreen() {
        navigateToPreviousScreenCalled = true
    }
}

//MARK: - Tests
final class ProductDetailVCTests: XCTestCase {
    
    func testShowProductDough() {
        let vc = ProductDetailVCSpy()
        let presenter = ProductDetailPresenter()
        vc.presenter = presenter
        presenter.view = vc

        let product = Product.data
        let index = 0
        presenter.doughCellSelected(index, product)
 
        XCTAssertTrue(vc.showProductDoughCalled)
    }
    
    func testShowProductSize() {
        let vc = ProductDetailVCSpy()
        let presenter = ProductDetailPresenter()
        vc.presenter = presenter
        presenter.view = vc

        let product = Product.data
        let index = 0
        presenter.sizeCellSelected(index, product)

        XCTAssertTrue(vc.showProductSizeCalled)
    }
    
    func testNavigateToPreviousScreen() {
        let vc = ProductDetailVCSpy()
        let presenter = ProductDetailPresenter()
        vc.presenter = presenter
        presenter.view = vc

        let button = UIButton()
        let product = Product.data
        presenter.cartButtonTapped(button, product)

        XCTAssertTrue(vc.navigateToPreviousScreenCalled)
    }
}
