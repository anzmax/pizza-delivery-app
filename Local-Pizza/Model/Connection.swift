//
//  Connection.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 18.03.2024.
//

import UIKit

struct Connection {
    var title: String
    var image: UIImage?
}

var connections: [Connection] = [
    Connection(title: "Написать на почту", image: UIImage(systemName: "envelope")),
    Connection(title: "Написать в телеграм", image: UIImage(systemName: "paperplane")),
    Connection(title: "Позвонить по телефону", image: UIImage(systemName: "phone"))
]
