//
//  MenuServicesTests.swift
//  Local-PizzaTests
//
//  Created by Lika Maksimovic on 16.04.2024.
//

@testable import Local_Pizza
import XCTest

//MARK: - Spy
class ProductServiceSpy: ProductNetworkServiceProtocol {
    
    var fetchProductCalled: Bool = false
    
    func fetchProducts(completion: @escaping (Result<[Local_Pizza.Product], Local_Pizza.NetworkError>) -> Void) {
        fetchProductCalled = true
    }
}

class SpecialsServiceSpy: SpecialsNetworkServiceProtocol {
    
    var fetchSpecialsCalled: Bool = false
    
    func fetchSpecials(completion: @escaping (Result<[Special], NetworkError>) -> Void) {
        fetchSpecialsCalled = true
    }
}

class CategoriesServiceSpy: CategoriesNetworkServiceProtocol {
    
    var fetchCategoriescalled: Bool = false
    
    func fetchCategory(completion: @escaping (Result<[Local_Pizza.Category], Local_Pizza.NetworkError>) -> Void) {
        fetchCategoriescalled = true
    }
}

class StoriesServiceSpy: StoriesNetworkServiceProtocol {
    
    var fetchStoriesCalled: Bool = false
    
    func fetchStory(completion: @escaping (Result<[Local_Pizza.Story], Local_Pizza.NetworkError>) -> Void) {
        fetchStoriesCalled = true
    }
}

class CoreDataServiceSpy: CoreDataServiceProtocol {
    
    var addProductToFavouritesCalled: Bool = false
    var fetchFavouriteProducts: Bool = false
    
    func addProductToFavourites(product: Local_Pizza.Product) {
        addProductToFavouritesCalled = true
    }
    
    func fetchFavouriteProducts(completion: @escaping ([Local_Pizza.Product]) -> Void) {
        fetchFavouriteProducts = true
    }
}

//MARK: - Tests
final class MenuServicesTests: XCTestCase {
    
    func testAddProductToFavorites() {
        
        //given
        let presenter = MenuPresenter()
        let coreDataService = CoreDataServiceSpy()
        
        let vc = FavouritesVC()
        let product = Product.data
        
        presenter.coreDataService = coreDataService
        
        //when
        presenter.addProductToFavorites(vc, product)
        
        //then
        XCTAssertTrue(coreDataService.addProductToFavouritesCalled)
        
    }
    
    func testFetchProducts() {
        
        let presenter = MenuPresenter()
        let productService = ProductServiceSpy()
        
        presenter.productsService = productService
        presenter.fetchProducts()
        
        XCTAssertTrue(productService.fetchProductCalled)
    }
    
    func testFetchSpecials() {
        
        let presenter = MenuPresenter()
        let specialsService = SpecialsServiceSpy()
        
        presenter.specialsService = specialsService
        presenter.fetchSpecials()
        
        XCTAssertTrue(specialsService.fetchSpecialsCalled)
    }
    
    func testFetchCategories() {
        
        let presenter = MenuPresenter()
        let categoriesService = CategoriesServiceSpy()
        
        presenter.categoriesService = categoriesService
        presenter.fetchCategories()
        
        XCTAssertTrue(categoriesService.fetchCategoriescalled)
    }
    
    func testFetchStories() {
        
        let presenter = MenuPresenter()
        let storiesService = StoriesServiceSpy()
        
        presenter.storiesService = storiesService
        presenter.fetchStories()
        
        XCTAssertTrue(storiesService.fetchStoriesCalled)
    }
}
