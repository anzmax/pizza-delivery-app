//
//  ProductDetailPresenterTests.swift
//  Local-PizzaTests
//
//  Created by Lika Maksimovic on 16.04.2024.
//

@testable import Local_Pizza
import XCTest

//MARK: - Spy
class ProductDetailPresenterSpy: ProductDetailPresenterProtocol {
    
    var view: ProductDetailVCProtocol?
    
    var viewDidLoadCalled = false
    var cartButtonTappedCalled = false
    var doughCellSelectedCalled = false
    var sizeCellSelectedCalled = false
    var fetchIngredientsCalled = false
    
    func viewDidLoad() {
        viewDidLoadCalled = true
    }
    
    func cartButtonTapped(_ button: UIButton, _ product: Local_Pizza.Product?) {
        cartButtonTappedCalled = true
    }
    
    func doughCellSelected(_ index: Int, _ product: Local_Pizza.Product) {
        doughCellSelectedCalled = true
    }
    
    func sizeCellSelected(_ index: Int, _ product: Local_Pizza.Product) {
        sizeCellSelectedCalled = true
    }
    
    func fetchIngredients() {
        fetchIngredientsCalled = true
    }
}

//MARK: - Tests
final class ProductDetailPresenterTests: XCTestCase {
    
    func testViewDidLoad() {
        let vc = ProductDetailVC()
        let presenter = ProductDetailPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc

        _ = vc.view

        XCTAssertTrue(presenter.viewDidLoadCalled)
    }
    
    func testCartButtonTapped() {
        let vc = ProductDetailVC()
        let presenter = ProductDetailPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
        
        let button = UIButton()
        vc.cartButtonTapped(button)
        
        XCTAssertTrue(presenter.cartButtonTappedCalled)
    }
    
    func testDoughCellSelected() {
        let vc = ProductDetailVC()
        let presenter = ProductDetailPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
 
        let index = 0
        let product = Product.data
        vc.doughCellSelected(index, product)
  
        XCTAssertTrue(presenter.doughCellSelectedCalled)
    }
    
    func testSizeCellSelected() {
        let vc = ProductDetailVC()
        let presenter = ProductDetailPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
 
        let index = 0
        let product = Product.data
        vc.sizeCellSelected(index, product)

        XCTAssertTrue(presenter.sizeCellSelectedCalled)
    }
}

