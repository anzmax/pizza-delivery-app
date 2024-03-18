//
//  Category.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 14.02.2024.
//

import UIKit

struct Category: Codable {
    var title: String
}

var categories = [
    Category(title: "Завтрак"),
    Category(title: "Пиццы"),
    Category(title: "Закуски"),
    Category(title: "Напитки"),
    Category(title: "Десерты"),
    Category(title: "Соусы")
]
