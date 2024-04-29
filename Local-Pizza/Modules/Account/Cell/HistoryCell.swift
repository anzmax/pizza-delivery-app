//
//  HistoryTVCell.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 18.03.2024.
//

import UIKit

final class HistoryCell: UITableViewCell {
    
    static let id = "HistoryCell"
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "20.03.2024"
        return label
    }()
    
    lazy var customView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.8)
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var orderButton: UIButton = {
        let button = UIButton()
        button.setTitle("Повторить".localized(), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 5
        button.applyShadow(color: .darkGray)
        button.addTarget(self, action: #selector(orderButtonTapped), for: .touchUpInside)
        return button
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
        [orderButton, titleLabel].forEach {
            customView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupConstraints() {
        customView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: contentView.topAnchor),
            customView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            customView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 1),
            customView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -1),
            
            orderButton.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -10),
            orderButton.centerYAnchor.constraint(equalTo: customView.centerYAnchor),
            orderButton.widthAnchor.constraint(equalToConstant: 100),
            
            titleLabel.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: customView.centerYAnchor)
        ])
    }
    
    @objc func orderButtonTapped(_ button: UIButton) {
        let originalColor = button.backgroundColor
        button.backgroundColor = .systemGray3
        
        UIView.animate(withDuration: 1, animations: {
            button.backgroundColor = originalColor
        })
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let formattedDate = dateFormatter.string(from: Date())
        titleLabel.text = formattedDate
    }
}
