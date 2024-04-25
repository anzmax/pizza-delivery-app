//
//  ProductDetailServicesTests.swift
//  Local-PizzaTests
//
//  Created by Lika Maksimovic on 16.04.2024.
//

@testable import Local_Pizza
import XCTest

//MARK: - Spy

class IngredientsNetworkServiceSpy: IngredientsNetworkServiceProtocol {
    
    var fetchIngredientsCalled: Bool = false
    
    func fetchIngredients(completion: @escaping (Result<[Local_Pizza.Ingredient], Local_Pizza.NetworkError>) -> Void) {
        fetchIngredientsCalled = true
    }
}

final class ProductDetailServicesTests: XCTestCase {
    
    func testFetchIngredients() {
        let presenter = ProductDetailPresenter()
        let service = IngredientsNetworkServiceSpy()

        presenter.ingredientsService = service
        presenter.fetchIngredients()
        
        XCTAssertTrue(service.fetchIngredientsCalled)
    }
}
