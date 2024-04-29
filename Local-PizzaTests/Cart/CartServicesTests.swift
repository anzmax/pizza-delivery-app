//
//  CartServicesTests.swift
//  Local-PizzaTests
//
//  Created by Lika Maksimovic on 19.04.2024.
//

@testable import Local_Pizza
import XCTest

//MARK: - Spy
class ProductsArchiverSpy: ProductsArchiverProtocol {
    
    var saveCalled = false
    var fetchCalled = false
    var appendCalled = false
    var removeCalled = false
    
    func save(_ products: [Local_Pizza.Product]) {
        saveCalled = true
    }
    
    func fetch() -> [Local_Pizza.Product] {
        fetchCalled = true
        return []
    }
    
    func append(_ product: Local_Pizza.Product) {
        appendCalled = true
    }
    
    func remove(_ product: Local_Pizza.Product) {
        removeCalled = true
    }
}

class ExtrasNetworkServiceSpy: ExtrasNetworkServiceProtocol {
    
    var fetchProductsCalled = false
    
    func fetchProducts(completion: @escaping (Result<[Local_Pizza.Product], Local_Pizza.NetworkError>) -> Void) {
        fetchProductsCalled = true
    }
}

//MARK: - Tests
class ProductsArchiverTests: XCTestCase {
    
    func testSave() {
        let presenter = CartPresenter()
        let service = ProductsArchiverSpy()

        presenter.archiver = service
        let products = [Product.data]
        presenter.saveProductsInArchiver(products)
        
        XCTAssertTrue(service.saveCalled)
    }
    
    func testFetch() {
        let presenter = CartPresenter()
        let service = ProductsArchiverSpy()

        presenter.archiver = service
        presenter.fetchProducts()
        
        XCTAssertTrue(service.fetchCalled)
    }
    
    func testAppend() {
        let presenter = CartPresenter()
        let service = ProductsArchiverSpy()

        presenter.archiver = service
        let product = Product.data
        presenter.appendProductToArchiver(product)
        
        XCTAssertTrue(service.appendCalled)
    }
    
    func testRemove() {
        let presenter = CartPresenter()
        let service = ProductsArchiverSpy()
        
        presenter.archiver = service
        let product = Product.data
        presenter.removeProductFromArchiver(product)
        
        XCTAssertTrue(service.removeCalled)
    }
    
    func testFetchProducts() {
        let presenter = CartPresenter()
        let service = ProductsArchiverSpy()
        
        presenter.archiver = service
        presenter.fetchProducts()
        
        XCTAssertTrue(service.fetchCalled)
    }
}

class ExtrasNetworkServiceTests: XCTestCase {
    
    func testFetchProducts() {
        let presenter = CartPresenter()
        let service = ExtrasNetworkServiceSpy()
        
        presenter.extrasService = service
        presenter.fetchDessertsAndDrinks()
        
        XCTAssertTrue(service.fetchProductsCalled)
    }
}
