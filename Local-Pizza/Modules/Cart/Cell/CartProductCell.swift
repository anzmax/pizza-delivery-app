//
//  CartProductCell.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 04.03.2024.
//

import UIKit

final class CartProductCell: UITableViewCell {
    
    static let id = "CartProductCell"
    
    var onProductCountChanged: ((Product) -> Void)?
    
    var basePrice: Int = 0
    var product: Product?
    
    var archiver = ProductsArchiver()
    
    var count = 0 {
        didSet {
            if count > 0 {
                minusButton.isHidden = false
                countLabel.isHidden = false
                countLabel.text = "\(count)"
            } else {
                minusButton.isHidden = true
                countLabel.isHidden = true
            }
        }
    }
    
    //MARK: - UI Elements
    lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pizza2")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Заголовок"
        return label
    }()
    
    var horizontalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.backgroundColor = .systemGray6
        stack.layer.cornerRadius = 5
        stack.clipsToBounds = true
        return stack
    }()
    
    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .black
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(plusButtonTapped(button:)), for: .touchUpInside)
        return button
    }()
    
    lazy var minusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.tintColor = .black
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(minusButtonTapped(button:)), for: .touchUpInside)
        return button
    }()
    
    var countLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.text = "Цена"
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

extension CartProductCell {
    
    //MARK: - Update
    func update(with product: Product) {
        self.product = product
        itemImageView.image = UIImage(named: product.image)
        titleLabel.text = product.title.localized()
        
        basePrice = product.totalPrice()
        
        count = product.count
        updatePriceLabel()
    }
    
    func updatePriceLabel() {
        let totalPrice = basePrice * Int(count)
        let totalPriceString = "\(totalPrice) р"
        
        convertAndLocalizePrice(rubles: totalPriceString, rate: 20) { localizedPrice in
            self.priceLabel.text = localizedPrice
        }
    }
    
    //MARK: - Actions
    @objc func plusButtonTapped(button: UIButton) {
        count += 1
        updatePriceLabel()
        
        product?.count = count
        if let product = product {
            onProductCountChanged?(product)
        }
    }
    
    @objc func minusButtonTapped(button: UIButton) {
        count -= 1
        updatePriceLabel()
        product?.count = count
        if let product = product {
            onProductCountChanged?(product)
        }
    }
}

//MARK: - Layout
extension CartProductCell {
    func setupViews() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        
        [itemImageView, titleLabel, priceLabel, horizontalStackView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [minusButton, countLabel, plusButton].forEach {
            horizontalStackView.addArrangedSubview($0)
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            itemImageView.widthAnchor.constraint(equalToConstant: 100),
            itemImageView.heightAnchor.constraint(equalToConstant: 100),
            itemImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            itemImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            itemImageView.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: -12),
            
            titleLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: itemImageView.centerYAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: 30),
            priceLabel.centerXAnchor.constraint(equalTo: itemImageView.centerXAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant:  -10),
            
            horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            horizontalStackView.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor),
            horizontalStackView.heightAnchor.constraint(equalToConstant: 30),
            horizontalStackView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
