//
//  StoriesCell.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 12.02.2024.
//

import UIKit

protocol StoriesTVCellDelegate: AnyObject {
    func didSelectStoryImage(_ image: UIImage?)
}

class StoriesTVCell: UITableViewCell {

    static let id = "StoriesCell"
    
    weak var delegate: StoriesTVCellDelegate?

    var stories: [Story] = []

    private lazy var collectionView: UICollectionView = {
        let layout = CenterZoomCollectionViewLayout()
        layout.itemSize = CGSize(width: 85, height: 110)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 14
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(StoryCVCell.self, forCellWithReuseIdentifier: StoryCVCell.id)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.addSubview(collectionView)
        contentView.layer.cornerRadius = 16
        contentView.clipsToBounds = true
    }
    
    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    //MARK: - Update
    func update(with stories: [Story]) {
        self.stories = stories
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension StoriesTVCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryCVCell.id, for: indexPath) as! StoryCVCell
        let story = stories[indexPath.row]
        cell.update(with: story)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let story = stories[indexPath.row]
        delegate?.didSelectStoryImage(UIImage(named: story.image))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}

class StoryCVCell: UICollectionViewCell {
    
    static let id = "StoryCVCell"
    
    private var storyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        contentView.addSubview(storyImageView)
    }
    
    private func setupConstraints() {
        storyImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            storyImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            storyImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            storyImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            storyImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    //MARK: - Update
    func update(with story: Story) {
        storyImageView.image = UIImage(named: story.image)
    }
}
