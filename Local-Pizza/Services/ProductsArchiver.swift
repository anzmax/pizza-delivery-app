//
//  ProductArchiver.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 05.03.2024.
//

import UIKit

protocol ProductsArchiverProtocol: AnyObject {
    func save(_ products: [Product])
    func fetch() -> [Product]
    func append(_ product: Product)
    func remove(_ product: Product)
}

final class ProductsArchiver: ProductsArchiverProtocol {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private let key = "Products"
    
    //MARK: - Public methods
    func save(_ products: [Product]) {

        do {
            let data = try encoder.encode(products)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }

    func fetch() -> [Product] {

        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        do {
            let array = try decoder.decode(Array<Product>.self, from: data)
            return array
        } catch {
            print(error)
        }
        return []
    }
    
    func append(_ product: Product) {
        
        var products = fetch()
        
        if let index = products.firstIndex(where: { $0.title == product.title }) {
            
            products[index].count += 1
        } else {
            products.append(product)
        }
    
        save(products)
    }
    
    func remove(_ product: Product) {
        var products = fetch()
        if let index = products.firstIndex(of: product) {
            products.remove(at: index)
            save(products)
        }
    }
}
