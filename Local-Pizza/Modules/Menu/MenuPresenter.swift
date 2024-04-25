//
//  MenuPresenter.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 29.03.2024.
//

import UIKit


protocol MenuPresenterProtocol: AnyObject {
    
    //Connections
    var view: MenuVCProtocol? { get set }
    
    //View Event
    func viewDidLoad()
    func accountButtonTapped()
    func productPriceButtonTapped(_ product: Product)
    func productCellSelected(_ product: Product)
    func addressSegmentChanged(_ deliveryType: DeliveryType)
    func addressButtonTapped()
    func categoryCellSelected(_ index: Int, _ products: [Product])
    func favouriteButtonTapped(_ favouritesVC: FavouritesVC, _ product: Product)
    func storyCellSelected(_ image: UIImage?)
    
    //Business Logic
    func fetchProducts()
    func fetchSpecials()
    func fetchStories()
    func fetchCategories()
    func addProductToFavorites(_ favouritesVC: FavouritesVC, _ product: Product)
    
    
}

final class MenuPresenter: MenuPresenterProtocol {
    
    weak var view: MenuVCProtocol?
    
    //MARL: - Services
    var archiver = ProductsArchiver()
    var coreDataService: CoreDataServiceProtocol?
    var productsService: ProductNetworkServiceProtocol?
    var storiesService: StoriesNetworkServiceProtocol?
    var specialsService: SpecialsNetworkServiceProtocol?
    var categoriesService: CategoriesNetworkServiceProtocol?
}

//MARK: - View Event
extension MenuPresenter {
    
    func viewDidLoad() {
        fetchProducts()
        fetchSpecials()
        fetchStories()
        fetchCategories()
    }
    
    func favouriteButtonTapped(_ favouritesVC: FavouritesVC, _ product: Product) {
        
        addProductToFavorites(favouritesVC, product)
    }
    
    func categoryCellSelected(_ index: Int, _ products: [Product]) {
        let categoryKeywords = ["", "pizza", "snack", "drink", "dessert", "sauce"]
        guard index > 0, index < categoryKeywords.count else { return }
        
        let keyword = categoryKeywords[index].lowercased()
        
        if let productIndex = products.firstIndex(where: { $0.image.lowercased().contains(keyword) }) {
            
            let indexPath = IndexPath(row: productIndex, section: 4)
        
            self.view?.scrollTableViewToIndexPath(indexPath, productIndex)
        }
    }
    
    func accountButtonTapped() {
        view?.navigateToAuthorizationScreen()
    }
    
    func productPriceButtonTapped(_ product: Product) {
        self.archiver.append(product)
    }
    
    func productCellSelected(_ product: Product) {
        view?.navigateToProductDetailScreen(product)
    }
    
    func addressSegmentChanged(_ deliveryType: DeliveryType) {
        
        switch deliveryType {
        case .takeAway:
            view?.navigateToPizzaMapScreen()
            
        case .address:
            view?.navigateToDeliveryMapScreen()
            
        }
    }
    
    func addressButtonTapped() {
        view?.navigateToDeliveryMapScreen()
    }
    
    func storyCellSelected(_ image: UIImage?) {
        guard let image = image else { return }
        view?.navigateToStoryDetailScreen(image)
    }

}

//MARK: - Business Logic
extension MenuPresenter {
    
    func addProductToFavorites(_ favouritesVC: FavouritesVC, _ product: Product) {
        
        coreDataService?.addProductToFavourites(product: product)
        NotificationCenter.default.post(name: .favoritesDidUpdate, object: nil)
        
        coreDataService?.fetchFavouriteProducts { products in
            DispatchQueue.main.async {
                favouritesVC.favouriteProducts = products
                favouritesVC.tableView.reloadData()
            }
        }
    
    }
    
    //MARK: - Fetch Requests
    func fetchProducts() {
        productsService?.fetchProducts { result in
            switch result {
            case .success(let products):
                self.view?.showProducts(products)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func fetchSpecials() {
        specialsService?.fetchSpecials { result in
            switch result {
            case .success(let specials):
                self.view?.showSpecials(specials)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func fetchStories() {
        storiesService?.fetchStory { result in
            switch result {
            case .success(let stories):
                self.view?.showStories(stories)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func fetchCategories() {
        categoriesService?.fetchCategory { result in
            switch result {
            case .success(let categories):
                self.view?.showCategories(categories)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
