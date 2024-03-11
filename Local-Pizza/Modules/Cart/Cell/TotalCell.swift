//
//  TotalCell.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 04.03.2024.
//

import UIKit

class TotalCell: UITableViewCell {
    
    static let id = "TotalCell"
    
    var itemsInCart: [Product] = []
    
    //MARK: - UI Elements
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
}

//MARK: - Update
extension TotalCell {
    
    func calculateTotalAmountForProducts() -> Int {
        var sum = 0
        for item in itemsInCart {
            let price = Int(item.price.replacingOccurrences(of: " р", with: "")) ?? 0
            sum += price * item.count
        }
        return sum
    }
    
    func update(items: [Product]) {
        
        itemsInCart = items
        
        itemLabel.text = "\(String(items.count)) товара"
        
        let totalCount = calculateTotalAmountForProducts()
        
        itemPrice.text = "\(String(totalCount)) р"
    }
}

//MARK: - Layout
extension TotalCell {
    
    func setupViews() {
        [itemLabel, itemPrice, deliveryLabel, deliveryPrice].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            itemLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            itemLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            itemPrice.centerYAnchor.constraint(equalTo: itemLabel.centerYAnchor),
            itemPrice.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            deliveryLabel.topAnchor.constraint(equalTo: itemLabel.bottomAnchor, constant: 10),
            deliveryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            deliveryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            deliveryPrice.centerYAnchor.constraint(equalTo: deliveryLabel.centerYAnchor),
            deliveryPrice.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            deliveryPrice.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
    }
}
