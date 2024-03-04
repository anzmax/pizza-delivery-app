//
//  LogoutCell.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 01.03.2024.
//

import UIKit

class LogoutCell: UITableViewCell {
    
    static let id = "LogoutCell"
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Выйти из профиля"
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
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
        contentView.addSubview(titleLabel)
    }
    
    func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
    }
}

