//
//  String+Localization.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 22.04.2024.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
