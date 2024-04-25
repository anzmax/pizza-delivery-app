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
    
    var viewDidLoadCalled: Bool = false
    var cartButtonTappedCalled: Bool = false
    var doughCellSelectedCalled: Bool = false
    var sizeCellSelectedCalled: Bool = false
    var fetchIngredientsCalled: Bool = false
    
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
        
        //given
        let vc = ProductDetailVC()
        let presenter = ProductDetailPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        _ = vc.view
        
        //then
        XCTAssertTrue(presenter.viewDidLoadCalled)
    }
    
    func testCartButtonTapped() {
        
        //given
        let vc = ProductDetailVC()
        let presenter = ProductDetailPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        let button = UIButton()
        vc.cartButtonTapped(button)
        
        //then
        XCTAssertTrue(presenter.cartButtonTappedCalled)
        }
    
    func testDoughCellSelected() {
        
        //given
        let vc = ProductDetailVC()
        let presenter = ProductDetailPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        let index = 0
        let product = Product.data
        vc.doughCellSelected(index, product)
        
        //then
        XCTAssertTrue(presenter.doughCellSelectedCalled)
    }
    
    func testSizeCellSelected() {
        
        //given
        let vc = ProductDetailVC()
        let presenter = ProductDetailPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        let index = 0
        let product = Product.data
        vc.sizeCellSelected(index, product)
        
        //then
        XCTAssertTrue(presenter.sizeCellSelectedCalled)
    }
}

