//
//  ProductImageCell.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 26.02.2024.
//

import UIKit

final class ProductImageCell: UITableViewCell {
    
    static let id = "ProductImageCell"
    
    lazy var productImageView: UIImageView = {
        let productView = UIImageView()
        productView.image = UIImage(named: "")
        productView.contentMode = .scaleAspectFit
        return productView
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
        contentView.addSubview(productImageView)
    }
    
    func setupConstraints() {
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            productImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            productImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 200),
            productImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}

//MARK: - Update
extension ProductImageCell {
    func update(with product: Product?) {
        productImageView.image = UIImage(named: product!.image)
    }
}
