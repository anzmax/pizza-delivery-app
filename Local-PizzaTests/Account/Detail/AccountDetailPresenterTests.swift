//
//  AccountDetailPresenterTests.swift
//  Local-PizzaTests
//
//  Created by Lika Maksimovic on 19.04.2024.
//

@testable import Local_Pizza
import XCTest

//MARK: - Spy
class AccountPresenterSpy: AccountDetailPresenterProtocol {
    
    var view: AccountDetailVCProtocol?
    
    var chevronButtonTappedCalled = false
    var didSelectConnectionItemCalled = false
    var entertainmentItemTappedCalled = false
    var settingsButtonTappedCalled = false
    var closeButtonTappedCalled = false
    
    func chevronButtonTapped() {
        chevronButtonTappedCalled = true
    }
    
    func didSelectConnectionItem(_ index: Int) {
        didSelectConnectionItemCalled = true
    }
    
    func entertainmentItemTapped(_ indexPath: IndexPath) {
        entertainmentItemTappedCalled = true
    }
    
    func settingsButtonTapped() {
        settingsButtonTappedCalled = true
    }
    
    func closeButtonTapped() {
        closeButtonTappedCalled = true
    }
}

//MARK: - Tests
class AccountDetailPresenterTests: XCTestCase {
    
    func testChevronButtonTapped() {
        let vc = AccountDetailVC()
        let presenter = AccountPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
        
        vc.toggleTableView()
        
        XCTAssertTrue(presenter.chevronButtonTappedCalled)
    }
    
    func testSettingsButtonTapped() {
        let vc = AccountDetailVC()
        let presenter = AccountPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
        
        vc.settingsButtonTapped()
        
        XCTAssertTrue(presenter.settingsButtonTappedCalled)
    }
    
    func testCloseButtonTapped() {
        let vc = AccountDetailVC()
        let presenter = AccountPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
        
        vc.closeButtonTapped()
        
        XCTAssertTrue(presenter.closeButtonTappedCalled)
    }
    
    func testEntertainmentItemTapped() {
        let vc = AccountDetailVC()
        let presenter = AccountPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
        
        let indexPath = IndexPath(row: 1, section: 0)
        vc.entertainmentCellTapped(indexPath)
        
        XCTAssertTrue(presenter.entertainmentItemTappedCalled)
    }
    
    func testDidSelectConnectionItem() {
        let vc = AccountDetailVC()
        let presenter = AccountPresenterSpy()
        vc.presenter = presenter
        presenter.view = vc
        
        let indexPath = IndexPath(row: 1, section: 0)
        vc.collectionItemSelected(indexPath)
        
        XCTAssertTrue(presenter.didSelectConnectionItemCalled)
    }
}
