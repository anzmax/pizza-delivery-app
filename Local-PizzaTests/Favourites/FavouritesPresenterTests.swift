//
//  FavouritesPresenterTests.swift
//  Local-PizzaTests
//
//  Created by Lika Maksimovic on 22.04.2024.
//

@testable import Local_Pizza
import XCTest

//MARK: - Spy
class FavouritesPresenterSpy: FavouritesPresenterProtocol {
    
    var view: FavouritesVCProtocol?
    
    var viewWillAppearCalled = false
    var updateFavoritesInDataBaseCalled = false
    var cellPriceButtonTappedCalled = false
    var loadFavouriteProductsCalled = false
    var productCellSwipeToDeleteCalled = false
    
    func viewWillAppear() {
        viewWillAppearCalled = true
    }
    
    func updateFavoritesInDataBase() {
        updateFavoritesInDataBaseCalled = true
    }
    
    func cellPriceButtonTapped(_ product: Local_Pizza.Product) {
        cellPriceButtonTappedCalled = true
    }
    
    func productCellSwipeToDelete(_ index: IndexPath, _ product: Local_Pizza.Product) {
        productCellSwipeToDeleteCalled = true
    }
    
    func loadFavouriteProducts() {
        loadFavouriteProductsCalled = true
    }
}

//MARK: - Tests
final class FavouritesPresenterTests: XCTestCase {
    
    func testViewWillAppear() {
        let vc = FavouritesVC()
        let presenter = FavouritesPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
        
        vc.viewWillAppear(true)
        
        XCTAssertTrue(presenter.viewWillAppearCalled)
    }
    
    func testUpdateFavoritesInDataBase() {
        let vc = FavouritesVC()
        let presenter = FavouritesPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
        
        vc.updateFavorites()
        
        XCTAssertTrue(presenter.updateFavoritesInDataBaseCalled)
    }
    
    func testCellPriceButtonTapped() {
        let vc = FavouritesVC()
        let presenter = FavouritesPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
        
        let product = Product.data
        vc.cellPriceButtonTapped(product)
        
        XCTAssertTrue(presenter.cellPriceButtonTappedCalled)
    }
    
    func testProductCellSwipeToDelete() {
        let vc = FavouritesVC()
        let presenter = FavouritesPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
        
        let product = Product.data
        let indexPath = IndexPath(row: 1, section: 1)
        vc.swipeToDeleteProduct(indexPath, product)
        
        XCTAssertTrue(presenter.productCellSwipeToDeleteCalled)
    }
}
