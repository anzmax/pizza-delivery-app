//
//  DeliveryMapVC.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 26.02.2024.
//

import UIKit
import MapKit

class DeliveryMapVC: UIViewController {
    
    var customView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private var discriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Город, улица и дом"
        label.font = UIFont.systemFont(ofSize: 13, weight: .thin)
        return label
    }()
    
    var addressTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Ваш адрес"
        textField.heightAnchor.constraint(equalToConstant: 24).isActive = true
        return textField
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .white
        stack.axis = .vertical
        stack.alignment = .leading
        
        stack.layer.borderWidth = 2
        stack.layer.borderColor = UIColor.lightGray.cgColor
        stack.layer.cornerRadius = 10
        
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 8)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 10
        return button
    }()
    
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
    }
    
    func setupViews() {
        view.addSubview(mapView)
        stackView.addArrangedSubview(discriptionLabel)
        stackView.addArrangedSubview(addressTextField)
        mapView.addSubview(customView)
        customView.addSubview(stackView)
        customView.addSubview(saveButton)
    }
    
    func setupMap() {
        let location = CLLocationCoordinate2D(latitude: 51.5074, longitude: -0.1278)
        let radius: CLLocationDistance = 2500
        let region = MKCoordinateRegion(center: location, latitudinalMeters: radius, longitudinalMeters: radius)
        mapView.setRegion(region, animated: true)
    }
    
    func setupConstraints() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        customView.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            customView.leadingAnchor.constraint(equalTo: mapView.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: mapView.trailingAnchor),
            customView.bottomAnchor.constraint(equalTo: mapView.bottomAnchor),
            customView.heightAnchor.constraint(equalToConstant: 200),
            
            stackView.topAnchor.constraint(equalTo: customView.topAnchor, constant: 22),
            stackView.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -16),
            
            saveButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            saveButton.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 16),
            saveButton.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -16),
            saveButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

extension DeliveryMapVC: MKMapViewDelegate {

}
