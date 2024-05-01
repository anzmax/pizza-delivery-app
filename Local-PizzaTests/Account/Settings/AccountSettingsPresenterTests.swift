//
//  AccountSettingsPresenterTests.swift
//  Local-PizzaTests
//
//  Created by Lika Maksimovic on 19.04.2024.
//

@testable import Local_Pizza
import XCTest

//MARK: - Spy
class AccountSettingPresenterSpy: AccountSettingsPresenterProtocol {
    
    var view: AccountSettingsVCProtocol?
    
    var saveAccountSettingsCalled = false
    var fetchAccountFieldCalled = false
    var logoutCalled = false
    var deleteAccountCalled = false
    var logoutCellSelectedCalled = false
    var deleteAccountCellSelectedCalled = false
    
    func saveAccountSettings(with settings: [Local_Pizza.AccountSettingItem]) {
        saveAccountSettingsCalled = true
    }
    
    func fetchAccountField(_ row: Int) -> (Local_Pizza.AccountField, String) {
        fetchAccountFieldCalled = true
        
        let field = AccountField.name
        return (field, "")
    }
    
    func logout() {
        logoutCalled = true
    }
    
    func deleteAccount() {
        deleteAccountCalled = true
    }
    
    func logoutCellSelected() {
        logoutCellSelectedCalled = true
    }
    
    func deleteAccountCellSelected() {
        deleteAccountCellSelectedCalled = true
    }

}

//MARK: - Tests
class AccountSettingsPresenterTests: XCTestCase {
    
    func testSaveAccountSettings() {
        let vc = AccountSettingsVC()
        let presenter = AccountSettingPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
        
        vc.doneButtonTapped()
        
        XCTAssertTrue(presenter.saveAccountSettingsCalled)
    }
    
    func testFetchAccountField() {
        let vc = AccountSettingsVC()
        let presenter = AccountSettingPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
    }
    
    func testLogout() {

        let vc = AccountSettingsVC()
        let presenter = AccountSettingPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
        
        let indexPath = IndexPath(row: 0, section: 2)
        vc.rowSelected(indexPath)
        
        XCTAssertTrue(presenter.logoutCellSelectedCalled)
    }
    
    func testDeleteAccount() {
        let vc = AccountSettingsVC()
        let presenter = AccountSettingPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
        
        let indexPath = IndexPath(row: 0, section: 3)
        vc.rowSelected(indexPath)
        
        XCTAssertTrue(presenter.deleteAccountCellSelectedCalled)
    }
}
