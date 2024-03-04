//
//  PersonalCell.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 01.03.2024.
//

import UIKit

class PersonalCell: UITableViewCell {

    static let id = "PersonalCell"
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    lazy var infoTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.placeholder = ""
        textField.textAlignment = .left
        textField.keyboardType = .default
        textField.tintColor = .gray
        return textField
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
        contentView.addSubview(infoTextField)
    }
    
    func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        infoTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            infoTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            infoTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            infoTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            infoTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func update(with info: PersonalInfo) {
        titleLabel.text = info.title
    }
}

