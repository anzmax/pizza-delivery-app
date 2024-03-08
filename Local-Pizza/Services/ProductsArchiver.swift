//
//  ProductArchiver.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 05.03.2024.
//

import UIKit

final class ProductsArchiver {
    
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
        if products.contains(product) {
            print("")
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
