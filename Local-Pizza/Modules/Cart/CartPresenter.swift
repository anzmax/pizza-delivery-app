//
//  CartPresenter.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 09.04.2024.
//

import UIKit

protocol CartPresenterProtocol: AnyObject {
    var view: CartVCProtocol? { get set }
    
    //View Event
    func viewWillAppear()
    func menuButtonTapped()
    func productCountChangedInCart(_ changedProduct: Product, _ itemsInCart: [Product])
    func priceButtonTapped(_ product: Product)
    
    //Business Logic
    func fetchProducts()
    func fetchDessertsAndDrinks()
    func calculateTotalAmountForProducts(_ itemsInCart: [Product]) -> Int
    func saveProductsInArchiver(_ itemsInCart: [Product])
    func appendProductToArchiver(_ product: Product)
    func removeProductFromArchiver(_ productToRemove: Product)
}

class CartPresenter: CartPresenterProtocol {
    
    weak var view: CartVCProtocol?
    
    var archiver: ProductsArchiverProtocol?
    //var archiver = ProductsArchiver()
   // var extrasService = ExtrasNetworkService()
    
    var extrasService: ExtrasNetworkServiceProtocol?
}

//MARK: - View Event
extension CartPresenter {

    func viewWillAppear() {
        fetchProducts()
        fetchDessertsAndDrinks()
    }
    
    func menuButtonTapped() {
        view?.navigateToMenu()
    }
    
    func productCountChangedInCart(_ changedProduct: Product, _ itemsInCart: [Product]) {
        
        var items = itemsInCart
        
        if let index = items.firstIndex(where: { $0.title == changedProduct.title}) {
            
            if changedProduct.count == 0 {
                items.remove(at: index)
            } else {
                items[index] = changedProduct
            }
            
            saveProductsInArchiver(items)

            self.fetchProducts()
        }
    }
    
    func priceButtonTapped(_ product: Product) {
        appendProductToArchiver(product)
        self.fetchProducts()
    }
}

//MARK: - Business Logic
extension CartPresenter {
    func removeProductFromArchiver(_ productToRemove: Product) {
        self.archiver?.remove(productToRemove)
    }
    
    func appendProductToArchiver(_ product: Product) {
        self.archiver?.append(product)
    }
    
    func saveProductsInArchiver(_ itemsInCart: [Product]) {
        self.archiver?.save(itemsInCart)
    }
    
    func fetchProducts() {
        if let products = archiver?.fetch() {
            view?.showItemsInCart(products)
        }
    }
    
    func fetchDessertsAndDrinks() {

        extrasService?.fetchProducts { result in
            switch result {
            case .success(let products):
                
                self.view?.showDessertsAndDrinks(products)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func calculateTotalAmountForProducts(_ itemsInCart: [Product]) -> Int {
        var sum = 0
        for item in itemsInCart {
            let price = item.totalPrice()
            sum += price * item.count
        }
        return sum
    }
}
