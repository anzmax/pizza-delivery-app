//
//  MenuServicesTests.swift
//  Local-PizzaTests
//
//  Created by Lika Maksimovic on 16.04.2024.
//

@testable import Local_Pizza
import XCTest
import CoreData

//MARK: - Spy
class ProductServiceSpy: ProductNetworkServiceProtocol {
    
    var fetchProductCalled = false
    
    func fetchProducts(completion: @escaping (Result<[Local_Pizza.Product], Local_Pizza.NetworkError>) -> Void) {
        fetchProductCalled = true
    }
}

class SpecialsServiceSpy: SpecialsNetworkServiceProtocol {
    
    var fetchSpecialsCalled = false
    
    func fetchSpecials(completion: @escaping (Result<[Special], NetworkError>) -> Void) {
        fetchSpecialsCalled = true
    }
}

class CategoriesServiceSpy: CategoriesNetworkServiceProtocol {
    
    var fetchCategoriescalled = false
    
    func fetchCategory(completion: @escaping (Result<[Local_Pizza.Category], Local_Pizza.NetworkError>) -> Void) {
        fetchCategoriescalled = true
    }
}

class StoriesServiceSpy: StoriesNetworkServiceProtocol {
    
    var fetchStoriesCalled = false
    
    func fetchStory(completion: @escaping (Result<[Local_Pizza.Story], Local_Pizza.NetworkError>) -> Void) {
        fetchStoriesCalled = true
    }
}

class CoreDataServiceSpy: CoreDataServiceProtocol {
    
    var persistentContainer: NSPersistentContainer {
        return NSPersistentContainer()
    }

    var addProductToFavouritesCalled = false
    var fetchFavouriteProductsCalled = false
    var deleteFavouriteProductCalled = false
    var saveContextCalled = false
    
    func addProductToFavourites(product: Local_Pizza.Product) {
        addProductToFavouritesCalled = true
    }
    
    func fetchFavouriteProducts(completion: @escaping ([Local_Pizza.Product]) -> Void) {
        fetchFavouriteProductsCalled = true
    }
    
    func deleteFavouriteProduct(product: Local_Pizza.Product, context: NSManagedObjectContext) {
        deleteFavouriteProductCalled = true
    }
    
    func saveContext(backgroundContext: NSManagedObjectContext?) {
        saveContextCalled = true
    }
    
}

//MARK: - Tests
final class MenuServicesTests: XCTestCase {
    
    func testAddProductToFavorites() {
        let presenter = MenuPresenter()
        let coreDataService = CoreDataServiceSpy()
        let vc = FavouritesVC()
        
        presenter.coreDataService = coreDataService
        let product = Product.data
  
        presenter.addProductToFavorites(vc, product)

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
