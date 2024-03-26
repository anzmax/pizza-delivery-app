//
//  Product.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 14.02.2024.
//

import UIKit

struct Product: Codable, Equatable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.title == rhs.title && lhs.additions == rhs.additions
    }
    
    var image: String
    var title: String
    var description: String
    var price: String
    //var size: String?
    var count = 1
    
    var additions: [Ingredient]?
    
    func formatPrice() -> Int {
        let replacedPrice = self.price.dropLast(2)
        let price = Int(replacedPrice) ?? 0
        
        return price
    }
    
    func totalPrice() -> Int {
        var total: Int = 0
        
        let price = formatPrice()
        
        total += price
        
//        if let size = size {
//             switch size {
//             case "Средняя":
//                 total += 100
//             case "Большая":
//                 total += 200
//             default:
//                 break
//             }
//         }
        
        for ingredient in additions ?? [] {
            
            let formattedPrice =  ingredient.formatPrice()
            
            total += formattedPrice
        }
        return total
    }

}
