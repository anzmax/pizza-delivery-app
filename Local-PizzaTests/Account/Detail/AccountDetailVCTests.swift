//
//  AccountDetailVCTests.swift
//  Local-PizzaTests
//
//  Created by Lika Maksimovic on 19.04.2024.
//

@testable import Local_Pizza
import XCTest

//MARK: - Spy
class AccountDetailVCSpy: AccountDetailVCProtocol {
    
    var presenter: AccountDetailPresenterProtocol?
    
    var tableViewHeightChangedCalled = false
    var navigateToSettingsScreenCalled = false
    var navigateToMenuScreenCalled = false
    var navigateToEntertainmentScreenCalled = false
    var navigateToEmailScreenCalled = false
    var navigateToTelegramScreenCalled = false
    var navigateToPhoneCallScreenCalled = false
    
    func tableViewHeightChanged() {
        tableViewHeightChangedCalled = true
    }
    
    func navigateToSettingsScreen() {
        navigateToSettingsScreenCalled = true
    }
    
    func navigateToMenuScreen() {
        navigateToMenuScreenCalled = true
    }
    
    func navigateToEntertainmentScreen(withURL url: URL) {
        navigateToEntertainmentScreenCalled = true
    }
    
    func navigateToEmailScreen() {
        navigateToEmailScreenCalled = true
    }
    
    func navigateToTelegramScreen() {
        navigateToTelegramScreenCalled = true
    }
    
    func navigateToPhoneCallScreen() {
        navigateToPhoneCallScreenCalled = true
    }
}

//MARK: - Tests
class AccountDetailVCTests: XCTestCase {
    
    func testTableViewHeightChanged() {
        let vc = AccountDetailVCSpy()
        let presenter = AccountDetailPresenter()
        vc.presenter = presenter
        presenter.view = vc
        
        presenter.chevronButtonTapped()
        
        XCTAssertTrue(vc.tableViewHeightChangedCalled)
    }
    
    func testNavigateToSettingsScreen() {
        let vc = AccountDetailVCSpy()
        let presenter = AccountDetailPresenter()
        vc.presenter = presenter
        presenter.view = vc
        
        presenter.settingsButtonTapped()
        
        XCTAssertTrue(vc.navigateToSettingsScreenCalled)
    }
    
    func testNavigateToMenuScreen() {
        let vc = AccountDetailVCSpy()
        let presenter = AccountDetailPresenter()
        vc.presenter = presenter
        presenter.view = vc
        
        presenter.closeButtonTapped()
        
        XCTAssertTrue(vc.navigateToMenuScreenCalled)
    }
    
    func testNavigateToEntertainmentScreen() {
        let vc = AccountDetailVCSpy()
        let presenter = AccountDetailPresenter()
        vc.presenter = presenter
        presenter.view = vc
        
        let indexPath = IndexPath(row: 1, section: 0)
        presenter.entertainmentItemTapped(indexPath)
        
        XCTAssertTrue(vc.navigateToEntertainmentScreenCalled)
    }
    
    func testNavigateToEmailScreen() {
        let vc = AccountDetailVCSpy()
        let presenter = AccountDetailPresenter()
        vc.presenter = presenter
        presenter.view = vc
        
        let index = 0
        presenter.didSelectConnectionItem(index)
        
        XCTAssertTrue(vc.navigateToEmailScreenCalled)
    }
    
    func testNavigateToTelegramScreen() {
        let vc = AccountDetailVCSpy()
        let presenter = AccountDetailPresenter()
        vc.presenter = presenter
        presenter.view = vc
        
        let index = 1
        presenter.didSelectConnectionItem(index)
        
        XCTAssertTrue(vc.navigateToTelegramScreenCalled)
    }
    
    func testNavigateToPhoneCallScreen() {
        let vc = AccountDetailVCSpy()
        let presenter = AccountDetailPresenter()
        vc.presenter = presenter
        presenter.view = vc
        
        let index = 2
        presenter.didSelectConnectionItem(index)
        
        XCTAssertTrue(vc.navigateToPhoneCallScreenCalled)
    }
}
