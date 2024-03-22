//
//  Product.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 14.02.2024.
//

import UIKit

struct Product: Codable, Equatable {
    var image: String
    var title: String
    var description: String
    var price: String
    var count = 1
}
