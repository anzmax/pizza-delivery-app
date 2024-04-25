//
//  ProductsTVCell.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 14.02.2024.
//

import UIKit

class ProductCell: UITableViewCell {
    
    static let id = "ProductCell"
    
    var onPriceButtonTapped: ((Product)->())?
    var onFavouriteButtonTapped: ((Product) ->())?
    
    var product: Product?
    
    // MARK: - UI Elements
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    lazy var priceButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 5
        button.applyShadow(color: .lightGray)
        button.addTarget(self, action: #selector(priceButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var favouriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.tintColor = .systemGray2
        button.addTarget(self, action: #selector(favouriteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Update
    func update(with product: Product) {
        self.product = product
        productImageView.image = UIImage(named: product.image)
        titleLabel.text = product.title.localized()
        descriptionLabel.text = product.description.localized()
        
        convertAndLocalizePrice(rubles: product.price, rate: 20) { localizedPrice in
            self.priceButton.setTitle(localizedPrice, for: .normal)
        }
        //priceButton.setTitle(product.price, for: .normal)
    }
    
}

//MARK: - Layout
extension ProductCell {
    private func setupViews() {
        [productImageView, titleLabel, descriptionLabel, priceButton, favouriteButton].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            productImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 110),
            productImageView.heightAnchor.constraint(equalToConstant: 110),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            priceButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            priceButton.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10),
            priceButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            priceButton.widthAnchor.constraint(equalToConstant: 75),
            
            favouriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            favouriteButton.centerYAnchor.constraint(equalTo: priceButton.centerYAnchor)
        ])
    }
    
    //MARK: - Action
    @objc func priceButtonTapped(_ button: UIButton) {
        
        let originalColor = button.backgroundColor
        button.backgroundColor = .systemGray3

        UIView.animate(withDuration: 1, animations: {
            button.backgroundColor = originalColor
        })
        
        if let product = product {
            onPriceButtonTapped?(product)
        }
    }
    
    @objc func favouriteButtonTapped(_ button: UIButton) {
        if let product = product {
            onFavouriteButtonTapped?(product)

            let currentImage = button.image(for: .normal)
            let starImage = UIImage(systemName: "star")
            let starFillImage = UIImage(systemName: "star.fill")
            
            if currentImage == starImage {
                button.setImage(starFillImage, for: .normal)
            } else {
                button.setImage(starImage, for: .normal)
                button.tintColor = .systemGray2
            }
        }
    }
}

