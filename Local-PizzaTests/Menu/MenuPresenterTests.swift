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
    
    var view: Local_Pizza.MenuVCProtocol?
    
    var viewDidLoadCalled: Bool = false
    var accountButtonTappedCalled: Bool = false
    var productPriceButtonTappedCalled: Bool = false
    var productCellSelectedCalled: Bool = false
    var addressSegmentChangedCalled: Bool = false
    var addressButtonTappedCalled: Bool = false
    var categoryCellSelectedCalled: Bool = false
    var favouriteButtonTappedCalled: Bool = false
    var fetchProductsCalled: Bool = false
    var fetchSpecialsCalled: Bool = false
    var fetchStoriesCalled: Bool = false
    var fetchCategoriesCalled: Bool = false
    var addProductToFavoritesCalled: Bool = false
    var storyCellSelectedCalled: Bool = false
    
    
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
        
        //given
        let vc = MenuVC()
        let presenter = MenuPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        _ = vc.view
        
        //then
        XCTAssertTrue(presenter.viewDidLoadCalled)
    }
    
    func testAccountButtonTapped() {
        
        //given
        let vc = MenuVC()
        let presenter = MenuPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        vc.accountButtonTapped()
        
        //then
        XCTAssertTrue(presenter.accountButtonTappedCalled)
    }
    
    func testProductPriceButtonTapped() {
        
        //given
        let vc = MenuVC()
        let presenter = MenuPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        let product = Product.data
        
        vc.productCellPriceButtonTapped(product)
        
        //then
        XCTAssertTrue(presenter.productPriceButtonTappedCalled)
    }
    
    func testProductCellSelected() {
        
        //given
        let vc = MenuVC()
        let presenter = MenuPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        let product = Product.data
        vc.productCellSelected(product)
        
        //then
        XCTAssertTrue(presenter.productCellSelectedCalled)
    }
    
    func testAddressSegmentChanged() {
        
        //given
        let vc = MenuVC()
        let presenter = MenuPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        let deliveryType = DeliveryType.takeAway
        vc.addressTypeSegmentChanged(deliveryType)
        
        //then
        XCTAssertTrue(presenter.addressSegmentChangedCalled)
    }
    
    func testAddressButtonTapped() {
        
        //given
        let vc = MenuVC()
        let presenter = MenuPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        vc.addressButtonSelected()
        
        //then
        XCTAssertTrue(presenter.addressButtonTappedCalled)
    }
    
    func testCategoryCellSelected() {
        
        //given
        let vc = MenuVC()
        let presenter = MenuPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        vc.categoryCellTapped(0)
        
        //then
        XCTAssertTrue(presenter.categoryCellSelectedCalled)
    }
    
    func testFavouriteButtonTapped() {
        
        //given
        let vc = MenuVC()
        let presenter = MenuPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        let product = Product.data
        let favVC = FavouritesVC()
        vc.favouriteButtonSelected(favVC, product)
        
        //then
        XCTAssertTrue(presenter.favouriteButtonTappedCalled)
    }
}
