//
//  PizzaMapPresenter.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 08.04.2024.
//

import UIKit
import MapKit

protocol PizzaMapPresenterProtocol: AnyObject {
    
    var view: PizzaMapVCProtocol? { get set }
    
    func closeButtonTapped()
    func orderButtonTapped()
}

class PizzaMapPresenter: PizzaMapPresenterProtocol {
    
    weak var view: PizzaMapVCProtocol?
}

//MARK: - View Event
extension PizzaMapPresenter {
    func closeButtonTapped() {
        view?.navigateToPreviousScreen()
    }
    
    func orderButtonTapped() {
        view?.passAnnotationAddressToMenu()
    }
}
