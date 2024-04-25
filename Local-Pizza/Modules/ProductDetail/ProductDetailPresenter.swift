//
//  ProductDetailPresenter.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 02.04.2024.
//

import UIKit

protocol ProductDetailPresenterProtocol: AnyObject {
    
    //Connections
    var view: ProductDetailVCProtocol? { get set }
    
    //View Event
    func viewDidLoad()
    func cartButtonTapped(_ button: UIButton, _ product: Product?)
    func doughCellSelected(_ index: Int, _ product: Product)
    func sizeCellSelected(_ index: Int, _ product: Product)
    
    //Business Logic
    func fetchIngredients()
}

class ProductDetailPresenter: ProductDetailPresenterProtocol {
    
    weak var view: ProductDetailVCProtocol?
    
    //var archiver = ProductsArchiver()
    //var ingredientsService = IngredientsNetworkService()
    var archiver: ProductsArchiverProtocol?
    var ingredientsService: IngredientsNetworkServiceProtocol?
    
}

//MARK: - View Event
extension ProductDetailPresenter {
    func viewDidLoad() {
        fetchIngredients()
    }
    
    func cartButtonTapped(_ button: UIButton, _ product: Product?) {
        let originalColor = button.backgroundColor
        button.backgroundColor = .systemGray3
        
        UIView.animate(withDuration: 1, animations: {
            button.backgroundColor = originalColor
        })
        
        if let product = product {
            self.archiver?.append(product)
        }
        
        self.view?.navigateToPreviousScreen()
    }

    func doughCellSelected(_ index: Int, _ product: Product) {
        view?.showProductDough(index)
    }
    
    func sizeCellSelected(_ index: Int, _ product: Product) {
        view?.showProductSize(index)
    }
}

//MARK: - Business Logic
extension ProductDetailPresenter {
    func fetchIngredients() {
        ingredientsService?.fetchIngredients { result in
            switch result {
            case .success(let ingredients):
                self.view?.showIngredients(ingredients)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
