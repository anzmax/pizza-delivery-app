//
//  AccountSettingItem.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 19.04.2024.
//

import Foundation

struct AccountSettingItem {
    var field: AccountField
    var value: String
}

extension AccountSettingItem {
    static let data = AccountSettingItem(field: .dateOfBirth, value: "")
}
