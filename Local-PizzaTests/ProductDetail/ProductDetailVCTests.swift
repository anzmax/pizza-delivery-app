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
    
    var presenter: (any Local_Pizza.ProductDetailPresenterProtocol)?
    
    var showIngredientsCalled: Bool = false
    var showProductDoughCalled: Bool = false
    var showProductSizeCalled: Bool = false
    var navigateToPreviousScreenCalled: Bool = false
    
    
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
        
        //given
        let vc = ProductDetailVCSpy()
        let presenter = ProductDetailPresenter()
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        let product = Product.data
        let index = 0
        presenter.doughCellSelected(index, product)
        
        //then
        XCTAssertTrue(vc.showProductDoughCalled)
    }
    
    func testShowProductSize() {
        
        //given
        let vc = ProductDetailVCSpy()
        let presenter = ProductDetailPresenter()
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        let product = Product.data
        let index = 0
        presenter.sizeCellSelected(index, product)
        
        //then
        XCTAssertTrue(vc.showProductSizeCalled)
    }
    
    func testNavigateToPreviousScreen() {
        
        //given
        let vc = ProductDetailVCSpy()
        let presenter = ProductDetailPresenter()
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        let button = UIButton()
        let product = Product.data
        presenter.cartButtonTapped(button, product)
        
        //then
        XCTAssertTrue(vc.navigateToPreviousScreenCalled)
    }
}
