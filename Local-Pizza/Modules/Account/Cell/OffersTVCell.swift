//
//  OffersTVCell.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 18.03.2024.
//

import UIKit

class OffersTVCell: UITableViewCell {
    
    static let id = "OffersTVCell"
    
    var offers: [Offer] = [
        Offer(title: "Скидка 25% в пиццерии от 799 р",
              subtitle: "до 16 июня"),
        Offer(title: "Скидка 20% при заказе от 1049 р", 
              subtitle: "до 18 августа"),
    ]
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 30, height: 120)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = false
        collection.layer.cornerRadius = 12
        collection.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        collection.delegate = self
        collection.dataSource = self
        collection.register(OffersCVCell.self, forCellWithReuseIdentifier: OffersCVCell.id)
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
        self.backgroundColor = .clear
        contentView.addSubview(collectionView)
    }
    
    
    func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 130)
            
        ])
    }
    
    func update(with offers: [Offer]) {
        self.offers = offers
        collectionView.reloadData()
    }
}

extension OffersTVCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        offers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OffersCVCell.id, for: indexPath) as! OffersCVCell
        let offer = offers[indexPath.row]
        cell.update(with: offer)
        return cell
    }
}

class OffersCVCell: UICollectionViewCell {
    
    static let id = "OffersCVCell"
    
    lazy var percentageImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "percentage")
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return label
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
        [titleLabel, subtitleLabel, percentageImageView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupContentView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = contentView.bounds
        gradientLayer.cornerRadius = 12
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.systemGray4.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)

        contentView.layer.insertSublayer(gradientLayer, at: 0)
        contentView.applyShadow(color: .darkGray)
//        contentView.layer.shadowColor = UIColor.black.cgColor
//        contentView.layer.shadowOpacity = 0.2
//        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
//        contentView.layer.shadowRadius = 4
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
            
            percentageImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            percentageImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            percentageImageView.heightAnchor.constraint(equalToConstant: 50),
            percentageImageView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func update(with offer: Offer) {
        titleLabel.text = offer.title
        subtitleLabel.text = offer.subtitle
    }
}
