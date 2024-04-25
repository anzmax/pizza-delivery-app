//
//  DoughCell.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 26.02.2024.
//

import UIKit

class DoughCell: UITableViewCell {
    
    static let id = "DoughCell"
    
    var onDoughChanged: ((Int)->Void)?
    
    lazy var segmentedControl: UISegmentedControl = {
        let items = ["Традиционное".localized(), "Тонкое".localized()]
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
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
            segmentedControl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            segmentedControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            segmentedControl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            segmentedControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            segmentedControl.widthAnchor.constraint(equalToConstant: 350)
        ])
    }
    
    //MARK: - Action
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        onDoughChanged?(sender.selectedSegmentIndex)
    }
}

