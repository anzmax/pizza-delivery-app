//
//  MenuPresenterTests.swift
//  Local-PizzaTests
//
//  Created by Lika Maksimovic on 16.04.2024.
//

@testable import Local_Pizza
import XCTest

//MARK: - Spy
class MenuPresenterSpy: MenuPresenterProtocol {
    
    var view: MenuVCProtocol?
    
    var viewDidLoadCalled = false
    var accountButtonTappedCalled = false
    var productPriceButtonTappedCalled = false
    var productCellSelectedCalled = false
    var addressSegmentChangedCalled = false
    var addressButtonTappedCalled = false
    var categoryCellSelectedCalled = false
    var favouriteButtonTappedCalled = false
    var fetchProductsCalled = false
    var fetchSpecialsCalled = false
    var fetchStoriesCalled = false
    var fetchCategoriesCalled = false
    var addProductToFavoritesCalled = false
    var storyCellSelectedCalled = false
    
    
    func viewDidLoad() {
        viewDidLoadCalled = true
        fetchProductsCalled = true
        fetchSpecialsCalled = true
        fetchStoriesCalled = true
        fetchCategoriesCalled = true
    }
    
    func accountButtonTapped() {
        accountButtonTappedCalled = true
    }
    
    func productPriceButtonTapped(_ product: Local_Pizza.Product) {
        productPriceButtonTappedCalled = true
    }
    
    func productCellSelected(_ product: Local_Pizza.Product) {
        productCellSelectedCalled = true
    }
    
    func addressSegmentChanged(_ deliveryType: Local_Pizza.DeliveryType) {
        addressSegmentChangedCalled = true
    }
    
    func addressButtonTapped() {
        addressButtonTappedCalled = true
    }
    
    func categoryCellSelected(_ index: Int, _ products: [Local_Pizza.Product]) {
        categoryCellSelectedCalled = true
    }
    
    func favouriteButtonTapped(_ favouritesVC: Local_Pizza.FavouritesVC, _ product: Local_Pizza.Product) {
        favouriteButtonTappedCalled = true
    }
    
    func fetchProducts() {
        fetchProductsCalled = true
    }
    
    func fetchSpecials() {
        fetchSpecialsCalled = true
    }
    
    func fetchStories() {
        fetchStoriesCalled = true
    }
    
    func fetchCategories() {
        fetchCategoriesCalled = true
    }
    
    func addProductToFavorites(_ favouritesVC: Local_Pizza.FavouritesVC, _ product: Local_Pizza.Product) {
        addProductToFavoritesCalled = true
    }
    
    func storyCellSelected(_ image: UIImage?) {
        storyCellSelectedCalled = true
    }
}

//MARK: - Tests
final class MenuPresenterTests: XCTestCase {
    
    func testViewControllerCallsViewDidLoad() {
        let vc = MenuVC()
        let presenter = MenuPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc

        _ = vc.view

        XCTAssertTrue(presenter.viewDidLoadCalled)
    }
    
    func testAccountButtonTapped() {
        let vc = MenuVC()
        let presenter = MenuPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
  
        vc.accountButtonTapped()

        XCTAssertTrue(presenter.accountButtonTappedCalled)
    }
    
    func testProductPriceButtonTapped() {
        let vc = MenuVC()
        let presenter = MenuPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc

        let product = Product.data
        vc.productCellPriceButtonTapped(product)

        XCTAssertTrue(presenter.productPriceButtonTappedCalled)
    }
    
    func testProductCellSelected() {
        let vc = MenuVC()
        let presenter = MenuPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc

        let product = Product.data
        vc.productCellSelected(product)
 
        XCTAssertTrue(presenter.productCellSelectedCalled)
    }
    
    func testAddressSegmentChanged() {
        let vc = MenuVC()
        let presenter = MenuPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc

        let deliveryType = DeliveryType.takeAway
        vc.addressTypeSegmentChanged(deliveryType)

        XCTAssertTrue(presenter.addressSegmentChangedCalled)
    }
    
    func testAddressButtonTapped() {
        let vc = MenuVC()
        let presenter = MenuPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc

        vc.addressButtonSelected()

        XCTAssertTrue(presenter.addressButtonTappedCalled)
    }
    
    func testCategoryCellSelected() {
        let vc = MenuVC()
        let presenter = MenuPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc

        vc.categoryCellTapped(0)

        XCTAssertTrue(presenter.categoryCellSelectedCalled)
    }
    
    func testFavouriteButtonTapped() {
        let vc = MenuVC()
        let presenter = MenuPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc

        let product = Product.data
        let favVC = FavouritesVC()
        vc.favouriteButtonSelected(favVC, product)

        XCTAssertTrue(presenter.favouriteButtonTappedCalled)
    }
}
