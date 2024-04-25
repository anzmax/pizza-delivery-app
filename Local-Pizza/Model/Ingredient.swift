//
//  Ingredient.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 26.02.2024.
//

import UIKit

struct Ingredient: Codable, Equatable {
    var title: String
    var price: String
    var image: String
    
    var isSelected: Bool? = false
    
    func formatPrice() -> Int {
        let replacedPrice = self.price.dropLast(2)
        let price = Int(replacedPrice) ?? 0
        
        return price
    }
}
