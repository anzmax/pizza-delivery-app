//
//  AccountSettingVCTests.swift
//  Local-PizzaTests
//
//  Created by Lika Maksimovic on 19.04.2024.
//

@testable import Local_Pizza
import XCTest

//MARK: - Spy
class AccountSettingVCSpy: AccountSettingsVCProtocol {
    
    var presenter: AccountSettingsPresenterProtocol?
    
    var navigateToPreviousScreenCalled = false
    var navigateToAuthScreenCalled = false
    
    func navigateToPreviousScreen() {
        navigateToPreviousScreenCalled = true
    }
    
    func navigateToAuthScreen() {
        navigateToAuthScreenCalled = true
    }
}

//MARK: - Tests
class AccountSettingVCTests: XCTestCase {
    
    func testNavigateToPreviousScreen() {
        let vc = AccountSettingVCSpy()
        let presenter = AccountSettingsPresenter()
        vc.presenter = presenter
        presenter.view = vc
        
        let settings = AccountSettingItem.data
        presenter.saveAccountSettings(with: [settings])
        
        XCTAssertTrue(vc.navigateToPreviousScreenCalled)
    }
    
    func testNavigateToAuthScreen() {
        let vc = AccountSettingVCSpy()
        let presenter = AccountSettingsPresenter()
        vc.presenter = presenter
        presenter.view = vc
        
        presenter.logout()
        presenter.deleteAccount()
        
        XCTAssertTrue(vc.navigateToAuthScreenCalled)
    }
}
