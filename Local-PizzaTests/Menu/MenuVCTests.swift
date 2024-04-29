//
//  MenuVCTests.swift
//  Local-PizzaTests
//
//  Created by Lika Maksimovic on 16.04.2024.
//

@testable import Local_Pizza
import XCTest

//MARK: - Spy
class MenuVCSpy: MenuVCProtocol {
    
    var presenter: MenuPresenterProtocol?
    
    var showProductsCalled = false
    var showSpecialsCalled = false
    var showCategoriesCalled = false
    var showStoriesCalled = false
    var scrollTableViewToIndexPathCalled = false
    var navigateToProductDetailScreenCalled = false
    var navigateToAuthorizationScreenCalled = false
    var navigateToStoryDetailScreenCalled = false
    var navigateToPizzaMapScreenCalled = false
    var navigateToDeliveryMapScreenCalled = false
    
    func showProducts(_ products: [Local_Pizza.Product]) {
        showProductsCalled = true
    }
    
    func showSpecials(_ specials: [Local_Pizza.Special]) {
        showSpecialsCalled = true
    }
    
    func showCategories(_ categories: [Local_Pizza.Category]) {
        showCategoriesCalled = true
    }
    
    func showStories(_ stories: [Local_Pizza.Story]) {
        showStoriesCalled = true
    }
    
    func scrollTableViewToIndexPath(_ indexPath: IndexPath, _ productIndex: Int) {
        scrollTableViewToIndexPathCalled = true
    }
    
    func navigateToProductDetailScreen(_ product: Local_Pizza.Product) {
        navigateToProductDetailScreenCalled = true
    }
    
    func navigateToAuthorizationScreen() {
        navigateToAuthorizationScreenCalled = true
    }
    
    func navigateToStoryDetailScreen(_ image: UIImage) {
        navigateToStoryDetailScreenCalled = true
    }
    
    func navigateToPizzaMapScreen() {
        navigateToPizzaMapScreenCalled = true
    }
    
    func navigateToDeliveryMapScreen() {
        navigateToDeliveryMapScreenCalled = true
        
    }
}

//MARK: - Tests
final class MenuVCTests: XCTestCase {
    
    func testScrollTableViewToIndexPath() {
        let vc = MenuVCSpy()
        let presenter = MenuPresenter()
        vc.presenter = presenter
        presenter.view = vc

        let product = Product.init(image: "pizza1", title: "", description: "", price: "")
        let products = [product]

        let index = 1
        presenter.categoryCellSelected(index, products)

        XCTAssertTrue(vc.scrollTableViewToIndexPathCalled)
    }
    
    func testNavigateToAuthorizationScreen() {
        let vc = MenuVCSpy()
        let presenter = MenuPresenter()
        vc.presenter = presenter
        presenter.view = vc

        presenter.accountButtonTapped()

        XCTAssertTrue(vc.navigateToAuthorizationScreenCalled)
    }
    
    func testNavigateToProductDetailScreen() {
        let vc = MenuVCSpy()
        let presenter = MenuPresenter()
        vc.presenter = presenter
        presenter.view = vc
        
        let product = Product.data
        presenter.productCellSelected(product)

        XCTAssertTrue(vc.navigateToProductDetailScreenCalled)
    }
    
    func testNavigateToStoryDetailScreen() {
        let vc = MenuVCSpy()
        let presenter = MenuPresenter()
        vc.presenter = presenter
        presenter.view = vc

        let image = UIImage()
        presenter.storyCellSelected(image)

        XCTAssertTrue(vc.navigateToStoryDetailScreenCalled)
    }
    
    func testNavigateToPizzaMapScreen() {
        let vc = MenuVCSpy()
        let presenter = MenuPresenter()
        vc.presenter = presenter
        presenter.view = vc

        let deliveryType = DeliveryType.takeAway
        presenter.addressSegmentChanged(deliveryType)

        XCTAssertTrue(vc.navigateToPizzaMapScreenCalled)
    }
    
    func testNavigateToDeliveryMapScreen() {
        let vc = MenuVCSpy()
        let presenter = MenuPresenter()
        vc.presenter = presenter
        presenter.view = vc

        let deliveryType = DeliveryType.address
        presenter.addressSegmentChanged(deliveryType)

        XCTAssertTrue(vc.navigateToDeliveryMapScreenCalled)
    }
}
