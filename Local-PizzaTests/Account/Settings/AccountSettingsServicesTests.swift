//
//  AccountSettingsServicesTests.swift
//  Local-PizzaTests
//
//  Created by Lika Maksimovic on 22.04.2024.
//

@testable import Local_Pizza
import XCTest

//MARK: - Spy
class AccountSettingServiceSpy: AccountStorageServiceProtocol {
    
    var saveCalled = false
    var fetchCalled = false
    var deleteCalled = false
    var deleteAllCalled = false
    var printCalled = false
    
    func save(field: Local_Pizza.AccountField, value: String) {
        saveCalled = true
    }
    
    func fetch(field: Local_Pizza.AccountField) -> String {
        fetchCalled = true
        return ""
    }
    
    func delete(field: Local_Pizza.AccountField) {
        deleteCalled = true
    }
    
    func deleteAll() {
        deleteAllCalled = true
    }
    
    func print() {
        printCalled = true
    }
}

final class AccountSettingsServicesTests: XCTestCase {
    
    func testSaveAccountDetails() {
        let presenter = AccountSettingsPresenter()
        let service = AccountSettingServiceSpy()

        presenter.accountStorageservice = service
        let accountSettingItem = AccountSettingItem.data
        presenter.saveAccountSettings(with: [accountSettingItem])
        
        XCTAssertTrue(service.saveCalled)
    }
    
    func testFetchAccountDetails() {
        let presenter = AccountSettingsPresenter()
        let service = AccountSettingServiceSpy()
        let row = 1
        
        presenter.accountStorageservice = service
        
        let _ = presenter.fetchAccountField(row)
        
        XCTAssertTrue(service.fetchCalled)
    }
    
    func testDelete() {
        let presenter = AccountSettingsPresenter()
        let service = AccountSettingServiceSpy()
        
        presenter.accountStorageservice = service
        
        presenter.deleteAccount()
        
        XCTAssertTrue(service.deleteAllCalled)
    }

}
