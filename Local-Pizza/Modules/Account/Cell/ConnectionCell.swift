//
//  ConnectionCell.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 18.03.2024.
//

import UIKit

class ConnectionCell: UITableViewCell {
    
    static let id = "ConnectionCell"
    
    lazy var customImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "")
        imageView.tintColor = .gray
        return imageView
    }()
    
    lazy var connectionLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        return label
    }()
    
    lazy var customView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 12
        view.applyShadow(color: .lightGray)
        view.layer.masksToBounds = true
        return view
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
    func update(with connection: Connection) {
        connectionLabel.text = connection.title
        customImageView.image = connection.image
    }
    
}

//MARK: - Layout
extension ConnectionCell {
    func setupViews() {
        self.backgroundColor = .clear
        contentView.addSubview(customView)
        [connectionLabel, customImageView].forEach {
            customView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupConstraints() {
        customView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: contentView.topAnchor),
            customView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            customView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            customImageView.topAnchor.constraint(equalTo: customView.topAnchor, constant: 10),
            customImageView.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 10),
            customImageView.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -10),
            customImageView.widthAnchor.constraint(equalToConstant: 20),
            customImageView.heightAnchor.constraint(equalToConstant: 20),

            connectionLabel.topAnchor.constraint(equalTo: customView.topAnchor, constant: 10),
            connectionLabel.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 10),
            connectionLabel.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -10)
        ])
    }
}
