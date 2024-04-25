//
//  FavouritesVCTests.swift
//  Local-PizzaTests
//
//  Created by Lika Maksimovic on 22.04.2024.
//

@testable import Local_Pizza
import XCTest

//MARK: - Spy
class FavouritesVCSpy: FavouritesVCProtocol {
    
    var presenter: FavouritesPresenterProtocol?
    
    var showFavouriteProductsCalled = false
    var updateFavouritesUICalled = false
    var deleteFavouriteInTableCalled = false
    
    func showFavouriteProducts(_ products: [Local_Pizza.Product]) {
        showFavouriteProductsCalled = true
    }
    
    func updateFavouritesUI() {
        updateFavouritesUICalled = true
    }
    
    func deleteFavouriteInTable(_ indexPath: IndexPath, _ product: Local_Pizza.Product) {
        deleteFavouriteInTableCalled = true
    }
}

//MARK: - Tests
final class FavouritesVCTests: XCTestCase {
    
    func testUpdateFavouritesUI() {
        let vc = FavouritesVCSpy()
        let presenter = FavouritesPresenter()
        vc.presenter = presenter
        presenter.view = vc
        
        presenter.viewWillAppear()
        
        XCTAssertTrue(vc.updateFavouritesUICalled)
    }
}
