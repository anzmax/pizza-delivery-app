//
//  LogoutCell.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 01.03.2024.
//

import UIKit

final class LogoutCell: UITableViewCell {
    
    static let id = "LogoutCell"
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Выйти из профиля".localized()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    lazy var customView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.8)
        view.layer.cornerRadius = 12
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
    
    func setupViews() {
        self.backgroundColor = .clear
        contentView.applyShadow(color: .systemGray2)
        contentView.addSubview(customView)
        customView.addSubview(titleLabel)
    }
    
    func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        customView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            customView.topAnchor.constraint(equalTo: contentView.topAnchor),
            customView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            customView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 1),
            customView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -1),
            
            titleLabel.topAnchor.constraint(equalTo: customView.topAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -16),
            titleLabel.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 16)
        ])
    }
}

