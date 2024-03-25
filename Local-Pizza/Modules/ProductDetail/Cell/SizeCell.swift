//
//  SizeCell.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 26.02.2024.
//

import UIKit

class SizeCell: UITableViewCell {
    
    static let id = "SizeCell"
    
    var onSizeChanged: ((Int) -> Void)?
    
    lazy var segmentedControl: UISegmentedControl = {
        let items = ["Маленькая", "Средняя", "Большая"]
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 2
        control.selectedSegmentTintColor = .white
        control.layer.cornerRadius = 16
        control.layer.masksToBounds = true
        control.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        return control
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
        contentView.addSubview(segmentedControl)
    }
    
    func setupConstraints() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            segmentedControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            segmentedControl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            segmentedControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            segmentedControl.widthAnchor.constraint(equalToConstant: 340)
        
        ])
    }
    
    //MARK: - Action
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        onSizeChanged?(sender.selectedSegmentIndex)
    }
}

