//
//  DeliveryMapVC.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 26.02.2024.
//

import UIKit
import MapKit

protocol PizzaMapVCProtocol: AnyObject {
    //Connections
    var presenter: PizzaMapPresenterProtocol? { get set }
    
    //Update View
    func addAnnotationForAddress(_ address: String)
    func addAnnotationsForPizzaAddresses()
    
    //Navigation
    func navigateToPreviousScreen()
    func passAnnotationAddressToMenu()
}

class PizzaMapVC: UIViewController, PizzaMapVCProtocol {
    
    var presenter: PizzaMapPresenterProtocol?
    
    let pizzaAddresses = [
        "11 Kingly St, Soho",
        "98 Tottenham Court Rd, Fitzrovia",
        "13 Neal's Yard, Covent Garden",
        "95 Kingsland High St",
        "54 Blackstock Rd, Finsbury Park",
        "56 Shoreditch High St, Hackney",
        "246-250 Pentonville Rd",
        "374-378 Old St, Hackney",
        "13 Neal's Yard, Covent Garden",
        "6 Rees St, Covent Garden"
    ]
    
    var onAddressChanged: ((String)->())?
    
    var currentAddress: String = ""
    
    //MARK: - UI Components
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.delegate = self
        return mapView
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.square.fill"), for: .normal)
        button.tintColor = .gray
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupMap()
        
        addAnnotationsForPizzaAddresses()
    }
}

//MARK: - Delegate
extension PizzaMapVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard view.annotation?.title != nil else { return }

        let customView = UIView(frame: CGRect(x: 0, y: 0, width: mapView.frame.width, height: 100))
        customView.backgroundColor = .white
        customView.center.x = mapView.center.x
        customView.frame.origin.y = mapView.frame.maxY - customView.frame.height
        self.view.addSubview(customView)

        let orderButton = UIButton(type: .system)
        let buttonX: CGFloat = 16
        let buttonWidth = customView.frame.width - (buttonX * 2)

        orderButton.frame = CGRect(x: buttonX, y: 20, width: buttonWidth, height: 40)
        orderButton.backgroundColor = .systemGray5
        orderButton.layer.cornerRadius = 10
        orderButton.setTitle("Заказать отсюда".localized(), for: .normal)
        orderButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        orderButton.setTitleColor(.black, for: .normal)
        orderButton.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
        customView.addSubview(orderButton)

        guard let addressText = view.annotation?.subtitle else { return }
        self.currentAddress = addressText ?? ""
    }
    
    //MARK: - Action
    @objc func orderButtonTapped() {
        presenter?.orderButtonTapped()
    }
    
    @objc func closeButtonTapped() {
        self.presenter?.closeButtonTapped()
    }
}

//MARK: - Layout
extension PizzaMapVC {
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(mapView)
        mapView.addSubview(closeButton)
    }
    
    func setupMap() {
        let location = CLLocationCoordinate2D(latitude: 51.5074, longitude: -0.1278)
        let radius: CLLocationDistance = 4000
        let region = MKCoordinateRegion(center: location, latitudinalMeters: radius, longitudinalMeters: radius)
        mapView.setRegion(region, animated: true)
    }
    
    func setupConstraints() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            closeButton.topAnchor.constraint(equalTo: mapView.safeAreaLayoutGuide.topAnchor),
            closeButton.leadingAnchor.constraint(equalTo: mapView.safeAreaLayoutGuide.leadingAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 50),
            closeButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

//MARK: - Update View
extension PizzaMapVC {
    
    func addAnnotationForAddress(_ address: String) {
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { placemarks, error in
            if let error = error {
                print("Ошибка геокодирования: \(error.localizedDescription)")
                return
            }
            
            if let placemark = placemarks?.first {
                let annotation = MKPointAnnotation()
                annotation.coordinate = placemark.location!.coordinate
                annotation.title = "Пиццерия".localized()
                annotation.subtitle = address
                self.mapView.addAnnotation(annotation)
            }
        }
    }
    
    func addAnnotationsForPizzaAddresses() {
        for address in pizzaAddresses {
            addAnnotationForAddress(address)
        }
    }
}

//MARK: - Navigation
extension PizzaMapVC {
    
    func navigateToPreviousScreen() {
        self.dismiss(animated: true)
    }
    
    func passAnnotationAddressToMenu() {
        if let mainTabVC = presentingViewController as? MainTabVC {
            if let menuVC = mainTabVC.viewControllers?[0] as? MenuVC {
                menuVC.addressText = currentAddress
                dismiss(animated: true)
            }
        }
    }
}
