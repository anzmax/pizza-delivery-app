//
//  PromoCell.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 04.03.2024.
//

import UIKit

class PromoCodeCell: UITableViewCell {
    
    static let id = "PromoCodeCell"
    
    //let accessoryTextField = UITextField()
    
    lazy var promoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Применить промокод", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(promoButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var hiddenTextField: UITextField = {
        let textField = UITextField()
        textField.isHidden = true
        return textField
    }()
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.isHidden = true
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        configureInputAccessoryView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func promoButtonTapped() {
        hiddenTextField.becomeFirstResponder()
    }
    
    //    @objc func applyPromoCode() {
    //        if let promoCode = hiddenTextField.text {
    //
    //            if promoCode == "Hello" {
    //                errorLabel.isHidden = true
    //
    //                hiddenTextField.resignFirstResponder()
    //            } else {
    //                errorLabel.isHidden = false
    //                errorLabel.text = "Такого промокода не существует"
    //            }
    //        }
    //    }
    
    @objc func applyPromoCode() {
        hiddenTextField.resignFirstResponder()
    }
}

extension PromoCodeCell {
    
    func setupViews() {
        contentView.addSubview(promoButton)
        contentView.addSubview(hiddenTextField)
    }
    
    func setupConstraints() {
        promoButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            promoButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            promoButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            promoButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            promoButton.widthAnchor.constraint(equalToConstant: 230),
            promoButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureInputAccessoryView() {
        let accessoryView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 80))
        accessoryView.backgroundColor = .white
        
        let accessoryTextField = UITextField()
        accessoryTextField.placeholder = "Введите промокод"
        accessoryTextField.borderStyle = .roundedRect
        
        let applyButton = UIButton(type: .system)
        applyButton.setTitle("Применить", for: .normal)
        applyButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        applyButton.addTarget(self, action: #selector(applyPromoCode), for: .touchUpInside)
        applyButton.backgroundColor = .systemGray6
        applyButton.layer.cornerRadius = 5
        applyButton.tintColor = .black
        
        accessoryView.addSubview(accessoryTextField)
        accessoryView.addSubview(applyButton)
        accessoryView.addSubview(errorLabel)
        
        accessoryTextField.translatesAutoresizingMaskIntoConstraints = false
        applyButton.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            accessoryTextField.leadingAnchor.constraint(equalTo: accessoryView.leadingAnchor, constant: 8),
            accessoryTextField.topAnchor.constraint(equalTo: accessoryView.topAnchor, constant: 8),
            accessoryTextField.heightAnchor.constraint(equalToConstant: 30),
            
            applyButton.leadingAnchor.constraint(equalTo: accessoryTextField.trailingAnchor, constant: 8),
            applyButton.trailingAnchor.constraint(equalTo: accessoryView.trailingAnchor, constant: -8),
            applyButton.centerYAnchor.constraint(equalTo: accessoryTextField.centerYAnchor),
            applyButton.widthAnchor.constraint(equalToConstant: 100),
            
            errorLabel.topAnchor.constraint(equalTo: accessoryTextField.bottomAnchor, constant: 5),
            errorLabel.leadingAnchor.constraint(equalTo: accessoryView.leadingAnchor, constant: 8),
            errorLabel.trailingAnchor.constraint(equalTo: accessoryView.trailingAnchor, constant: -8)
        ])
        
        //hiddenTextField = accessoryTextField
        hiddenTextField.inputAccessoryView = accessoryView
    }
}
