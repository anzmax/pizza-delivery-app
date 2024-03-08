//
//  TotalCell.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 04.03.2024.
//

import UIKit

class TotalCell: UITableViewCell {
    
    static let id = "TotalCell"
    
    lazy var itemLabel: UILabel = {
        let label = UILabel()
        label.text = "2 товара"
        return label
    }()
    
    lazy var itemPrice: UILabel = {
        let label = UILabel()
        label.text = "1 098 р"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    lazy var deliveryLabel: UILabel = {
        let label = UILabel()
        label.text = "Доставка"
        return label
    }()
    
    lazy var deliveryPrice: UILabel = {
        let label = UILabel()
        label.text = "Бесплатно"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.addSubview(itemLabel)
        contentView.addSubview(itemPrice)
        contentView.addSubview(deliveryLabel)
        contentView.addSubview(deliveryPrice)
    }
    
    func setupConstraints() {
        itemLabel.translatesAutoresizingMaskIntoConstraints = false
        itemPrice.translatesAutoresizingMaskIntoConstraints = false
        deliveryLabel.translatesAutoresizingMaskIntoConstraints = false
        deliveryPrice.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            itemLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            itemLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            deliveryLabel.topAnchor.constraint(equalTo: itemLabel.bottomAnchor, constant: 10),
            deliveryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            deliveryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            itemPrice.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            itemPrice.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            deliveryPrice.topAnchor.constraint(equalTo: itemPrice.bottomAnchor, constant: 10),
            deliveryPrice.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            deliveryPrice.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
}

