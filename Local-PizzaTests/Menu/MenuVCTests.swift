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
    
    var presenter: Local_Pizza.MenuPresenterProtocol?
    
    var showProductsCalled: Bool = false
    var showSpecialsCalled: Bool = false
    var showCategoriesCalled: Bool = false
    var showStoriesCalled: Bool = false
    var scrollTableViewToIndexPathCalled: Bool = false
    var navigateToProductDetailScreenCalled: Bool = false
    var navigateToAuthorizationScreenCalled: Bool = false
    var navigateToStoryDetailScreenCalled: Bool = false
    var navigateToPizzaMapScreenCalled: Bool = false
    var navigateToDeliveryMapScreenCalled: Bool = false
    
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
        
        //given
        let vc = MenuVCSpy()
        let presenter = MenuPresenter()
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        let product = Product.init(image: "pizza1", title: "", description: "", price: "")
        let products = [product]

        let index = 1
        presenter.categoryCellSelected(index, products)
        
        //then
        XCTAssertTrue(vc.scrollTableViewToIndexPathCalled)
    }
    
    func testNavigateToAuthorizationScreen() {
        
        //given
        let vc = MenuVCSpy()
        let presenter = MenuPresenter()
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        presenter.accountButtonTapped()
        
        //then
        XCTAssertTrue(vc.navigateToAuthorizationScreenCalled)
    }
    
    func testNavigateToProductDetailScreen() {
        
        //given
        let vc = MenuVCSpy()
        let presenter = MenuPresenter()
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        let product = Product.data
        presenter.productCellSelected(product)
        
        //then
        XCTAssertTrue(vc.navigateToProductDetailScreenCalled)
    }
    
    func testNavigateToStoryDetailScreen() {
        
        //given
        let vc = MenuVCSpy()
        let presenter = MenuPresenter()
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        let image = UIImage()
        presenter.storyCellSelected(image)
        
        //then
        XCTAssertTrue(vc.navigateToStoryDetailScreenCalled)
    }
    
    func testNavigateToPizzaMapScreen() {
        
        //given
        let vc = MenuVCSpy()
        let presenter = MenuPresenter()
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        let deliveryType = DeliveryType.takeAway
        presenter.addressSegmentChanged(deliveryType)
        
        //then
        XCTAssertTrue(vc.navigateToPizzaMapScreenCalled)
    }
    
    func testNavigateToDeliveryMapScreen() {
        
        //given
        let vc = MenuVCSpy()
        let presenter = MenuPresenter()
        vc.presenter = presenter
        presenter.view = vc
        
        //when
        let deliveryType = DeliveryType.address
        presenter.addressSegmentChanged(deliveryType)
        
        //then
        XCTAssertTrue(vc.navigateToDeliveryMapScreenCalled)
    }
}
