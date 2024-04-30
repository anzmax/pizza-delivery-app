//
//  TotalCell.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 04.03.2024.
//

import UIKit

final class TotalCell: UITableViewCell {
    
    static let id = "TotalCell"
    
    var itemsInCart: [Product] = []
    
    //MARK: - UI Elements
    lazy var itemLabel = CustomLabel(text: "", color: .black, size: 16, fontWeight: .regular)
    
    lazy var itemPrice = CustomLabel(text: "", color: .black, size: 16, fontWeight: .semibold)

    lazy var deliveryLabel = CustomLabel(text: "Доставка".localized(), color: .black, size: 16, fontWeight: .regular)
    
    lazy var deliveryPrice = CustomLabel(text: "Бесплатно".localized(), color: .black, size: 16, fontWeight: .semibold)

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
            let price = item.totalPrice()
            sum += price * item.count
        }
        return sum
    }
    
    func update(items: [Product]) {
        itemsInCart = items
        itemLabel.text = "\(items.count) \(NSLocalizedString("товара", comment: ""))"
        let totalCount = calculateTotalAmountForProducts()
        let totalCountString = "\(totalCount) р"
        
        convertAndLocalizePrice(rubles: totalCountString, rate: 20) { localizedPrice in
            DispatchQueue.main.async {
                self.itemPrice.text = localizedPrice
            }
        }
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
