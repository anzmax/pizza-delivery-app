//
//  ExtrasTVCell.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 08.03.2024.
//

import UIKit

final class ExtrasTVCell: UITableViewCell {
    
    static let id = "ExtrasTVCell"
    
    var allProducts: [Product] = []
    
    var onPriceButtonTapped: ((Product)->())?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 110, height: 170)
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
}

//MARK: - Update TV Cell
extension ExtrasTVCell {
    func update(with products: [Product]) {
        self.allProducts = products
        collectionView.reloadData()
    }
}

//MARK: - Delegate
extension ExtrasTVCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(allProducts.count)
        return allProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExtrasCVCell.id, for: indexPath) as! ExtrasCVCell
        let product = allProducts[indexPath.item]
        cell.update(with: product)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let product = allProducts[indexPath.row]
        
        onPriceButtonTapped?(product)
    }
}

//MARK: - Layout TC Cell
extension ExtrasTVCell {
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
}

class ExtrasCVCell: UICollectionViewCell {
    
    static let id = "ExtrasCVCell"
    
    //MARK: - UI Elements
    lazy var titleLabel = CustomLabel(text: "", color: .black, size: 14, fontWeight: .light)
    
    lazy var priceButton: UIButton = {
        let button = UIButton()
        button.setTitle("Цена", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 5
        button.isUserInteractionEnabled = false
        return button
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pizzaSpecial")
        imageView.contentMode = .scaleAspectFit
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
}

//MARK: - Update CV Cell
extension ExtrasCVCell {
    func update(with product: Product) {
        titleLabel.text = product.title.localized()
        imageView.image = UIImage(named: product.image)
        
        convertAndLocalizePrice(rubles: product.price, rate: 20) { localizedPrice in
            self.priceButton.setTitle(localizedPrice, for: .normal)
        }
    }
}

//MARK: - Layout CV Cell
extension ExtrasCVCell {
    
    func setupViews() {
        [titleLabel, priceButton, imageView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
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
    
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -190),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            priceButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            priceButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            priceButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            priceButton.widthAnchor.constraint(equalToConstant: 60),
            priceButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
