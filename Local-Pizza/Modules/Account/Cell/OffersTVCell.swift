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
        Offer(title: "Скидка 25% при заказе в пиццерии от 799 р", subtitle: "до 16 Июня", image: UIImage(named: "percentage")),
        Offer(title: "Скидка 20% при заказе от 1049 р", subtitle: "до 16 Июня", image: UIImage(named: "percentage")),
    ]

    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 120)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
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
        contentView.backgroundColor = .white
        contentView.addSubview(collectionView)
    }
    
    func setupConstraints() {
           collectionView.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
               collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
               collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
               collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
           ])
       }
    
    func update(with offers: [Offer]) {
        self.offers = offers
        collectionView.reloadData()
    }
}

extension OffersTVCell: UICollectionViewDelegate, UICollectionViewDataSource {
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
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
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
        contentView.backgroundColor = .white
        [titleLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
        ])
    }
    
    func update(with offer: Offer) {
        titleLabel.text = offer.title
    }
}
