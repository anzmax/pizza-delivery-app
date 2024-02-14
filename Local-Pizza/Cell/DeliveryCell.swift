//
//  DeliveryCell.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 12.02.2024.
//

import UIKit

class DeliveryCell: UITableViewCell {
    
    static let id = "DeliveryCell"
    
    lazy var segmentedControl: UISegmentedControl = {
        let items = ["Доставка", "В пиццерии"]
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 1
        control.selectedSegmentTintColor = .white
        control.layer.cornerRadius = 16
        control.layer.masksToBounds = true
        return control
    }()
    
    private lazy var addressButton: UIButton = {
        let button = UIButton()
        button.setTitle("Указать адрес доставки »", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return button
    }()
    
    private lazy var vStackView: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .systemGray5.withAlphaComponent(0.3)
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .center
        stack.layer.cornerRadius = 16
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Layout
extension DeliveryCell {
    func setupViews() {
        contentView.backgroundColor = .white
        contentView.addSubview(vStackView)
        vStackView.addArrangedSubview(segmentedControl)
        vStackView.addArrangedSubview(addressButton)
    }
    
    func setupConstraints() {
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            vStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            vStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            vStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
        ])
    }
}
