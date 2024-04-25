//
//  AccountDetailPresenter.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 11.04.2024.
//

import UIKit

protocol AccountDetailPresenterProtocol: AnyObject {
    
    //Connections
    var view: AccountDetailVCProtocol? { get set}
    
    //View Event
    func chevronButtonTapped()
    func didSelectConnectionItem(_ index: Int)
    func entertainmentItemTapped(_ indexPath: IndexPath)
    func settingsButtonTapped()
    func closeButtonTapped()
}

class AccountDetailPresenter: AccountDetailPresenterProtocol {
    
    weak var view: AccountDetailVCProtocol?
}

//MARK: - View Event
extension AccountDetailPresenter {
    
    func settingsButtonTapped() {
        view?.navigateToSettingsScreen()
    }
    
    func closeButtonTapped() {
        view?.navigateToMenuScreen()
    }
    
    func chevronButtonTapped() {
        view?.tableViewHeightChanged()
    }
    
    func didSelectConnectionItem(_ index: Int) {
        switch index {
        case 0:
            view?.navigateToEmailScreen()
        case 1:
            view?.navigateToTelegramScreen()
        case 2:
            view?.navigateToPhoneCallScreen()
        default:
            break
        }
    }
    
    func entertainmentItemTapped(_ indexPath: IndexPath) {
        var videoURL: URL?
        
        switch indexPath.row {
        case 0:
            videoURL = URL(string: "https://youtu.be/ggqXttEhWlY?si=HIfSQC5LWHk3umXI")
        case 1:
            videoURL = URL(string: "https://youtu.be/sv3TXMSv6Lw?si=Zlffeyae8OyM5WEi")
        case 2:
            videoURL = URL(string: "https://youtu.be/Eim2GpHNQDg?si=983bbagAMCTqbetP")
        default:
            videoURL = URL(string: "https://youtu.be/Eim2GpHNQDg?si=983bbagAMCTqbetP")
        }
        
        if let url = videoURL {
            view?.navigateToEntertainmentScreen(withURL: url)
        }
    }
    
}
