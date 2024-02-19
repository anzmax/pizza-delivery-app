//
//  ProductsTVCell.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 14.02.2024.
//

import UIKit

class ProductCell: UITableViewCell {
    
    static let id = "ProductCell"
    
    // MARK: - UI Elements
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
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
        label.font = UIFont.systemFont(ofSize: 14)
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
        return button
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        contentView.addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        
    }
    
    // MARK: - Update
    func update(with product: Product) {
        productImageView.image = UIImage(named: product.image)
        titleLabel.text = product.title
        descriptionLabel.text = product.description
        priceButton.setTitle(product.price, for: .normal)
    }
}

//MARK: - Layout
extension ProductCell {
    private func setupViews() {
        contentView.addSubview(productImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(priceButton)
    }
    
    private func setupConstraints() {
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        priceButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            productImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
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
            priceButton.widthAnchor.constraint(equalToConstant: 75)
        ])
    }
}
