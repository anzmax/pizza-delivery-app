//
//  IngredientsTVCell.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 26.02.2024.
//

import UIKit

final class IngredientsTVCell: UITableViewCell {
    
    static let id = "IngredientsTVCell"
    
    var ingredients: [Ingredient] = []
    var onSelectIngredientCell: ((Ingredient)->())?
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Добавить по вкусу".localized()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let edgeInsets: CGFloat = 20
        let interitemSpacing: CGFloat = 20
        let totalSpacing = (2 * edgeInsets) + (2 * interitemSpacing)
        let itemWidth = (UIScreen.main.bounds.width - totalSpacing) / 3
        
        layout.itemSize = CGSize(width: itemWidth, height: 180)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = interitemSpacing
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .white
        collection.showsVerticalScrollIndicator = false
        collection.allowsMultipleSelection = true
        
        collection.contentInset = UIEdgeInsets(top: 5, left: edgeInsets, bottom: 10, right: edgeInsets)
        collection.delegate = self
        collection.dataSource = self
        collection.register(IngredientCVCell.self, forCellWithReuseIdentifier: IngredientCVCell.id)
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
        [descriptionLabel, collectionView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            collectionView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
    //MARK: - Update
    func update(with ingredients: [Ingredient]) {
        self.ingredients = ingredients
        collectionView.reloadData()
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension IngredientsTVCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        ingredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IngredientCVCell.id, for: indexPath) as! IngredientCVCell
        let inrgedient = ingredients[indexPath.item]
        cell.update(with: inrgedient)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let isSelected = ingredients[indexPath.item].isSelected ?? false
        
        ingredients[indexPath.item].isSelected = !isSelected
        
        let ingredient = ingredients[indexPath.item]
        
        onSelectIngredientCell?(ingredient)
    }
}

final class IngredientCVCell: UICollectionViewCell {
    
    static let id = "IngredientCVCell"
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = .white
        contentView.applyShadow(color: .lightGray)
        [imageView, titleLabel, priceLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 14),
            priceLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
            
        ])
    }
    
    //MARK: - Update
    func update(with ingredient: Ingredient) {
        
        let isSelected = ingredient.isSelected ?? false
        
        if isSelected == true {
            contentView.applyShadow(color: .black)
        } else {
            contentView.applyShadow(color: .lightGray)
        }
        
        imageView.image = UIImage(named: ingredient.image)
        titleLabel.text = ingredient.title.localized()
        
        convertAndLocalizePrice(rubles: ingredient.price, rate: 20) { localizedPrice in
            DispatchQueue.main.async {
                self.priceLabel.text = localizedPrice
            }
        }
    }
}

