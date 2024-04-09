//
//  DeliveryMapPresenter.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 09.04.2024.
//

import UIKit

protocol DeliveryMapPresenterProtocol: AnyObject {
    var view: DeliveryMapVCProtocol? { get set }
    
    //View Event
    func closeButtonTapped()
    func saveButtonTapped()
}

class DeliveryMapPresenter: DeliveryMapPresenterProtocol {
    weak var view: DeliveryMapVCProtocol?
    
}

//MARK: - View Event
extension DeliveryMapPresenter {
    func closeButtonTapped() {
        view?.navigateToPreviousScreen()
    }
    
    func saveButtonTapped() {
        view?.passAddressToMenuScreen()
    }
}
