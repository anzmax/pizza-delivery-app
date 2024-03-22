//
//  NotificationsCell.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 01.03.2024.
//

import UIKit

class NotificationsCell: UITableViewCell {
    
    static let id = "NotificationsCell"
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Включить уведомления"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Push-notifications, e-mail, SMS"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    lazy var switchControl: UISwitch = {
        let switchControl = UISwitch()
        switchControl.onTintColor = .gray
        switchControl.addTarget(self, action: #selector(switchControllTapped), for: .valueChanged)
        return switchControl
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
    
    
    //MARK: - Action
    @objc func switchControllTapped(_ switchControl: UISwitch) {
        
        UserDefaults.standard.set(switchControl.isOn, forKey: "notificationsSwitchIsOn")
        
        if switchControl.isOn {
            NotificationService.shared.requestAuthorization()
            NotificationService.shared.scheduleDailyNotification(at: 21, minute: 18)
        } else {
            NotificationService.shared.cancelDailyNotifications()
        }
    }
}

//MARK: - Layout
extension NotificationsCell {
    func setupViews() {
        self.backgroundColor = .clear
        contentView.addSubview(customView)
        contentView.applyShadow(color: .systemGray2)
        [titleLabel, subtitleLabel, switchControl].forEach {
            customView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let switchIsOn = UserDefaults.standard.bool(forKey: "notificationsSwitchIsOn")
        switchControl.isOn = switchIsOn
    }
    
    func setupConstraints() {
        customView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: contentView.topAnchor),
            customView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            customView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 1),
            customView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -1),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            switchControl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            switchControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            switchControl.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}
