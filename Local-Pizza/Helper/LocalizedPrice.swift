//
//  LocalizedPrice.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 22.04.2024.
//

import UIKit

func convertAndLocalizePrice(rubles: String, rate: Double, completion: @escaping (String) -> Void) {
    DispatchQueue.global(qos: .userInitiated).async {
        let numericPart = rubles.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        guard let rublesValue = Double(numericPart) else {
            DispatchQueue.main.async {
                completion(rubles)
            }
            return
        }

        let formatter = NumberFormatter()
        formatter.numberStyle = .currency

        if Locale.preferredLanguages.first?.contains("en") ?? false {
            let poundsValue = rublesValue / rate
            formatter.locale = Locale(identifier: "en_GB")
            formatter.currencySymbol = "£"
            formatter.maximumFractionDigits = 2
            let formattedPrice = formatter.string(from: NSNumber(value: poundsValue)) ?? "\(poundsValue) £"
            DispatchQueue.main.async {
                completion(formattedPrice)
            }
        } else {
            formatter.locale = Locale(identifier: "ru_RU")
            formatter.currencySymbol = "₽"
            formatter.maximumFractionDigits = 0  
            let rublesIntValue = Int(rublesValue)
            let formattedPrice = formatter.string(from: NSNumber(value: rublesIntValue)) ?? "\(rublesIntValue) ₽"
            DispatchQueue.main.async {
                completion(formattedPrice)
            }
        }
    }
}

