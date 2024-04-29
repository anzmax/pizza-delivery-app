//
//  Story.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 12.02.2024.
//

import UIKit

struct Story: Codable {
    var image: String
}

var stories = [
    Story(image: "pizzaoffer"),
    Story(image: "nuggetsoffer"),
    Story(image: "drinksoffer"),
    Story(image: "dessertoffer"),
    Story(image: "combooffer"),
    Story(image: "colaoffer"),
]
