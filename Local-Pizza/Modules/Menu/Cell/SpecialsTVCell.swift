//
//  SpecialsTVCell.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 13.02.2024.
//

import UIKit

class SpecialsTVCell: UITableViewCell {
    
    static let id = "SpecialsTVCell"
    
    var specials: [Special] = []
    
    private var specialLabel: UILabel = {
        let label = UILabel()
        label.text = "Выгодно и вкусно".localized()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 190, height: 100)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.delegate = self
        collection.dataSource = self
        collection.register(SpecialCVCell.self, forCellWithReuseIdentifier: SpecialCVCell.id)
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
    
    //MARK: - Update
    func update(with specials: [Special]) {
        self.specials = specials
        collectionView.reloadData()
    }
}

class SpecialCVCell: UICollectionViewCell {
    
    static let id = "SpecialCVCell"
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    lazy var priceButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 5
        return button
    }()
    
    lazy var specialImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pizzaSpecial")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupContentView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Update
    func update(with specials: Special) {
        titleLabel.text = specials.title.localized()
        
        convertAndLocalizePrice(rubles: specials.price, rate: 20) { localizedPrice in
            self.priceButton.setTitle(localizedPrice, for: .normal)
        }
        specialImageView.image = UIImage(named: specials.image)
    }
}

//MARK: - Delegate
extension SpecialsTVCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        specials.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SpecialCVCell.id, for: indexPath) as! SpecialCVCell
        let special = specials[indexPath.item]
        cell.update(with: special)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}

//MARK: - Layout
extension SpecialsTVCell {
    func setupViews() {
        contentView.addSubview(specialLabel)
        contentView.addSubview(collectionView)
    }
    
    func setupConstraints() {
        specialLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            specialLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            specialLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            collectionView.topAnchor.constraint(equalTo: specialLabel.bottomAnchor, constant: 12),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

extension SpecialCVCell {
    func setupViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceButton)
        contentView.addSubview(specialImageView)
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
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        priceButton.translatesAutoresizingMaskIntoConstraints = false
        specialImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            specialImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            specialImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            specialImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            specialImageView.widthAnchor.constraint(equalToConstant: 80),
            specialImageView.heightAnchor.constraint(equalToConstant: 80),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: specialImageView.trailingAnchor, constant: 24),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
            
            priceButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            priceButton.leadingAnchor.constraint(equalTo: specialImageView.trailingAnchor, constant: 24),
            priceButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            priceButton.widthAnchor.constraint(equalToConstant: 55)
        ])
    }
}
