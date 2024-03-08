//
//  DeliveryMapVC.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 26.02.2024.
//

import UIKit
import MapKit

class PizzaMapVC: UIViewController {
    
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
    
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.delegate = self
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupMap()
        addAnnotationsForPizzaAddresses()
    }
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(mapView)
    }
    
    func setupMap() {
        let location = CLLocationCoordinate2D(latitude: 51.5074, longitude: -0.1278)
        let radius: CLLocationDistance = 2500
        let region = MKCoordinateRegion(center: location, latitudinalMeters: radius, longitudinalMeters: radius)
        mapView.setRegion(region, animated: true)
    }
    
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
                annotation.title = "Пиццерия"
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
    
    func setupConstraints() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension PizzaMapVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard view.annotation?.title != nil else { return }
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: mapView.frame.width, height: 100))
        customView.backgroundColor = .white
        customView.center.x = mapView.center.x
        customView.frame.origin.y = mapView.frame.maxY - customView.frame.height
        self.view.addSubview(customView)
        
        let orderButton = UIButton(type: .system)
        orderButton.frame = CGRect(x: 110, y: 20, width: 200, height: 40)
        orderButton.backgroundColor = .systemGray5
        orderButton.layer.cornerRadius = 5
        orderButton.setTitle("Заказать отсюда", for: .normal)
        orderButton.setTitleColor(.black, for: .normal)
        orderButton.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
        customView.addSubview(orderButton)
        
        guard let addressText = view.annotation?.subtitle else { return }
        self.currentAddress = addressText ?? ""
    }
    
    @objc func orderButtonTapped() {
        
        dismiss(animated: true)
        
        if let mainTabVC = presentingViewController as? MainTabVC {
            
            if let menuVC = mainTabVC.viewControllers?[0] as? MenuVC {
                menuVC.addressText = currentAddress
            }
        }
    }
}
