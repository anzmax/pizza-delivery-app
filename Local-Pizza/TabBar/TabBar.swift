//
//  TabBar.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 12.02.2024.
//

import UIKit
    
    enum TabBarPage {
        case menu
        case contacts
        case cart

        init?(index: Int) {
            switch index {
            case 0:
                self = .menu
            case 1:
                self = .contacts
            case 2:
                self = .cart
            default:
                return nil
            }
        }
        
        func makeTitle() -> String {
            switch self {
            case .menu:
                return "Меню"
            case .contacts:
                return "Контакты"
            case .cart:
                return "Корзина"
            }
        }

        func makeOrder() -> Int {
            switch self {
            case .menu:
                return 0
            case .contacts:
                return 1
            case .cart:
                return 2
            }
        }

            func makeIcon() -> UIImage? {
            switch self {
            case .menu:
                return UIImage(systemName:  "list.bullet.circle")
            case .contacts:
                return UIImage(systemName: "map.circle")
            case .cart:
                return UIImage(systemName: "cart.circle")
            }
        }

            func makeIconSelected() -> UIImage? {
            switch self {
            case .menu:
                return  UIImage(systemName:  "list.bullet.circle.fill")
            case .contacts:
                return  UIImage(systemName: "map.circle.fill")
            case .cart:
                return  UIImage(systemName: "cart.circle.fill")
            }
        }
    }
