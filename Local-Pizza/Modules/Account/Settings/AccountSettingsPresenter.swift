//
//  SettingsPresenter.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 11.04.2024.
//

import UIKit

//struct AccountSettingItem {
//    var field: AccountField
//    var value: String
//}

protocol AccountSettingsPresenterProtocol: AnyObject {
    
    //Connections
    var view: AccountSettingsVCProtocol? { get set }
    
    //View Event
    //func rowSelected(_ indexPath: IndexPath)
    func logoutCellSelected()
    func deleteAccountCellSelected()
    
    //Business Logic
    func saveAccountSettings(with settings: [AccountSettingItem])
    func fetchAccountField(_ row: Int) -> (AccountField, String)
    func logout()
    func deleteAccount()
}

class AccountSettingsPresenter: AccountSettingsPresenterProtocol {
    
    weak var view: AccountSettingsVCProtocol?
    
    //var accountStorageservice = AccountStorageService()
    var accountStorageservice: AccountStorageServiceProtocol?
}

//MARK: - View Event
extension AccountSettingsPresenter {
    
    func logoutCellSelected() {
        logout()
    }
    
    func deleteAccountCellSelected() {
        deleteAccount()
    }
    
//    func rowSelected(_ indexPath: IndexPath) {
//        switch indexPath.section {
//        case 2:
//            print("Выход из аккаунта")
//            logout()
//        case 3:
//            print("Удаление аккаунта")
//            deleteAccount()
//        default:
//            break
//        }
//    }
}

//MARK: - Business Logic
extension AccountSettingsPresenter {
    
    func saveAccountSettings(with settings: [AccountSettingItem]) {
        
         for setting in settings {
             accountStorageservice?.save(field: setting.field, value: setting.value)
         }
        
        self.view?.navigateToPreviousScreen()
     }
    
    func fetchAccountField(_ row: Int) -> (AccountField, String) {
        
        guard let field = AccountField(rawValue: row) else {
            fatalError("Некорректный индекс для AccountField".localized())
        }
        let value = accountStorageservice?.fetch(field: field)
        return (field, value ?? "")
    }
    
    func logout() {
         accountStorageservice?.deleteAll()
         view?.navigateToAuthScreen()
     }

     func deleteAccount() {
         accountStorageservice?.deleteAll()
         view?.navigateToAuthScreen()
     }
}
