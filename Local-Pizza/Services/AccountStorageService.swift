//
//  AccountStorageService.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 19.03.2024.
//

import UIKit
import SwiftKeychainWrapper

enum AccountField: Int, CaseIterable {
    case name = 0
    case phone = 1
    case email = 2
    case dateOfBirth = 3
    
    func getKey() -> String {
        switch self {
        case .name:  return "name"
        case .phone: return "phone"
        case .email:  return "email"
        case .dateOfBirth:  return "dateOfBirth"
        }
    }
    
    func getPlaceholder() -> String {
        switch self {
        case .name:  return "Имя"
        case .phone: return "Телефон"
        case .email:  return "E-mail"
        case .dateOfBirth:  return "Дата рождения"
        }
    }
}

class AccountStorageService {
    
    private let keychainWrapper = KeychainWrapper.standard
    
    func save(field: AccountField, value: String) {
        
        let key = field.getKey()
      
        keychainWrapper.set(value, forKey: key)
    }
    
    func fetch(field: AccountField) -> String {
        let key = field.getKey()
        
        let value = keychainWrapper.string(forKey: key)
        return value ?? ""
    }
    
    func delete(field: AccountField) {
        let key = field.getKey()
        
        keychainWrapper.remove(forKey: KeychainWrapper.Key(rawValue: key))
    }
    
    func deleteAll() {
        keychainWrapper.removeAllKeys()
    }
    
    func print() {
        var value: [String] = []
        
        for field in AccountField.allCases {
            let item = fetch(field: field)
            value += [item]
        }
        Swift.print(value.joined(separator: ", "))
    }
}
