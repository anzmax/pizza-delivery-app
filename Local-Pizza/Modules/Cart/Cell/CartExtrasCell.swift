//
//  CartExtrasCell.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 04.03.2024.
//

import UIKit

class CartExtrasCell: UITableViewCell {
    
    static let id = "CartExtrasCell"
    
    lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.app.fill"), for: .normal)
        button.tintColor = .systemGray2
        return button
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.backgroundColor = .systemGray6
        label.layer.cornerRadius = 5
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
        contentView.addSubview(plusButton)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
    }
    
    func setupConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            priceLabel.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor, constant: -10),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            priceLabel.widthAnchor.constraint(equalToConstant: 50),
            
            plusButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            plusButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

extension CartExtrasCell {
    func update(with extra: Extras) {
        nameLabel.text = extra.title
        priceLabel.text = extra.price
    }
}
