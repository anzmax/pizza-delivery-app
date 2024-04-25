//
//  Product.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 14.02.2024.
//

import UIKit

enum SizeType: Int, CaseIterable {
    case small
    case medium
    case big
    
    func getName() -> String {
        switch self {
        case .small:
            return "Маленькая"
        case .medium:
            return "Средняя"
        case .big:
            return "Большая"
        }
    }
    
    func getPrice() -> Int {
        
        switch self {
        case .small:
            return 50
        case .medium:
            return 0
        case .big:
            return 200
        }
    }
}

enum DoughType: Int, Equatable {
    case thin
    case thick
    
    func getName() -> String {
        switch self {
        case .thin:
            return "Тонкое"
        case .thick:
            return "Традиционное"
        }
    }
    
    func getPrice() -> Int {
        switch self {
        case .thin:
            return 0
        case .thick:
            return 100
        }
    }
}

struct Product: Codable, Equatable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.title == rhs.title && lhs.additions == rhs.additions
    }
    
    var image: String
    var title: String
    var description: String
    var price: String
    var size: Int? = 1
    var dough: Int? = 0
    var count = 1
    
    var additions: [Ingredient]?
    
    func formatPrice() -> Int {
        let replacedPrice = self.price.dropLast(2)
        let price = Int(replacedPrice) ?? 0
        
        return price
    }
    
    func totalPrice() -> Int {
        var total: Int = 0
        
        //Product price
        let price = formatPrice()
        total += price
        
        //Size price
        let sizeIndex = self.size ?? 1
        let sizeType = SizeType(rawValue: sizeIndex)
        let sizePrice = sizeType?.getPrice() ?? 0
        total += sizePrice
        
        //Dough price
        let doughIndex = self.dough ?? 0
        let doughType = DoughType(rawValue: doughIndex)
        let doughPrice = doughType?.getPrice() ?? 0
        total += doughPrice
        
        //Ingredients price
        for ingredient in additions ?? [] {
            let formattedPrice =  ingredient.formatPrice()
            total += formattedPrice
        }
        return total
    }

}

extension Product {
    static var data: Product {
        Product(image: "", title: "", description: "", price: "")
    }
}
