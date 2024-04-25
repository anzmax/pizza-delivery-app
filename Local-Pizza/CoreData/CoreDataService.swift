//
//  CoreDataService.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 18.03.2024.
//

import CoreData
import UIKit

protocol CoreDataServiceProtocol: AnyObject {
    
    var persistentContainer: NSPersistentContainer { get }
    func saveContext(backgroundContext: NSManagedObjectContext?)
    
    func addProductToFavourites(product: Product)
    func fetchFavouriteProducts(completion: @escaping ([Product]) -> Void)
    func deleteFavouriteProduct(product: Product, context: NSManagedObjectContext)
}

class CoreDataService: CoreDataServiceProtocol {
    
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: .dataName)
        container.loadPersistentStores { description, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        return container
    }()
    
    func saveContext(backgroundContext: NSManagedObjectContext? = nil) {
        let context = backgroundContext ?? persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
                assertionFailure("Saving error")
            }
        }
    }
    
    //MARK: - Add
    func addProductToFavourites(product: Product) {
        let context = persistentContainer.viewContext

        let fetchRequest: NSFetchRequest<ProductModel> = ProductModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@ AND mainDescription == %@", product.title, product.description)
        
        do {
            let existingProducts = try context.fetch(fetchRequest)
            
            guard existingProducts.isEmpty else {
                print("Товар уже добавлен в избранное")
                return
            }

            let productModel = ProductModel(context: context)
            productModel.title = product.title
            productModel.price = product.price
            productModel.mainDescription = product.description
            productModel.image = product.image
            productModel.count = Int32(product.count)
            
            saveContext()
        } catch let error {
            print("Ошибка при проверке товара в избранном: \(error)")
        }
    }
    
    //MARK: - Fetch
    func fetchFavouriteProducts(completion: @escaping ([Product]) -> Void) {
        persistentContainer.performBackgroundTask { context in
            let fetchRequest: NSFetchRequest<ProductModel> = ProductModel.fetchRequest()

            do {
                let productModels = try context.fetch(fetchRequest)
                let products = productModels.map { productModel in
                    Product(image: productModel.image ?? "", title: productModel.title ?? "", description: productModel.mainDescription ?? "", price: productModel.price ?? "", count: Int(productModel.count))
                }
                
                DispatchQueue.main.async {
                    completion(products)
                }
            } catch {
                print("Ошибка при извлечении избранных продуктов: \(error)")
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }
    }
    
    //MARK: - Delete
    func deleteFavouriteProduct(product: Product, context: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<ProductModel> = ProductModel.fetchRequest()
        
        do {
            let productModels = try context.fetch(fetchRequest)
            
            for productCoreData in productModels {
                if productCoreData.title == product.title {
                    context.delete(productCoreData)
                    saveContext(backgroundContext: context)
                }
            }
//            
//            if let productModelToDelete = productModels.first {
//                context.delete(productModelToDelete)
//                saveContext(backgroundContext: context)
//            }
        } catch {
            print("Ошибка при удалении избранного поста: \(error)")
        }
    }
}

extension String {
    static let dataName = "ProductModel"
}
