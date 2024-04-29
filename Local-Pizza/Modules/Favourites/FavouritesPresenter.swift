//
//  FavouritesPresenter.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 05.04.2024.
//

import UIKit

protocol FavouritesPresenterProtocol: AnyObject {
    
    var view: FavouritesVCProtocol? { get set }
    
    func viewWillAppear()
    func updateFavoritesInDataBase()
    func cellPriceButtonTapped(_ product: Product)
    func productCellSwipeToDelete(_ index: IndexPath, _ product: Product)
    
    func loadFavouriteProducts()
}

final class FavouritesPresenter: FavouritesPresenterProtocol {
    
    weak var view: FavouritesVCProtocol?
    
    var archiver: ProductsArchiverProtocol?
    var coreDataService: CoreDataServiceProtocol?
}

//MARK: - View Event
extension FavouritesPresenter {
    
    func viewWillAppear() {
        loadFavouriteProducts()
        self.view?.updateFavouritesUI()
    }
    
    func updateFavoritesInDataBase() {
        coreDataService?.fetchFavouriteProducts { [weak self] products in
            
            self?.view?.showFavouriteProducts(products)
        }
    }
    
    func cellPriceButtonTapped(_ product: Product) {
        self.archiver?.append(product)
    }
    
    func productCellSwipeToDelete(_ indexPath: IndexPath, _ product: Product) {
        
        coreDataService?.persistentContainer.performBackgroundTask { backgroundContext in
            
            self.coreDataService?.deleteFavouriteProduct(product: product, context: backgroundContext)
            
            DispatchQueue.main.async {
                self.view?.deleteFavouriteInTable(indexPath, product)
            }
        }
    }
}

//Business Logic
extension FavouritesPresenter {
    
    func loadFavouriteProducts() {
        coreDataService?.fetchFavouriteProducts { [weak self] products in
            self?.view?.showFavouriteProducts(products)
        }
    }
}
