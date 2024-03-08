//
//  ExtrasTVCell.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 08.03.2024.
//

import UIKit

class ExtrasTVCell: UITableViewCell {
    
    static let id = "ExtrasTVCell"
    
    var allProducts: [Product] = []
    
    var filteredProducts: [Product] {
        return allProducts.filter { product in
            product.image.contains("dessert") || product.image.contains("drink")
        }
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 110, height: 190)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collection.delegate = self
        collection.dataSource = self
        collection.register(ExtrasCVCell.self, forCellWithReuseIdentifier: ExtrasCVCell.id)
        return collection
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
        contentView.addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    func update(with products: [Product]) {
        self.allProducts = products
        collectionView.reloadData()
    }
}

extension ExtrasTVCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExtrasCVCell.id, for: indexPath) as! ExtrasCVCell
        let product = filteredProducts[indexPath.row]
        cell.update(with: product)
        return cell
    }
}

class ExtrasCVCell: UICollectionViewCell {
    
    static let id = "ExtrasCVCell"
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Название"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    lazy var priceButton: UIButton = {
        let button = UIButton()
        button.setTitle("Цена", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 5
        return button
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pizzaSpecial")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceButton)
        contentView.addSubview(imageView)
    }
    
    func setupContentView() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        contentView.layer.masksToBounds = false
        contentView.layer.shadowColor = UIColor.gray.cgColor
        contentView.layer.shadowOpacity = 0.4
        contentView.layer.shadowOffset = CGSize(width: 2, height: 4)
        contentView.layer.shadowRadius = 4
    }
    
    func update(with product: Product) {
        titleLabel.text = product.title
        priceButton.setTitle(product.price, for: .normal)
        imageView.image = UIImage(named: product.image)
    }
    
    func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        priceButton.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -190),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            priceButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            priceButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            priceButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            priceButton.widthAnchor.constraint(equalToConstant: 60),
            priceButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
