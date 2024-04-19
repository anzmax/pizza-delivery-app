//
//  DeliveryMapVC.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 26.02.2024.
//

import UIKit
import MapKit

protocol DeliveryMapVCProtocol: AnyObject {
    var presenter: DeliveryMapPresenterProtocol? { get set }

    //Navigation
    func navigateToPreviousScreen()
    func passAddressToMenuScreen()
}

class DeliveryMapVC: UIViewController, DeliveryMapVCProtocol {
    
    var presenter: DeliveryMapPresenterProtocol?
    
    var onSaveAddress: ((String) -> Void)?
    private var customViewBottomConstraint: NSLayoutConstraint?
    
    //MARK: - UI Components
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
    
    lazy var addressTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Ваш адрес"
        textField.heightAnchor.constraint(equalToConstant: 24).isActive = true
        textField.delegate = self
        textField.addTarget(self, action: #selector(addressTextFieldChanged), for: .editingChanged)
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
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var mapView: MKMapView = {
        let mapView = MKMapView()
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
        setupKeyboardNotifications()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK:- Action
    @objc func saveButtonTapped() {
        presenter?.saveButtonTapped()
    }
    
    @objc func closeButtonTapped() {
        presenter?.closeButtonTapped()
    }
}

//MARK: - Delegate
extension DeliveryMapVC: UITextFieldDelegate {

    @objc func addressTextFieldChanged(_ textField: UITextField) {
        guard let address = textField.text else { return }
        geocodeAddress(address)
    }

    func geocodeAddress(_ address: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { [weak self] (placemarks, error) in
            guard let strongSelf = self, let placemarks = placemarks, let location = placemarks.first?.location else { return }
            strongSelf.centerMapOnLocation(location)
        }
    }

    func centerMapOnLocation(_ location: CLLocation) {
        let radius: CLLocationDistance = 50
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: radius, longitudinalMeters: radius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}

//MARK: - Layout
extension DeliveryMapVC {
    func setupViews() {
        view.addSubview(mapView)
        mapView.addSubview(closeButton)
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
    
    func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setupConstraints() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        customView.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
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
            saveButton.heightAnchor.constraint(equalToConstant: 40),
            
            closeButton.topAnchor.constraint(equalTo: mapView.safeAreaLayoutGuide.topAnchor),
            closeButton.leadingAnchor.constraint(equalTo: mapView.safeAreaLayoutGuide.leadingAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 50),
            closeButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        customViewBottomConstraint = customView.bottomAnchor.constraint(equalTo: mapView.bottomAnchor)
        customViewBottomConstraint?.isActive = true
    }
}

//MARK: - Keyboard Handler
extension DeliveryMapVC {
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let keyboardHeight = keyboardSize.height
        customViewBottomConstraint?.constant = -keyboardHeight + view.safeAreaInsets.bottom
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        customViewBottomConstraint?.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

//MARK: - Navigation
extension DeliveryMapVC {
    
    func navigateToPreviousScreen() {
        self.dismiss(animated: true)
    }
    
    func passAddressToMenuScreen() {
        if let address = addressTextField.text, !address.isEmpty {
            onSaveAddress?(address)
            self.dismiss(animated: true)
        }
    }
}
