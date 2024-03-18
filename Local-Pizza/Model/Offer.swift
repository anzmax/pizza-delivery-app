//
//  Offers.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 18.03.2024.
//

import UIKit

struct Offer {
    var title: String
    var subtitle: String
    var image: UIImage?
}

var offers: [Offer] = [
    Offer(title: "Скидка 25% при заказе в пиццерии от 799 р", subtitle: "до 16 Июня", image: UIImage(named: "percentage")),
    Offer(title: "Скидка 20% при заказе от 1049 р", subtitle: "до 16 Июня", image: UIImage(named: "percentage"))
]
