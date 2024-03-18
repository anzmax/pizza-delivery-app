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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        [connectionLabel, customImageView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            customImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            customImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            customImageView.widthAnchor.constraint(equalToConstant: 20),
            customImageView.heightAnchor.constraint(equalToConstant: 20),

            connectionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            connectionLabel.leadingAnchor.constraint(equalTo: customImageView.trailingAnchor, constant: 10),
            connectionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func update(with connection: Connection) {
        connectionLabel.text = connection.title
        customImageView.image = connection.image
    }
    
}
