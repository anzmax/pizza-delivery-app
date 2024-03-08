//
//  CartProductCell.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 04.03.2024.
//

import UIKit

class CartProductCell: UITableViewCell {
    
    static let id = "CartProductCell"
    
    var basePrice: Int = 0
    
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
    
    func setupViews() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.addSubview(itemImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(horizontalStackView)
        
        horizontalStackView.addArrangedSubview(minusButton)
        horizontalStackView.addArrangedSubview(countLabel)
        horizontalStackView.addArrangedSubview(plusButton)
    }
    
    func setupConstraints() {
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
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

extension CartProductCell {
    
    func update(with product: Product) {
        itemImageView.image = UIImage(named: product.image)
        titleLabel.text = product.title
        
        let priceString = product.price.replacingOccurrences(of: " р", with: "")
        basePrice = Int(priceString) ?? 0
        
        count = 1
        updatePriceLabel()
    }
    
    func updatePriceLabel() {
        let totalPrice = basePrice * Int(count)
        priceLabel.text = "\(totalPrice) р"
    }
    
    
    //MARK: - Actions
    @objc func plusButtonTapped(button: UIButton) {
        count += 1
        updatePriceLabel()
    }
    
    @objc func minusButtonTapped(button: UIButton) {
        if count > 1 {
            count -= 1
            updatePriceLabel()
        }
    }
}
